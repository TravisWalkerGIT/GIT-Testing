*** Settings ***
Library           DatabaseLibrary
Library           Dialogs
Resource          ../resources/cloudera.resource
Suite Setup       Perform Test Suite Setup
Suite Teardown    Perform Test Suite Teardown

*** Comment ***    
    Pty_id Check
        Action - Check counts
        Expected result - Counts match
        https://jira.sanlam.co.za/browse/
        Execution:  python -m robot -d output -i check Tests
        Upload:    python ./lib/Upload_Test_Results.py LDWBI-XXX
    
    Outstanding: 
       08/02/2022 - Testing is for Policy grain only.  No full content tsting yet.
                    Testing is against target business vault satellite v_dwh241_all_if and not the final to be delivered files
                    Recon testing at monthly level only at this point
                    

*** Variables ***
${SQL_DWH214_SOURCE_CNT} =    SELECT count(pty_id) from groupbi_ads_e698063_spflab.reality_check_full
${SQL_DWH214_TARGET_CNT} =    SELECT count(pty_id) from groupbi_ads_e698063_spflab.skyreality_full_data

*** Test Cases ***
UC18DWH241_US1_Testcase1: Monthly File Reconciliation (File: Enforce Non-Funeral- S224.ALL.IF.Mccyymm)
    [Documentation]  LDWBI-485 - Reconcile 3 new monthly files which contains the inforce data for Legacy Non Funeral (Q1 - Jan - Mar, Q2 - April - Jun, Q3 - July - Sep, Q4 - Oct- Dec) to the original quarterly files on an attribute level grain using the same parameters (i.e. Date range) ( File: S224.ALL.IF.Mccyymm)
    [Tags]  check
      Database connection
      Test that the pty_id count in reality_check_full matches skyreality_full_data

*** Keywords ***
Test that the pty_id count in reality_check_full matches skyreality_full_data
      ${result_set_src}    DatabaseLibrary.Query    ${SQL_DWH214_SOURCE_CNT}    sansTran=True
      ${result_set_tgt}    DatabaseLibrary.Query    ${SQL_DWH214_TARGET_CNT}    sansTran=True
      ${tst_src_val}=    Set Variable    ${result_set_src[0][0]}
      ${tst_tgt_val}=    Set Variable    ${result_set_tgt[0][0]}
        Should Be Equal As Integers    ${tst_src_val}    ${tst_tgt_val}  
