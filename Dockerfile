# Use AdoptOpenJDK as base image
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the Maven project file
COPY pom.xml .

# Download dependencies and build the application
RUN mvn dependency:go-offline

# Copy the source code into the container
COPY src ./src

# Build the application
RUN mvn package

# Expose port 9080
EXPOSE 9080

# Run the application
CMD ["java", "Calculator"]

