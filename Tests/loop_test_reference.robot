*** Settings ***
Library           DatabaseLibrary
Library           Dialogs
Library           ./../../resources/keywords/cloudera/PerformanceFeedback.py
Resource          ./../../resources/keywords/cloudera/cloudera.resource
Resource          ./../../variables/RafActPdh.resource
Suite Setup       Perform Test Suite Setup
Suite Teardown    Perform Test Suite Teardown

*** Comment ***    
    UC18DWH241_US7_Testcase1: File columns (File: Inforce Non-Funeral - S224.ALL.IF.Mccyymm)
        Action - Test that in the newly generated file which contains the non funeral inforce policies have all the column names present ( File: S224.ALL.IF.Mccyymm)
        Expected result - Column names are present in the new file similar to what has been specified in the grooming
        https://jira.sanlam.co.za/browse/LDWBI-793
        Execution:  robot  -d output -i LDWBI-793 tests/UC18 
        Upload:    python ./lib/Upload_Test_Results.py LDWBI-XXX
    
    Outstanding: 
       Apply test to final file

*** Variables ***
${SQL_DWH241_ALL_IF_TRGT} =  select columnname from cloudera_sys_internal.td_sys_eqv where databasename = 'groupbi_im_raf_actuarialhub_dev' and tablename = 's_dwh241_all_if' ORDER BY columnid
${SQL_DWH241_ALL_IF_SRC} =  SELECT columnname FROM groupbi_acthub_anlys_dev.ldw_dwh241_attr_recon_map ORDER BY columnid

*** Test Cases ***
UC18DWH241_US7_Testcase1: File columns (File: Inforce Non-Funeral - S224.ALL.IF.Mccyymm)
    [Documentation]  Test that in the newly generated file which contains the non funeral inforce policies have all the column names present ( File: S224.ALL.IF.Mccyymm)
    [Tags]  LDWBI-793
      Database connection
      Column name match for non funeral inforce policies (file S224.ALL.IF.Mccyymm)
      
*** Keywords ***
Column name match for non funeral inforce policies (file S224.ALL.IF.Mccyymm)
      ${result_set_tgt}    DatabaseLibrary.Query    ${SQL_DWH241_ALL_IF_TRGT}    sansTran=True
      ${result_set_src}    DatabaseLibrary.Query    ${SQL_DWH241_ALL_IF_SRC}    sansTran=True
      
      ${index}=   Set Variable   0 
      
      FOR  ${item}  IN  @{result_set_src}
             ${tst_src_val}=  Set Variable    ${result_set_src[${index}][0]}
             ${tst_tgt_val}=  Set Variable    ${result_set_tgt[${index}][0]}
             Should Be Equal As Strings    ${tst_src_val}    ${tst_tgt_val}
             ${index}=   Evaluate   ${index} + 1      
             
      END  