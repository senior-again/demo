# Dockerfile
# gradle && jdk17 이미지 빌드 - build 별명
FROM gradle:jdk17-alpine AS build

# 작업 디렉토리 /app 생성
WORKDIR /app

# 빌드하는데 필요한 build.gradle, settings.gradle 파일 현재 디렉토리로 복사
COPY build.gradle settings.gradle ./

# 외부라이브러리 빌드
RUN gradle dependencies --no-daemon

# 소스코드파일 /app 작업 디렉토리로 복사
COPY . /app

# Gradle 빌드를 실행하여 JAR 파일 생성
RUN gradle clean build --no-daemon

FROM openjdk:17-slim

WORKDIR /app

# 빌드 이미지에서 생성된 JAR 파일을 런타임 이미지로 복사
COPY --from=build /app/build/libs/*.jar /app/demo.jar

EXPOSE 8080
ENTRYPOINT ["java"]
CMD ["-jar","demo.jar"]