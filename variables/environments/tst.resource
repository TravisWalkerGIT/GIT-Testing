*** Settings ***
Documentation     doc

*** Variables ***
# Environment
${ENV_CODE} =     tst
${REPO_CODE} =    BST
# Sap Hana Connection
${SAP_HANA_USERNAME} =    ${USER}
${HANA_DRIVER} =    HDBODBC
${HANA_HOST} =    hanabidb${ENV_CODE}.sanlam.co.za
${HANA_DB_PORT} =    36015
${HANA_DB_NAME} =    BIU
# Data Service Connection
${DS_USERNAME} =    ${USER}
${DS_SECURITY_TYPE} =    secLDAP
${CMS_SERVER} =    sapdsbi${ENV_CODE}.sanlam.co.za
${CLIENT} =       http://sapdsbi${ENV_CODE}.sanlam.co.za:8080/DataServices/servlet/webservices?ver=2.1&wsdlxml
${OPS_REPO_NAME} =    ${REPO_CODE}_REPO_LOC_BI_GBI_OPS
