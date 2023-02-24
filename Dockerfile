FROM bellsoft/liberica-openjdk-alpine:19 as builder
WORKDIR application
COPY .mvn .mvn
COPY mvnw mvnw
COPY pom.xml pom.xml
RUN ./mvnw -fn clean verify
COPY src src
RUN ./mvnw package
RUN java -Djarmode=layertools -jar target/*.jar extract

FROM bellsoft/liberica-openjre-alpine:19
WORKDIR application
COPY --from=builder application/dependencies/ ./
COPY --from=builder application/spring-boot-loader/ ./
COPY --from=builder application/snapshot-dependencies/ ./
COPY --from=builder application/application/ ./
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]