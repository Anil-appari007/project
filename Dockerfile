FROM tomcat:jre8-alpine
#COPY webapp.war /usr/local/tomcat/webapps
COPY webapp/target/webapp.war /usr/local/tomcat/webapps
