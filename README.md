# docker-jira
A Docker image for JIRA software

## Dependencies
#### JIRA DB service
* Source code from https://github.com/nhantran/docker-jiradb
* We can customize user/password for DB user at the first line from create_database.sql

```sql
CREATE USER jiradbuser WITH CREATEDB PASSWORD 'Passw0rd';
```

## Usage
#### Create JIRA DB service named 'jiradb' for JIRA

> docker run -d --name jiradb -p 5432:5432 nhantran/jiradb

#### Create a data volume as a service named 'jirahome' for JIRA Home

> docker create -v /opt/jira-home --name jirahome nhantran/jira /bin/true

#### Create JIRA service named 'jira' using 'jirahome' above

* Since jira service is expecting 'dbserver' as its DB service, we have to link the service 'jiradb' to 'dbserver' via --link option

* If we have changed user/password of DB user when building JIRA DB image, we need to update them in dbconfig.xml

```xml
<jira-database-config>
  ...
  <jdbc-datasource>
    ...
    <username>jiradbuser</username>
    <password>Passw0rd</password>
  </jdbc-datasource>
</jira-database-config>
```

* An then start JIRA service as following:

> docker run -d --volumes-from jirahome --name jira --link jiradb:dbserver -p 8080:8080 nhantran/jira

#### Access the JIRA system

> http://\<localhost or IP\>:8080
