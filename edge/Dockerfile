FROM java:8
VOLUME /tmp
ADD target/edge-0.0.1-SNAPSHOT.jar app.jar
RUN bash -c 'touch /app.jar'
EXPOSE 8761
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
#CMD /usr/bin/java -Xmx400m -Xms400m -jar /app.jar
