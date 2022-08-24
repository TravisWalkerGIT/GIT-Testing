*** Settings ***
Documentation     Passwords included here will be checked by the UserInput.py and used if not set to None
...               can copy and paste this file into ./variables/.credentials.    .credentials should be kept in the .gitignore
...               so will not be pushed to bitbucket if forget to remove before push
...               this can be updated as additional private credentials are required by the project
...               name of file to be as follows:
...               ${USER}_${ENV_CODE}_private_variables.resource
...               where ${USER} is the mudid and ${ENV_CODE} is set in the environment .resource file for this env

*** Variables ***
# SET VARIABLES =    None TO BE PROMPTED
${SAP_HANA_PASSWORD} =    MyHanaPassword
${DS_PASSWORD} =    MyDataServicesPassword
${JIRA_PASSWORD} =    MyJiraPassword
