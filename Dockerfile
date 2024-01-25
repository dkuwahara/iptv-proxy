FROM amazoncorretto:17-alpine
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN ./gradlew build --no-daemon 
WORKDIR /config
ENTRYPOINT java -jar /home/gradle/src/build/libs/iptv-proxy-all.jar -Dconfig=/config/config.yml
