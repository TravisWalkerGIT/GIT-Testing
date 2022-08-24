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
        Execution:  python -m robot -d output -i completeness Tests
        Upload:    python ./lib/Upload_Test_Results.py LDWBI-XXX
    
    Outstanding: 
       08/02/2022 - Testing is for Policy grain only.  No full content tsting yet.
                    Testing is against target business vault satellite v_dwh241_all_if and not the final to be delivered files
                    Recon testing at monthly level only at this point
                    

*** Variables ***
${hub_test_1_sql} =    select count(party_id), 'Source Table' as Source from groupbi_intermediary_agreement_prd.party_involved_in_agreement union all select count(distinct bk_0001_party), 'Hub' as Source from groupbi_ws_sbisdh_dev.h_0001_party
${hub_test_2_sql} =    select a.id, b.bk_0001_party from( select cast(party_id as varchar(32)) as id from groupbi_intermediary_agreement_prd.party_involved_in_agreement) a left outer join groupbi_ws_sbisdh_dev.h_0001_party b on a.id = b.bk_0001_party where b.bk_0001_party is null

*** Test Cases ***
UC18DWH241_US1_Testcase1: Monthly File Reconciliation (File: Enforce Non-Funeral- S224.ALL.IF.Mccyymm)
    [Documentation]  LDWBI-485 - Reconcile 3 new monthly files which contains the inforce data for Legacy Non Funeral (Q1 - Jan - Mar, Q2 - April - Jun, Q3 - July - Sep, Q4 - Oct- Dec) to the original quarterly files on an attribute level grain using the same parameters (i.e. Date range) ( File: S224.ALL.IF.Mccyymm)
    [Tags]  completeness
      Database connection
      Hub test 0:Record count distinct Hub VS distinct Source table
      Hub test 1: Distinct business key source table vs hub


*** Keywords ***
Hub test 0:Record count distinct Hub VS distinct Source table
      ${hub_test_1}    DatabaseLibrary.Query    ${hub_test_1_sql}    sansTran=True
      ${result_1}=    Set Variable    ${hub_test_1[0][0]}
      Should Be Equal As Integers    0    ${result_1}  

Hub test 1: Distinct business key source table vs hub
      ${hub_test_2}    DatabaseLibrary.Query    ${hub_test_2_sql}    sansTran=True
      ${result_2}=    Set Variable    ${hub_test_2[0][0]}
      Should Be Equal As Integers    0    ${result_2}  