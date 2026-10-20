

CREATE OR ALTER PROCEDURE Load_silver_layr AS
    
BEGIN TRY
    BEGIN
        
	DECLARE @Start DATETIME , @End DATETIME
	SET @Start = GETDATE()
	PRINT 'Satart Loading Data' ;
	PRINT '';
	PRINT '';
	PRINT '';
	PRINT 'Start Truncate The Table Silver.loan ';
    TRUNCATE TABLE Silver.loan ;
    PRINT 'Successful';
    PRINT '';
    PRINT '';
    PRINT 'Start Insert Data To Silver.loan ';
    
    INSERT INTO Silver.loan(
    [loan_amnt] ,
    [funded_amnt] ,
    [funded_amnt_inv] ,
    [int_rate] ,
    [term_months] ,
    [calculated_installment] ,
    [grade] ,
    [sub_grade] ,
    [emp_title] ,
    [emp_length] ,
    [home_ownership],
    [annual_inc] ,
    [verification_status] ,
    [issue_d] ,
    [loan_status] ,
    [pymnt_plan] ,
    [desc] ,
    [purpose] ,
    [title] ,
    [zip_code] ,
    [addr_state] ,
    [dti] ,
    [delinq_2yrs] ,
    [earliest_cr_line] ,
    [inq_last_6mths] ,
    [mths_since_last_delinq] ,
    [mths_since_last_record] ,
    [open_acc] ,
    [pub_rec] ,
    [revol_bal] ,
    [revol_util] ,
    [total_acc] ,
    [initial_list_status] ,
    [out_prncp] ,
    [out_prncp_inv]  ,
    [total_pymnt]  ,
    [total_pymnt_inv] , 
    [total_rec_prncp] ,
    [total_rec_int],
    [total_rec_late_fee] ,
    [recoveries] ,
    [collection_recovery_fee]  ,
    [last_pymnt_d]  ,
    [last_pymnt_amnt] ,
    [next_pymnt_d] ,
    [last_credit_pull_d] ,
    [collections_12_mths_ex_med]  ,
    [mths_since_last_major_derog] ,
    [policy_code] ,
    [application_type] ,
    [annual_inc_joint],
    [dti_joint] ,
    [verification_status_joint] ,
    [acc_now_delinq] ,
    [tot_coll_amt] ,
    [tot_cur_bal] ,
    [open_acc_6m] ,
    [open_act_il] ,
    [open_il_12m] ,
    [open_il_24m] ,
    [mths_since_rcnt_il],
    [total_bal_il] ,
    [il_util] ,
    [open_rv_12m] ,
    [open_rv_24m],
    [max_bal_bc] ,
    [all_util] ,
    [total_rev_hi_lim] ,
    [inq_fi] ,
    [total_cu_tl] ,
    [inq_last_12m],
    [acc_open_past_24mths] ,
    [avg_cur_bal] ,
    [bc_open_to_buy],
    [bc_util],
    [chargeoff_within_12_mths] ,
    [delinq_amnt] ,
    [mo_sin_old_il_acct] ,
    [mo_sin_old_rev_tl_op] ,
    [mo_sin_rcnt_rev_tl_op],
    [mo_sin_rcnt_tl] ,
    [mort_acc],
    [mths_since_recent_bc],
    [mths_since_recent_bc_dlq] ,
    [mths_since_recent_inq] ,
    [mths_since_recent_revol_delinq],
    [num_accts_ever_120_pd],
    [num_actv_bc_tl] ,
    [num_actv_rev_tl] ,
    [num_bc_sats] ,
    [num_bc_tl] ,
    [num_il_tl] ,
    [num_op_rev_tl] ,
    [num_rev_accts] ,
    [num_rev_tl_bal_gt_0] ,
    [num_sats] ,
    [num_tl_120dpd_2m] ,
    [num_tl_30dpd] ,
    [num_tl_90g_dpd_24m] ,
    [num_tl_op_past_12m] ,
    [pct_tl_nvr_dlq] ,
    [percent_bc_gt_75] ,
    [pub_rec_bankruptcies] ,
    [tax_liens],
    [tot_hi_cred_lim] ,
    [total_bal_ex_mort] ,
    [total_bc_limit] ,
    [total_il_high_credit_limit] ,
    [revol_bal_joint] ,
    [sec_app_earliest_cr_line] , 
    [sec_app_inq_last_6mths] ,
    [sec_app_mort_acc] ,
    [sec_app_open_acc] ,
    [sec_app_revol_util] ,
    [sec_app_open_act_il] ,
    [sec_app_num_rev_accts] ,
    [sec_app_chargeoff_within_12_mths] ,
    [sec_app_collections_12_mths_ex_med] ,
    [sec_app_mths_since_last_major_derog] ,
    [hardship_flag] ,
    [hardship_type] ,
    [hardship_reason] ,
    [hardship_status] ,
    [deferral_term] ,
    [hardship_amount] ,
    [hardship_start_date] ,
    [hardship_end_date] ,
    [payment_plan_start_date] ,
    [hardship_length] ,
    [hardship_dpd] ,
    [hardship_loan_status] ,
    [orig_projected_additional_accrued_interest] ,
    [hardship_payoff_balance_amount] ,
    [disbursement_method] ,
    [debt_settlement_flag] ,
    [debt_settlement_flag_date]  ,
    [settlement_status] ,
    [settlement_date] ,
    [settlement_amount],
    [settlement_percentage] ,
    [settlement_term] 
    )
    SELECT 
        loan_amnt,
        funded_amnt,
        funded_amnt_inv,
        int_rate,
        term_months,
    
        -- Calculated Field: Installment Calculation (Amortization Formula)
        ROUND(
            (funded_amnt * (int_rate / 12.0) * POWER(1.0 + (int_rate / 12.0), term_months)) / 
            (POWER(1.0 + (int_rate / 12.0), term_months) - 1.0), 2
        ) AS calculated_installment,

        grade,
        sub_grade,
        emp_title,
        emp_length,
        home_ownership,
        annual_inc,
        verification_status,
        issue_d,
        loan_status,
        [pymnt_plan],
        [desc],
        [purpose],
        [title],
        [zip_code],
        [addr_state],
        dti,
        CASE 
            WHEN delinq_2yrs < 0 OR delinq_2yrs > 30 THEN NULL

            WHEN mths_since_last_delinq BETWEEN 0 AND 24 AND 
            (delinq_2yrs = 0 OR delinq_2yrs IS NULL ) THEN NULL

            ELSE delinq_2yrs
        END AS delinq_2yrs,
        earliest_cr_line,
        CASE 
            WHEN inq_last_6mths >= 0 AND inq_last_6mths <=12
            THEN inq_last_6mths
            ELSE NULL
        END AS inq_last_6mths,
        mths_since_last_delinq,
        CASE 
            WHEN mths_since_last_record < 0 OR mths_since_last_record > 120
            THEN NULL
            ELSE mths_since_last_record
        END mths_since_last_record,
    
        -- Logical Validation Rules
        CASE 
            WHEN open_acc < 0 OR open_acc >= 80 
            THEN NULL
            WHEN total_acc IS NOT NULL AND open_acc > total_acc 
            THEN NULL 
            ELSE open_acc 
        END AS open_acc,
        CASE 
            WHEN pub_rec < 0 OR pub_rec > 20 
            THEN NULL

            WHEN pub_rec_bankruptcies > pub_rec OR 
            (pub_rec IS NULL AND pub_rec_bankruptcies > 0)
            THEN pub_rec_bankruptcies

            WHEN mths_since_last_record IS NOT NULL AND (pub_rec = 0 OR pub_rec IS NULL)
            THEN 1

            ELSE pub_rec
        END AS pub_rec
        ,
        CASE 
            WHEN revol_bal >= 0 AND  revol_bal <= 1000000
            THEN  revol_bal
            ELSE NULL
        END AS revol_bal,
    
        -- Impute revol_util if missing
        CASE 
            WHEN revol_util < 0 OR revol_util > 2.0 
            THEN (revol_bal / NULLIF(total_rev_hi_lim, 0))
            ELSE revol_util 
        END AS revol_util,
        CASE 
            WHEN total_acc <= 0 OR total_acc > 120 
            THEN NULL 

            WHEN open_acc > total_acc 
            THEN NULL 

            ELSE total_acc 
        END AS total_acc,
        [initial_list_status],

        CASE 
            WHEN [out_prncp] < 0 
            THEN NULL
            WHEN [out_prncp] >  loan_amnt OR [out_prncp] > funded_amnt
            THEN NULL
            WHEN loan_status = 'fully paid' AND [out_prncp] > 0 
            THEN 0.0
            ELSE [out_prncp]
        END [out_prncp],
        CASE 
            WHEN [out_prncp_inv] < 0 
            THEN NULL
            WHEN [out_prncp_inv] > [out_prncp]  OR [out_prncp_inv] > funded_amnt_inv 
            THEN NULL 
            WHEN loan_status = 'fully paid' AND [out_prncp_inv] > 0 
            THEN 0.0
            ELSE [out_prncp_inv] 
        END [out_prncp_inv],
        CASE 
            WHEN [total_pymnt] < 0 
            THEN NULL
            WHEN [total_pymnt] < [total_rec_prncp]
            THEN NULL 
            ELSE [total_pymnt]
        END [total_pymnt],
        CASE 
            WHEN [total_pymnt_inv] < 0 
            THEN NULL
            WHEN [total_pymnt_inv] > [total_pymnt] 
            THEN NULL 
            ELSE [total_pymnt_inv]
        END AS [total_pymnt_inv],
        CASE 
            WHEN [total_rec_prncp] < 0
            THEN NULL
            WHEN [total_rec_prncp] > funded_amnt OR [total_rec_prncp] > [total_pymnt]
            THEN NULL
            ELSE [total_rec_prncp]
        END AS [total_rec_prncp],
        CASE 
            WHEN [total_rec_int] < 0 
            THEN NULL 
            WHEN [total_rec_int] > [total_pymnt] OR [total_rec_int] > (loan_amnt *2.0) 
            THEN NULL
            ELSE [total_rec_int] 
        END [total_rec_int],
        CASE 
            WHEN [total_rec_late_fee] < 0 
            THEN NULL
            WHEN [total_rec_late_fee] > [total_pymnt] OR [total_rec_late_fee] > funded_amnt 
            THEN NULL 
            ELSE [total_rec_late_fee] 
        END AS [total_rec_late_fee] ,
        CASE 
            WHEN [recoveries] < 0 
            THEN NULL 
            WHEN [recoveries] > funded_amnt OR  [recoveries] < [collection_recovery_fee]
            THEN NULL
            ELSE [recoveries]
        END AS [recoveries],
        CASE 
            WHEN [collection_recovery_fee] < 0 
            THEN NULL 
            WHEN [collection_recovery_fee] > [recoveries]  OR [collection_recovery_fee] > funded_amnt
            THEN NULL 
            ELSE [collection_recovery_fee]
        END AS  [collection_recovery_fee],
        CASE 
            WHEN [last_pymnt_d] < issue_d 
            THEN NULL
            ELSE [last_pymnt_d]
        END AS [last_pymnt_d],
        CASE 
            WHEN [last_pymnt_amnt] < 0 
            THEN NULL
            WHEN [last_pymnt_amnt] > [total_pymnt] OR [last_pymnt_amnt] > ([funded_amnt] *1.5)
            THEN NULL
            ELSE [last_pymnt_amnt]
        END AS [last_pymnt_amnt],
        CASE 
            WHEN [next_pymnt_d] < issue_d 
            THEN NULL
            WHEN [next_pymnt_d] IS NOT NULL AND loan_status IN ('fully paid','charged off')
            THEN NULL
            ELSE [next_pymnt_d]
        END [next_pymnt_d],

        [last_credit_pull_d],

        CASE 
            WHEN [collections_12_mths_ex_med] < 0
            THEN NULL
            WHEN [collections_12_mths_ex_med] > 20 
            THEN NULL
            ELSE [collections_12_mths_ex_med]
        END AS [collections_12_mths_ex_med],

        CASE 
            WHEN [mths_since_last_major_derog] < 0
            THEN NULL
            WHEN [mths_since_last_major_derog] > 140
            THEN NULL
            ELSE [mths_since_last_major_derog]
        END AS [mths_since_last_major_derog],
        [policy_code] ,
        [application_type],
        CASE 
            WHEN [annual_inc_joint] <= 0 
            THEN NULL
            WHEN [annual_inc_joint] IS NOT NULL AND [application_type] = 'individual'
            THEN NULL
            WHEN [annual_inc_joint] < [annual_inc]
            THEN NULL
            ELSE [annual_inc_joint]
        END AS [annual_inc_joint],
        CASE 
            WHEN [dti_joint] <= 0 
            THEN NULL
            WHEN [dti_joint] IS NOT NULL AND [application_type] = 'individual'
            THEN NULL 
            WHEN [dti_joint]  > 100
            THEN NULL
            ELSE [dti_joint] 
        END AS [dti_joint],
        CASE 
            WHEN [verification_status_joint] IS NOT NULL AND [application_type] = 'individual'
            THEN NULL
            ELSE [verification_status_joint]
        END AS [verification_status_joint],
        CASE 
            WHEN [acc_now_delinq] < 0
            THEN NULL
            WHEN [acc_now_delinq] > 10 
            THEN NULL
            ELSE [acc_now_delinq]
        END AS [acc_now_delinq],
        CASE 
            WHEN [tot_coll_amt] < 0 
            THEN NULL
            WHEN [tot_coll_amt] > 100000
            THEN NULL
            ELSE [tot_coll_amt]
        END AS [tot_coll_amt],
        [tot_cur_bal],
        CASE 
            WHEN [open_acc_6m] < 0
            THEN NULL
            WHEN [open_acc_6m] > 20 
            THEN NULL
            WHEN [open_acc_6m] > [open_acc]
            THEN NULL
            ELSE [open_acc_6m]
        END AS [open_acc_6m],
        CASE 
            WHEN [open_act_il] < 0 
            THEN NULL
            WHEN [open_act_il] > 40 
            THEN NULL
            WHEN [open_act_il] > [open_acc]
            THEN NULL
            ELSE [open_act_il]
        END AS [open_act_il],
        CASE 
            WHEN [open_il_12m] < 0
            THEN NULL
            WHEN [open_il_12m] > 20
            THEN NULL 
            WHEN [open_il_12m] > [open_acc]
            THEN NULL
            ELSE [open_il_12m]
        END AS [open_il_12m],
        CASE 
            WHEN [open_il_24m] < 0
            THEN NULL
            WHEN [open_il_24m] > 20 
            THEN NULL
            WHEN [open_il_24m] > [open_acc]
            THEN NULL
            WHEN [open_il_24m] < [open_il_12m]
            THEN NULL
            ELSE [open_il_24m]
        END AS [open_il_24m],
        CASE 
            WHEN [mths_since_rcnt_il] < 0
            THEN NULL
            WHEN [mths_since_rcnt_il] > 600
            THEN NULL
            WHEN [open_il_12m] > 0 AND [mths_since_rcnt_il] > 12
            THEN NULL
            ELSE [mths_since_rcnt_il] 
        END AS [mths_since_rcnt_il],
        CASE 
            WHEN [total_bal_il] < 0
            THEN NULL
            WHEN [total_bal_il] > 0 AND [open_act_il] = 0 
            THEN 0 
            ELSE [total_bal_il] 
        END AS [total_bal_il],
        CASE 
            WHEN [il_util]  < 0
            THEN NULL
            WHEN ([il_util] > 0 OR [il_util] IS NOT NULL) AND  ([total_bal_il] = 0 AND [open_act_il] = 0)
            THEN 0 
            WHEN [il_util] <= 200.0
            THEN [il_util]
            ELSE [il_util]
        END AS [il_util],
        CASE 
            WHEN [open_rv_12m] < 0
            THEN NULL 
            WHEN ([open_rv_12m] > [open_acc]) 
            THEN NULL
            WHEN [open_rv_12m] > 20 
            THEN NULL
            ELSE [open_rv_12m]
        END AS [open_rv_12m],
        CASE 
            WHEN [open_rv_24m] < 0
            THEN NULL
            WHEN ([open_rv_24m] > [open_acc]) OR ([open_rv_24m] < [open_rv_12m])
            THEN NULL
            WHEN [open_rv_24m] > 20
            THEN NULL
            ELSE [open_rv_24m] 
        END AS [open_rv_24m] ,
        CASE 
            WHEN [max_bal_bc] < 0
            THEN NULL
            WHEN [max_bal_bc] > 300000
            THEN NULL
            WHEN [max_bal_bc]  > [tot_cur_bal]
            THEN NULL
            ELSE [max_bal_bc]
        END AS [max_bal_bc],
        CASE 
            WHEN [all_util] < 0
            THEN NULL
            WHEN [all_util] > 200
            THEN NULL
            ELSE [all_util] 
        END AS [all_util] ,
        CASE 
            WHEN total_rev_hi_lim < 0 OR total_rev_hi_lim > 2175000
            THEN NULL
            WHEN revol_bal > (total_rev_hi_lim * 2.0) AND total_rev_hi_lim > 0
            THEN NULL 
            ELSE total_rev_hi_lim
        END AS total_rev_hi_lim,
        CASE 
            WHEN  [inq_fi] < 0
            THEN NULL
            WHEN  [inq_fi] > 20 
            THEN NULL
            ELSE  [inq_fi] 
        END AS [inq_fi],
        CASE 
            WHEN [total_cu_tl] < 0
            THEN NULL
            WHEN [total_cu_tl] > 20
            THEN NULL
            WHEN [total_cu_tl] > total_acc
            THEN NULL
            ELSE [total_cu_tl]
        END [total_cu_tl],
        CASE 
            WHEN [inq_last_12m] < 0
            THEN NULL
            WHEN [inq_last_12m] > 30
            THEN NULL
            ELSE [inq_last_12m]
        END AS [inq_last_12m],
        CASE 
            WHEN  [acc_open_past_24mths] < 0
            THEN NULL
            WHEN  [acc_open_past_24mths] > 40
            THEN NULL
            WHEN  [acc_open_past_24mths] > total_acc
            THEN NULL 
            ELSE  [acc_open_past_24mths]
        END AS  [acc_open_past_24mths],
        CASE 
            WHEN [avg_cur_bal] < 0
            THEN NULL
            WHEN [avg_cur_bal] > 500000
            THEN NULL
            WHEN [avg_cur_bal] > [tot_cur_bal]
            THEN NULL
            ELSE [avg_cur_bal]
        END AS [avg_cur_bal],
        CASE 
            WHEN [bc_open_to_buy] < 0
            THEN NULL
            WHEN [bc_open_to_buy] > 500000
            THEN NULL
            WHEN [bc_open_to_buy] > [total_rev_hi_lim]
            THEN NULL
            ELSE [bc_open_to_buy] 
        END AS [bc_open_to_buy],
        CASE 
            WHEN [bc_util] < 0
            THEN NULL
            WHEN [bc_util] > 200
            THEN NULL
            ELSE [bc_util]
        END AS [bc_util],
        CASE
            WHEN [chargeoff_within_12_mths] < 0 
            THEN NULL
            WHEN [chargeoff_within_12_mths] > 10 
            THEN NULL
            WHEN [chargeoff_within_12_mths] > total_acc
            THEN NULL
            ELSE [chargeoff_within_12_mths]
        END AS [chargeoff_within_12_mths],
        CASE 
            WHEN [delinq_amnt] < 0
            THEN NULL
            WHEN [delinq_amnt] > 200000
            THEN NULL
            WHEN [delinq_amnt] > [tot_cur_bal]
            THEN NULL
            ELSE [delinq_amnt] 
        END AS [delinq_amnt],
        CASE 
            WHEN [mo_sin_old_il_acct] < 0
            THEN NULL
            WHEN [mo_sin_old_il_acct] > 850
            THEN NULL
            ELSE [mo_sin_old_il_acct] 
        END AS [mo_sin_old_il_acct],
        CASE 
            WHEN [mo_sin_old_rev_tl_op] < 0
            THEN NULL
            WHEN [mo_sin_old_rev_tl_op] > 850
            THEN NULL
            ELSE [mo_sin_old_rev_tl_op]
        END AS [mo_sin_old_rev_tl_op],
        CASE 
            WHEN [mo_sin_rcnt_rev_tl_op] < 0 
            THEN NULL
            WHEN [mo_sin_rcnt_rev_tl_op] > 360
            THEN NULL
            WHEN [mo_sin_rcnt_rev_tl_op] > [mo_sin_old_rev_tl_op]
            THEN NULL
            ELSE [mo_sin_rcnt_rev_tl_op]
        END AS [mo_sin_rcnt_rev_tl_op],
        CASE 
            WHEN [mo_sin_rcnt_tl] < 0
            THEN NULL
            WHEN [mo_sin_rcnt_tl] > 360
            THEN NULL
            WHEN [mo_sin_rcnt_tl] > [mo_sin_rcnt_rev_tl_op]
            THEN NULL
            ELSE [mo_sin_rcnt_tl]
        END AS [mo_sin_rcnt_tl],
        CASE 
            WHEN [mort_acc] < 0
            THEN NULL
            WHEN [mort_acc] > 40
            THEN NULL
            WHEN [mort_acc]  > [total_acc] 
            THEN NULL
            ELSE [mort_acc]
        END AS [mort_acc],
        CASE
            WHEN [mths_since_recent_bc] < 0
            THEN NULL
            WHEN [mths_since_recent_bc] > 600
            THEN NULL
            ELSE [mths_since_recent_bc]
        END AS [mths_since_recent_bc],
        CASE 
            WHEN [mths_since_recent_bc_dlq] < 0
            THEN NULL
            WHEN [mths_since_recent_bc_dlq] > 600
            THEN NULL
            ELSE [mths_since_recent_bc_dlq]
        END AS [mths_since_recent_bc_dlq], 
        CASE 
            WHEN [mths_since_recent_inq] < 0 
            THEN NULL
            WHEN [mths_since_recent_inq] > 36
            THEN NULL
            ELSE [mths_since_recent_inq]
        END AS [mths_since_recent_inq],
        CASE 
            WHEN [mths_since_recent_revol_delinq] < 0 
            THEN NULL
            WHEN [mths_since_recent_revol_delinq] > 600
            THEN NULL
            ELSE [mths_since_recent_revol_delinq]
        END AS [mths_since_recent_revol_delinq],
        CASE 
            WHEN [num_accts_ever_120_pd] < 0
            THEN NULL
            WHEN [num_accts_ever_120_pd] > 80
            THEN NULL
            WHEN [num_accts_ever_120_pd] > [total_acc] 
            THEN NULL
            ELSE [num_accts_ever_120_pd]
        END AS [num_accts_ever_120_pd],
        CASE 
            WHEN [num_actv_bc_tl] < 0
            THEN NULL
            WHEN [num_actv_bc_tl] > 80
            THEN NULL
            ELSE [num_actv_bc_tl]
        END AS [num_actv_bc_tl],
        CASE 
            WHEN [num_actv_rev_tl] < 0 
            THEN NULL
            WHEN [num_actv_rev_tl] > 60 
            THEN NULL
            ELSE [num_actv_rev_tl]
        END AS [num_actv_rev_tl],
        CASE 
            WHEN [num_bc_sats] < 0
            THEN NULL
            WHEN [num_bc_sats] > 60 
            THEN NULL
            ELSE [num_bc_sats]
        END AS [num_bc_sats],
        CASE 
            WHEN [num_bc_tl] < 0
            THEN NULL
            WHEN [num_bc_tl] > 50 
            THEN NULL
            ELSE [num_bc_tl]
        END AS [num_bc_tl],
        CASE 
            WHEN [num_il_tl] < 0
            THEN NULL
            WHEN [num_il_tl] > 100
            THEN NULL
            ELSE [num_il_tl]
        END AS [num_il_tl],
        CASE 
            WHEN [num_op_rev_tl] < 0
            THEN NULL
            WHEN [num_op_rev_tl] > 70
            THEN NULL
            ELSE [num_op_rev_tl] 
        END AS [num_op_rev_tl],
        CASE 
            WHEN [num_rev_accts] < 0
            THEN NULL
            WHEN [num_rev_accts] > 50
            THEN NULL
            ELSE [num_rev_accts]
        END AS [num_rev_accts],
        CASE 
            WHEN [num_rev_tl_bal_gt_0] < 0
            THEN NULL
            WHEN [num_rev_tl_bal_gt_0] > 60
            THEN NULL
            ELSE [num_rev_tl_bal_gt_0]
        END AS [num_rev_tl_bal_gt_0],
        CASE 
            WHEN [num_sats] < 0
            THEN NULL
            WHEN [num_sats] > 60
            THEN NULL
            ELSE [num_sats] 
        END AS [num_sats],
        CASE 
            WHEN [num_tl_120dpd_2m] < 0
            THEN NULL
            WHEN [num_tl_120dpd_2m] > 45
            THEN NULL
            ELSE [num_tl_120dpd_2m]
        END AS [num_tl_120dpd_2m],
        CASE 
            WHEN [num_tl_30dpd] < 0
            THEN NULL 
            WHEN [num_tl_30dpd] > 30
            THEN NULL
            ELSE [num_tl_30dpd]
        END AS [num_tl_30dpd],
        CASE 
            WHEN [num_tl_90g_dpd_24m] < 0
            THEN NULL
            WHEN [num_tl_90g_dpd_24m] > 30
            THEN NULL
            ELSE [num_tl_90g_dpd_24m]
        END AS [num_tl_90g_dpd_24m],
        CASE 
            WHEN [num_tl_op_past_12m] < 0
            THEN NULL
            WHEN [num_tl_op_past_12m] > 30
            THEN NULL
            ELSE [num_tl_op_past_12m]
        END AS [num_tl_op_past_12m],

        [pct_tl_nvr_dlq],
        [percent_bc_gt_75],
        CASE 
            WHEN [pub_rec_bankruptcies] < 0
            THEN NULL
            WHEN [pub_rec_bankruptcies] > 10
            THEN NULL
            ELSE [pub_rec_bankruptcies]
        END AS [pub_rec_bankruptcies],
        CASE 
            WHEN [tax_liens] < 0
            THEN NULL
            WHEN [tax_liens]  > 10
            THEN NULL
            ELSE [tax_liens] 
        END AS [tax_liens],

        [tot_hi_cred_lim],
        [total_bal_ex_mort],
        [total_bc_limit],
        [total_il_high_credit_limit],
        [revol_bal_joint],
        [sec_app_earliest_cr_line],
        [sec_app_inq_last_6mths], 

        CASE
            WHEN [sec_app_mort_acc]  < 0
            THEN NULL
            WHEN [sec_app_mort_acc] > 30 
            THEN NULL
            ELSE [sec_app_mort_acc]
        END AS [sec_app_mort_acc],
        CASE 
            WHEN [sec_app_open_acc] < 0
            THEN NULL
            WHEN [sec_app_open_acc] > 30
            THEN NULL
            ELSE [sec_app_open_acc]
        END AS [sec_app_open_acc] ,
        [sec_app_revol_util],
        CASE 
            WHEN [sec_app_open_act_il] < 0
            THEN NULL
            WHEN [sec_app_open_act_il] > 40
            THEN NULL
            ELSE [sec_app_open_act_il]
        END AS [sec_app_open_act_il],
        CASE
            WHEN [sec_app_num_rev_accts] < 0
            THEN NULL
            WHEN [sec_app_num_rev_accts] > 70
            THEN NULL
            ELSE [sec_app_num_rev_accts]
        END AS [sec_app_num_rev_accts],
        CASE 
            WHEN [sec_app_chargeoff_within_12_mths] < 0
            THEN NULL
            WHEN [sec_app_chargeoff_within_12_mths] > 70
            THEN NULL
            ELSE [sec_app_chargeoff_within_12_mths]
        END AS [sec_app_chargeoff_within_12_mths],
        CASE 
            WHEN [sec_app_collections_12_mths_ex_med] < 0
            THEN NULL
            WHEN [sec_app_collections_12_mths_ex_med] > 100
            THEN NULL
            ELSE [sec_app_collections_12_mths_ex_med]
        END AS [sec_app_collections_12_mths_ex_med],
        CASE
            WHEN [sec_app_mths_since_last_major_derog] < 0
            THEN NULL
            WHEN [sec_app_mths_since_last_major_derog] > 200
            THEN NULL
            ELSE [sec_app_mths_since_last_major_derog] 
        END [sec_app_mths_since_last_major_derog] ,
        [hardship_flag],
        [hardship_type],
        [hardship_reason],
        [hardship_status],
        CASE 
            WHEN [deferral_term] <= 0
            THEN NULL
            WHEN [deferral_term] > 24 
            THEN NULL
            ELSE [deferral_term]
        END AS [deferral_term],
        [hardship_amount],
        [hardship_start_date],
        [hardship_end_date] ,
        [payment_plan_start_date],
        CASE 
            WHEN [hardship_length] < 0
            THEN NULL
            WHEN [hardship_length] > 20
            THEN NULL
            ELSE [hardship_length] 
        END AS [hardship_length],
        CASE 
            WHEN [hardship_dpd] < 0
            THEN NULL
            WHEN [hardship_dpd] > 40
            THEN NULL
            ELSE [hardship_dpd]
        END AS [hardship_dpd],
        [hardship_loan_status],
        [orig_projected_additional_accrued_interest],
        [hardship_payoff_balance_amount] ,
        [disbursement_method],
        [debt_settlement_flag],
        [debt_settlement_flag_date],
        [settlement_status],
        [settlement_date],
        [settlement_amount],
        CASE 
            WHEN [settlement_percentage] < 0
            THEN NULL
            WHEN [settlement_percentage] > 200
            THEN NULL
            ELSE [settlement_percentage]
        END AS [settlement_percentage],
        CASE 
            WHEN [settlement_term] < 0
            THEN NULL
            WHEN [settlement_term] > 30
            THEN NULL
            ELSE [settlement_term]
        END AS [settlement_term]

    FROM Silver.Clean_loan;
    SET @End = GETDATE()
    PRINT 'The Execution Duration:' + CAST(DATEDIFF(SECOND,@Start,@End) AS VARCHAR) + 'Seconds';
    PRINT 'Successful';
    ---------------------------------------------------------------------------------------------------
    PRINT 'Satart Loading Data' ;
	PRINT '';
	PRINT '';
	PRINT '';
	PRINT 'Start Truncate The Table [Silver].[browseNotes] ';
    TRUNCATE TABLE [Silver].[browseNotes];
    
    PRINT 'Successful';
    PRINT '';
    PRINT '';
    PRINT 'Start Insert Data To [Silver].[browseNotes] ';
    INSERT INTO [Silver].[browseNotes](
    [BrowseNotesFile],
    [Description])
    SELECT 

    LOWER(TRIM(REPLACE(ISNULL([BrowseNotesFile],'n/a'),'_',' '))),
    LOWER(TRIM(REPLACE(ISNULL([Description],'n/a'),'*',' ')))

    FROM [Bronze].[browseNotes];
    SET @End = GETDATE()
    PRINT 'The Execution Duration:' + CAST(DATEDIFF(SECOND,@Start,@End) AS VARCHAR) + 'Seconds';
    PRINT 'Successful';
    ------------------------------------------------------------------------------------------------------------
    
    PRINT 'Satart Loading Data' ;
	PRINT '';
	PRINT '';
	PRINT '';
	PRINT 'Start Truncate The Table [Silver].[LoanStats] ';
    TRUNCATE TABLE [Silver].[LoanStats];
    PRINT 'Successful';
    PRINT '';
    PRINT '';
    PRINT 'Start Insert Data To [Silver].[LoanStats] ';
    
    INSERT INTO [Silver].[LoanStats](
    [LoanStatNew],
    [Description])
    SELECT 

    LOWER(TRIM(REPLACE(ISNULL([LoanStatNew],'n/a'),'_',' '))),
    LOWER(TRIM(REPLACE(ISNULL([Description],'n/a'),'*',' ')))

    FROM [Bronze].[LoanStats];

    SET @End = GETDATE()
    PRINT 'The Execution Duration:' + CAST(DATEDIFF(SECOND,@Start,@End) AS VARCHAR) + 'Seconds';
    PRINT 'Successful';
    ----------------------------------------------------------------------------------------------
    
    PRINT 'Satart Loading Data' ;
	PRINT '';
	PRINT '';
	PRINT '';
	PRINT 'Start Truncate The Table [Silver].[RejectStats] ';
    TRUNCATE TABLE [Silver].[RejectStats];
    PRINT 'Successful';
    PRINT '';
    PRINT '';
    PRINT 'Start Insert Data To Silver.[RejectStats] ';
    
    INSERT INTO Silver.[RejectStats](
    [RejectStats_File] ,
    [Description] 
    )
    SELECT 
    [RejectStats_File],
    [Description]
    FROM [Bronze].[RejectStats]

    SET @End = GETDATE()
    PRINT 'The Execution Duration:' + CAST(DATEDIFF(SECOND,@Start,@End) AS VARCHAR) + 'Seconds';
    PRINT 'Successful';
    --------------------------------------------------------------------------------------------------
    END 
END TRY
BEGIN CATCH
    SELECT 
        ERROR_MESSAGE() AS ERRORMESSAGE,
        ERROR_NUMBER() AS ERRORNUMBER,
        ERROR_LINE() AS ERRORLINE
END CATCH



EXEC Load_silver_layr
