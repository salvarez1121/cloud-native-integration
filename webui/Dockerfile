# Use an official JDK image
FROM maven:3.8-openjdk-18 as BUILD

# Copy the application source code
COPY src /usr/src/app/src
COPY docs /usr/src/app/docs
COPY pom.xml /usr/src/app

# Run maven to build the application
RUN mvn -f /usr/src/app/pom.xml clean package 

FROM openjdk:19-jdk-alpine3.16

COPY --from=BUILD /usr/src/app/target/test-infinite-scale-0.0.1-SNAPSHOT.jar /app.jar
COPY docs /docs

CMD ["java", "-jar", "/app.jar"]
