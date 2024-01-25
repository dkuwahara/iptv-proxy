FROM gradle:jdk17-alpine AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN ./gradlew build --no-daemon 

FROM amazoncorretto:17-alpine
COPY --from=build /home/gradle/src/build/libs/*.jar /app/iptv-proxy.jar
ENTRYPOINT java -jar /app/iptv-proxy.jar -Dconfig=/config/config.yml
