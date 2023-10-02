# This is multistage docker image build

# stage 1: downloads dependencies, compiles the target application, outputs: demoapp.jar
# use maven:3.9.0-eclipse-temurin-17 as build image
FROM maven:3.9.0-eclipse-temurin-17 as build
# set /app as working directory
WORKDIR /app
# copy the contents of the current directory to /app in build
COPY . .
# Compile the application
RUN 'mvn clean install'


# Stage 2: Get the jar file from build, expose port 8080 and start the application.
# use clipse-temurin:17.0.6_10-jdk as the run env
FROM eclipse-temurin:17.0.6_10-jdk
# set /app as working directory
WORKDIR /app
# copy the compiled jar from build image to /app in current image
COPY from=build /app/target/demoapp.jar /app/
# expose port 8080
EXPOSE 8080
# run the application.
CMD [ "java", '-jar', 'demoapp.jar' ]