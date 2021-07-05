FROM tomcat:jre8-alpine
COPY webapp.war /usr/local/tomcat/webapps
