*** Settings ***
Library           DatabaseLibrary
Library           Dialogs
Resource          ../resources/cloudera.resource
Suite Setup       Perform Test Suite Setup
Suite Teardown    Perform Test Suite Teardown

*** Comments ***


*** Variables ***


*** Test Cases ***
Test 
    [Documentation]  
    [Tags]  NUBtest
      Database connection
      Test that the combination of Epsilon attributes is the same for planmvts.mvttype
      Test that the combination should result in the combination of the LDW attributes


*** Keywords ***
Test that the combination of Epsilon attributes is the same for planmvts.mvttype


Test that the combination should result in the combination of the LDW attributes

