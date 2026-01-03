FROM maven:3.8.3-openjdk-17 AS builder
#Adding a comment to perform a test

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline 

COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-alpine

COPY --from=builder /app/target/*.jar /app/expenseapp.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/expenseapp.jar"]
  
