FROM java:8-jdk

MAINTAINER Lorgio Trinidad <lorgiotrinidad@gmail.com>

ENV WIREMOCK_VERSION 2.4.1

#Grab wiremock standalone jar
RUN mkdir -p /var/wiremock/lib/ \
  && wget https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/${WIREMOCK_VERSION}/wiremock-standalone-$WIREMOCK_VERSION.jar \
    -O /var/wiremock/lib/wiremock-standalone.jar
RUN mkdir /home/wiremock
RUN cp /var/wiremock/lib/wiremock-standalone.jar /home/wiremock/

WORKDIR /home/wiremock

COPY docker-entrypoint.sh /
COPY stubs/** __files/
COPY resource/** mappings/
#COPY /home/wiremock/data/** __files/

#VOLUME /home/wiremock/data
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "wiremock-standalone.jar"]