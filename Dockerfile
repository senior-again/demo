FROM gradle:jdk17-alpine AS build

WORKDIR /app

COPY build.gradle settings.gradle ./

RUN gradle dependencies --no-daemon

COPY . /app

RUN gradle clean build --no-daemon

FROM openjdk:17-slim

WORKDIR /app

COPY --from=build /app/build/libs/*.jar /app/demo.jar

EXPOSE 8080
ENTRYPOINT ["java"]
CMD ["-jar","demo.jar"]