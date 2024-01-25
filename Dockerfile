FROM gradle:jdk17-alpine AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon 

FROM amazoncorretto:8-alpine3.17-jre
COPY --from=build /home/gradle/src/build/libs/*.jar /app/iptv-proxy.jar
ENTRYPOINT ["java", "-jar", "build/libs/iptv-proxy-all.jar" "-Dconfig=/config/config.yml"]
