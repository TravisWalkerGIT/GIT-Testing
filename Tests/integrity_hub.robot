*** Settings ***
Library           DatabaseLibrary
Library           Dialogs
Resource          ../resources/cloudera.resource
Suite Setup       Perform Test Suite Setup
Suite Teardown    Perform Test Suite Teardown

*** Comment ***    
    Pty_id Check
        Action - integrity
        Expected result - Counts match
        https://jira.sanlam.co.za/browse/
        Execution:  python -m robot -d output -i integrity Tests
        Upload:    python ./lib/Upload_Test_Results.py LDWBI-XXX
    
    Outstanding: 
       08/02/2022 - Testing is for Policy grain only.  No full content tsting yet.
                    Testing is against target business vault satellite v_dwh241_all_if and not the final to be delivered files
                    Recon testing at monthly level only at this point
                    

*** Variables ***
${hub_test_1_sql} =    select count(*) FROM groupbi_ads_e698063_spflab.skyreality_full_data
${hub_test_2_sql} =    select count(*) FROM groupbi_ads_e698063_spflab.skyreality_full_data where pty_id = NULL
${hub_test_3_sql} =    select count(*),pty_id FROM groupbi_ads_e698063_spflab.skyreality_full_data group by pty_id having count(*) > 1
${hub_test_4_sql} =    select count(*),pty_id FROM groupbi_ads_e698063_spflab.skyreality_full_data group by pty_id having count(*) > 1
${hub_test_5_sql} =    select count(*) from groupbi_ads_e698063_spflab.skyreality_full_data where pty_id not in (select pty_id from groupbi_lablive_spflab.car_history)

*** Test Cases ***
UC18DWH241_US1_Testcase1: Monthly File Reconciliation (File: Enforce Non-Funeral- S224.ALL.IF.Mccyymm)
    [Documentation]  LDWBI-485 - Reconcile 3 new monthly files which contains the inforce data for Legacy Non Funeral (Q1 - Jan - Mar, Q2 - April - Jun, Q3 - July - Sep, Q4 - Oct- Dec) to the original quarterly files on an attribute level grain using the same parameters (i.e. Date range) ( File: S224.ALL.IF.Mccyymm)
    [Tags]  null_check
      Database connection
      Hub test 0: Record count to ensure that the hub is loaded
      Hub test 1: No null business keys / hashkeys in current set (from staging)
      Hub test 2: No duplicate business keys
      Hub test 3: No duplicate hash keys

*** Keywords ***
Hub test 0: Record count to ensure that the hub is loaded
      ${hub_test_1}    DatabaseLibrary.Query    ${hub_test_1_sql}    sansTran=True
      ${result_1}=    Set Variable    ${hub_test_1[0][0]}
      Should Not Be Equal As Integers    0    ${result_1}  

Hub test 1: No null business keys / hashkeys in current set (from staging)
      ${hub_test_2}    DatabaseLibrary.Query    ${hub_test_2_sql}    sansTran=True
      ${result_2}=    Set Variable    ${hub_test_2[0][0]}
      Should Be Equal As Integers    0    ${result_2}  

Hub test 2: No duplicate business keys
      ${hub_test_3}    DatabaseLibrary.Query    ${hub_test_3_sql}    sansTran=True
      
      ${index}=   Set Variable   0 
      
      FOR  ${item}  IN  @{hub_test_3}
             ${result_3}=  Set Variable    ${hub_test_3[${index}][0]}
             Should Be Equal As Strings    0    ${result_3}
             ${index}=   Evaluate   ${index} + 1      
             
      END  

Hub test 3: No duplicate hash keys
      ${hub_test_4}    DatabaseLibrary.Query    ${hub_test_4_sql}    sansTran=True
      
      ${index}=   Set Variable   0 
      
      FOR  ${item}  IN  @{hub_test_4}
             ${result_4}=  Set Variable    ${hub_test_4[${index}][0]}
             Should Be Equal As Strings    0    ${result_4}
             ${index}=   Evaluate   ${index} + 1      
             
      END

Hub test 4: Stage to target test, do all the hashes in stage exist in the target
      ${hub_test_4}    DatabaseLibrary.Query    ${hub_test_4_sql}    sansTran=True
      ${result_4}=    Set Variable    ${hub_test_4[0][0]}
      Should Be Equal As Integers    0    ${result_4}  