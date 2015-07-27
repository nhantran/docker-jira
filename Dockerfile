FROM nhantran/oraclejdk17
MAINTAINER Nhan Tran <tranphanquocnhan@gmail.com>

RUN wget http://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-6.4.8.tar.gz
RUN /usr/sbin/useradd --create-home --home-dir /usr/local/jira --shell /bin/bash jira
RUN mkdir /opt/jira
RUN tar xvf atlassian-jira-6.4.8.tar.gz --strip=1 -C /opt/jira
RUN mkdir /opt/jira-home
ADD dbconfig.xml /opt/jira-home/dbconfig.xml 
RUN echo "jira.home = /opt/jira-home" > /opt/jira/atlassian-jira/WEB-INF/classes/jira-application.properties
VOLUME /opt/jira-home
EXPOSE 8080
CMD ["/opt/jira/bin/start-jira.sh", "-fg"]
