*** Settings ***
Documentation     Reusable keywords for Cloudera
Library           Dialogs
Library           DatabaseLibrary

*** Variables ***
${DB_USERNAME}
${DB_USER_PASSWORD}
${CLOUDERA_HOST} =    cloudera.sanlam.co.za
${IMPALA_PORT} =    21050
${HIVE_PORT} =    10000
${DB_NAME} =      BID


*** Keywords ***

Perform Test Suite Setup
    ${OLD_LOG_LEVEL} =    Set Log Level    TRACE
    ${DB_USERNAME_LCL} =    Get Value From User    Username:
    Set Suite Variable    ${DB_USERNAME}    ${DB_USERNAME_LCL}
    ${DB_USER_PASSWORD_LCL} =    Get Value From User    Password:    hidden=yes
    Set Suite Variable    ${DB_USER_PASSWORD}    ${DB_USER_PASSWORD_LCL}
    Set Log Level    ${OLD_LOG_LEVEL}

Perform Test Suite Teardown
    Disconnect From Database

Database connection
    Connect To Database Using Custom Params    impala.dbapi    user='${DB_USERNAME}',password='${DB_USER_PASSWORD}',host='${CLOUDERA_HOST}',port=${HIVE_PORT},auth_mechanism='LDAP'