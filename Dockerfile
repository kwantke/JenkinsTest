FROM gradle:jdk17-alpine as builder
WORKDIR /build

COPY build.gradle settings.gradle /build/
RUN gradle build -x test --parallel > /dev/null 2>&1 || true

COPY . /build
RUN gradle build -x test --parallel

FROM openjdk:17-jdk-alpine

# Add a non-root user and group
#RUN addgroup -S -g 1024 kevin && \
#    adduser -S -u 1024 -G kevin kevin

RUN addgroup -S -g 1000 kevin && \
    adduser -S -u 1000 -G kevin kevin && \
    mkdir /app && \
    chown -R kevin:kevin /app

WORKDIR /app
COPY --from=builder /build/build/libs/*-0.0.1-SNAPSHOT.jar /app/app.jar

#RUN chmod +x /app/api-0.0.1-SNAPSHOT.jar

#RUN ls -l /app

#RUN chown -R kevin:kevin /app

USER kevin


EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
