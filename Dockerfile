FROM bellsoft/liberica-openjdk-alpine:21 AS builder
WORKDIR /builder
COPY .mvn .mvn
COPY mvnw mvnw
COPY pom.xml pom.xml
RUN sed -i 's/\r$//' mvnw # For windows os
RUN ./mvnw -fn clean verify
COPY src src
RUN ./mvnw package
RUN mv target/*.jar application.jar
RUN java -Djarmode=tools -jar application.jar extract --layers --destination extracted

FROM bellsoft/liberica-runtime-container:jre-21-cds-slim-glibc
WORKDIR /application
COPY --from=builder /builder/extracted/dependencies/ ./
COPY --from=builder /builder/extracted/spring-boot-loader/ ./
COPY --from=builder /builder/extracted/snapshot-dependencies/ ./
COPY --from=builder /builder/extracted/application/ ./
ENTRYPOINT ["java", "-jar", "application.jar"]