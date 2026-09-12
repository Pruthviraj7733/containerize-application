FROM ubuntu:latest

#Install required packages
RUN apt update && apt install -y curl wget iproute2 net-tools openjdk-21-jdk-headless

#GO TO /home/ubuntu
WORKDIR /home/ubuntu

#Download and install tomcat 
RUN wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.0.0/bin/apache-tomcat-10.0.0.tar.gz && \ 
    tar -xvf apache-tomcat-10.0.0.tar.gz -C /opt/ && \
    rm -rf apache-tomcat-10.0.0.tar.gz

#Copy the JSP application inside container
COPY index.jsp .

#Create WAR File
RUN jar -cvf java-application.war index.jsp 

#Move WAR to tomcat webapp
RUN mv java-application.war /opt/apache-tomcat-10.0.0/webapps/

#Tomcat port
EXPOSE 8080

#Start the apache tomcat in foreground
CMD ["/opt/apache-tomcat-10.0.0/bin/catalina.sh","run"] 
#CMD ["sh", "-c", "/opt/apache-tomcat-10.0.0/bin/catalina.sh start && tail -f /dev/null"]   
