# Use AdoptOpenJDK as base image
FROM adoptopenjdk:11-jdk-hotspot

# Install Maven and other required packages
RUN apt-get update \
    && apt-get install -y maven

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the Maven project file
COPY pom.xml .

# Download dependencies and build the application
RUN mvn dependency:go-offline

# Copy the source code into the container
COPY calculator-app/src /usr/src/app/src

# Build the application
RUN mvn -X package

COPY ./usr/src/app/target/calculator-app-1.0-SNAPSHOT.jar ./calculator-app.jar

# Expose port 9080
EXPOSE 9080

# Run the application
CMD ["java", "-jar", "./calculator-app.jar"]

