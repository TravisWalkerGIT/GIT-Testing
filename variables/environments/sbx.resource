*** Settings ***
Documentation     Settings specific to SBX environment

*** Variables ***
# Environment
${ENV_CODE} =     sbx
# Sap Hana Connection
${SAP_HANA_USERNAME} =    ${USER}
${HANA_DRIVER} =    HDBODBC
${HANA_HOST} =    hanabidb${ENV_CODE}.sanlam.co.za
${HANA_DB_PORT} =    31515
${HANA_DB_NAME} =    SBX
# Data Service Connection - NO Sandbox for Data Services
${DS_USERNAME} =    ${USER}
${DS_SECURITY_TYPE} =    secLDAP
${CMS_SERVER} =    None
${CLIENT} =       None
${OPS_REPO_NAME} =    None
