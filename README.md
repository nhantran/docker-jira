# docker-jira
A Docker image for JIRA software

## Usage
### Create a DB service named 'jiradb' for JIRA

	docker run --name jiradb -p 5432:5432 nhantran/jiradb

### Create a data volume as a service named 'jirahome' for JIRA Home

	docker create -v /opt/jira-home --name jirahome nhantran/jira /bin/true

### Create JIRA service named 'jira' using 'jirahome' above
Since jira service is expecting 'dbserver' as its DB service, we have to link the service 'jiradb' to 'dbserver' via --link option

	docker --volume-from jirahome --name jira --link jiradb:dbserver -p 8080:8080 nhantran/jira

### Access the JIRA system

	http://<localhost or IP>:8080
