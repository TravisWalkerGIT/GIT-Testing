*** Settings ***
Documentation     common settings for Sap Hana
# Resource        ${EXECDIR}/resources/environments/${ENV}.resource
# Resource        ${EXECDIR}/resources/users/${USER}.resource

*** Variables ***
${SQL_OBJECT_COUNT_ALL} =    select count(*) from objects
${SQL_OBJECT_COUNT_TOP10} =    select top 10 * from objects
