# First stage: build the application with Maven
FROM maven:3.8.3-openjdk-17 as build
            
WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src/ /app/src/

RUN mvn package

#Second stage copy jar file and Run
#Below images contains only jvm which will be used to run the jar from the first stage 
FROM openjdk:17-jdk-slim 

WORKDIR /app
COPY --from=build /app/target/api-0.0.1-SNAPSHOT.jar .
EXPOSE 8080

CMD ["java", "-jar", "app/target/api-0.0.1-SNAPSHOT.jar"]
