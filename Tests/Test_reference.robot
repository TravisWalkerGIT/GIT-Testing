*** Settings ***
Library           DatabaseLibrary
Library           Dialogs
Resource          ../resources/cloudera.resource
Resource          ../variables/RafActPdh.resource
Suite Setup       Perform Test Suite Setup
Suite Teardown    Perform Test Suite Teardown

*** Comment ***    
    UC18DWH241_US1_Testcase1: Monthly File Reconciliation (File: Enforce Non-Funeral- S224.ALL.IF.Mccyymm)
        Action - Reconcile 3 new monthly files which contains the inforce data for Legacy Non Funeral (Q1 - Jan - Mar, Q2 - April - Jun, Q3 - July - Sep, Q4 - Oct- Dec) to the original quarterly files on an attribute level grain using the same parameters (i.e. Date range) ( File: S224.ALL.IF.Mccyymm)
        Expected result - The newly generated file matches to the data in the original file for the same period selected on an attribute level
        https://jira.sanlam.co.za/browse/LDWBI-785
        Execution:  robot  -d output -i LDWBI-785 tests/UC18 
        Upload:    python ./lib/Upload_Test_Results.py LDWBI-XXX
    
    Outstanding: 
       08/02/2022 - Testing is for Policy grain only.  No full content tsting yet.
                    Testing is against target business vault satellite v_dwh241_all_if and not the final to be delivered files
                    Recon testing at monthly level only at this point
                    

*** Variables ***
${SQL_DWH214_SOURCE_CNT} =    SELECT count(distinct out_pol_nr) from groupbi_acthub_recon_prd.ldw_dwh241 where INPUT__FILE__NAME like '%ALL.IF.M${SRC_SNAPSHOT_DATE}%' AND out_prod_tbl_grp_cd != 4 AND out_stat_cd = 0
${SQL_DWH214_TARGET_CNT} =    SELECT count(distinct policy_nr) from groupbi_im_raf_actuarialhub${ENV}.v_dwh241_all_if where prod_tbl_grp_cd != 4 AND pa_sts_cd = 0 and snapshot_date = ${TGT_EFFCTV_END_DATE}

${SQL_DWH214_MATCH_CNT} =   SELECT COUNT(*) FROM (SELECT a.out_pol_nr, b.policy_nr, a.cnt_src, b.cnt_trgt from (select distinct out_pol_nr, count(*) cnt_src from groupbi_acthub_recon_prd.ldw_dwh241 where INPUT__FILE__NAME like '%ALL.IF.M${SRC_SNAPSHOT_DATE}%' AND out_prod_tbl_grp_cd != 4 GROUP BY out_pol_nr) a LEFT JOIN (select distinct policy_nr, count(*) cnt_trgt from groupbi_im_raf_actuarialhub${ENV}.v_dwh241_all_if where prod_tbl_grp_cd != 4 AND pa_sts_cd = 0 and effective_end_date = ${TGT_EFFCTV_END_DATE} GROUP BY policy_nr) b on a.out_pol_nr = b.policy_nr where a.cnt_src != b.cnt_trgt) aa

*** Test Cases ***
UC18DWH241_US1_Testcase1: Monthly File Reconciliation (File: Enforce Non-Funeral- S224.ALL.IF.Mccyymm)
    [Documentation]  LDWBI-485 - Reconcile 3 new monthly files which contains the inforce data for Legacy Non Funeral (Q1 - Jan - Mar, Q2 - April - Jun, Q3 - July - Sep, Q4 - Oct- Dec) to the original quarterly files on an attribute level grain using the same parameters (i.e. Date range) ( File: S224.ALL.IF.Mccyymm)
    [Tags]  LDWBI-785
      Database connection
      Test that the policy count on newly generated files match source policy count for in-force legacy non funeral policies
      Test that the grain of the policy data is the same in the newly developed file as in the original file for in-force legacy non funeral policies
      

*** Keywords ***
Test that the policy count on newly generated files match source policy count for in-force legacy non funeral policies
      ${result_set_src}    DatabaseLibrary.Query    ${SQL_DWH214_SOURCE_CNT}    sansTran=True
      ${result_set_tgt}    DatabaseLibrary.Query    ${SQL_DWH214_TARGET_CNT}    sansTran=True
      ${tst_src_val}=    Set Variable    ${result_set_src[0][0]}
      ${tst_tgt_val}=    Set Variable    ${result_set_tgt[0][0]}
        Should Be Equal As Integers    ${tst_src_val}    ${tst_tgt_val}

Test that the grain of the policy data is the same in the newly developed file as in the original file for in-force legacy non funeral policies
      ${result_set_cnt}   DatabaseLibrary.Query   ${SQL_DWH214_MATCH_CNT}    sansTran=True
      ${result} =  Set Variable    ${result_set_cnt[0][0]}
      Log To Console    ${result}
      Should Be Equal As Integers    0    ${result}      
