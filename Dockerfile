FROM openjdk:8-jdk-alpine
WORKDIR /cgi
COPY target/cgi-devops-api-project-0.0.1-SNAPSHOT.war /cgi/devops-demo.war
EXPOSE 8080
CMD ["java", "-jar", "/cgi/devops-demo.war"]

