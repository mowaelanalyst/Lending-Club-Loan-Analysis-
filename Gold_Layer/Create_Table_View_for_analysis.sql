DROP VIEW  Gold.[loan];
GO
CREATE VIEW Gold.[loan] AS
SELECT 
       [loan_amnt] AS requested_loan_amount ,
       [funded_amnt] AS funded_amount,
       [funded_amnt_inv] AS funded_amount_investors,
       [int_rate] AS interest_rate ,
       ([loan_amnt] * [int_rate] ) AS expected_revenue,
       [term_months] AS loan_term_months,
       [calculated_installment] AS monthly_installment_amount,
       [grade] AS credit_grade ,
       [sub_grade] AS credit_sub_grade,
       [emp_title] AS borrower_job_title , 
       [emp_length] AS employment_length_years , 
       [home_ownership] AS home_ownership_status ,
       [annual_inc] AS borrower_annual_income ,
        CASE 
            WHEN [annual_inc] <= 50000 THEN '0 - 50K'
            WHEN [annual_inc] > 50000 AND [annual_inc] <= 100000 THEN '50K - 100K'
            WHEN [annual_inc] > 100000 THEN '100K+'
            ELSE 'Unspecified'
        END AS borrower_annual_income_segmentation ,
       [verification_status] AS income_verification_status,
       [issue_d] AS loan_issue_date , 
       [loan_status] ,
       [pymnt_plan] AS has_payment_plan,
       [desc] AS loan_description ,
       [purpose] AS loan_purpose_category,
       [title] AS loan_title,
       [zip_code] ,
       [addr_state] AS borrower_state,
       [dti] AS debt_to_income_ratio,
      CASE 
            WHEN [dti] <= 10 THEN '0 - 10'
            WHEN [dti] > 10 AND [dti] <= 20 THEN '10 - 20'
            WHEN [dti] > 20 AND [dti] <= 30 THEN '20 - 30'
            WHEN [dti] > 30 THEN '30+'
            ELSE 'Unspecified'
       END AS debt_to_income_ratio_segmentation ,
       [delinq_2yrs] AS delinquencies_last_2_years,
       [earliest_cr_line] AS earliest_credit_line_date ,
       [inq_last_6mths] AS inquiries_last_6_months,
       [mths_since_last_delinq] AS months_since_last_delinquency
      ,[mths_since_last_record] AS months_since_last_public_record
      ,[open_acc] AS open_credit_accounts_count
      ,[pub_rec] AS public_records_count
      ,[revol_bal] AS revolving_balance_amount
      ,[revol_util] AS revolving_line_utilization_rate
      ,[total_acc] AS total_credit_accounts_count
      ,[initial_list_status] AS initial_listing_status
      ,[out_prncp] AS outstanding_principal_amount
      ,[out_prncp_inv] AS outstanding_principal_investors
      ,[total_pymnt] AS total_payments_received
      ,[total_pymnt_inv] AS total_payments_received_investors
      ,[total_rec_prncp] AS total_principal_received
      ,[total_rec_int] AS total_interest_received
      ,[total_rec_late_fee] AS total_late_fees_received
      ,[recoveries] AS recovery_amount
      ,[collection_recovery_fee] 
      ,[last_pymnt_d] AS last_payment_date
      ,[last_pymnt_amnt] AS last_payment_amount
      ,[next_pymnt_d] AS next_scheduled_payment_date
      ,[last_credit_pull_d] AS last_credit_pull_date
      ,[collections_12_mths_ex_med] AS collections_last_12_months_excluding_medical
      ,[mths_since_last_major_derog] AS months_since_last_major_derogatory
      ,[policy_code] AS policy_code
      ,[application_type] AS application_type
      ,[annual_inc_joint] AS joint_annual_income
      ,[dti_joint] AS joint_debt_to_income_ratio,
      CASE 
            WHEN [dti_joint] <= 10 THEN '0 - 10'
            WHEN [dti_joint] > 10 AND [dti_joint] <= 20 THEN '10 - 20'
            WHEN [dti_joint] > 20 AND [dti] <= 30 THEN '20 - 30'
            WHEN [dti_joint] > 30 THEN '30+'
            ELSE 'Unspecified'
       END AS joint_debt_to_income_ratio_segmentation 
      ,[verification_status_joint] AS joint_income_verification_status
      ,[acc_now_delinq] AS current_delinquent_accounts_count
      ,[tot_coll_amt] AS total_collection_amount
      ,[tot_cur_bal] AS total_current_balance
      ,[open_acc_6m] AS open_accounts_last_6_months
      ,[open_act_il] AS active_installment_accounts_count
      ,[open_il_12m] AS installment_accounts_opened_last_12_months
      ,[open_il_24m] AS installment_accounts_opened_last_24_months
      ,[mths_since_rcnt_il] AS months_since_recent_installment_loan
      ,[total_bal_il] AS total_installment_balance
      ,[il_util] AS installment_line_utilization_rate
      ,[open_rv_12m] AS revolving_accounts_opened_last_12_months
      ,[open_rv_24m] AS revolving_accounts_opened_last_24_months
      ,[max_bal_bc] AS maximum_balance_bankcard
      ,[all_util] AS overall_credit_utilization_rate
      ,[total_rev_hi_lim] AS total_revolving_high_limit
      ,[inq_fi] AS personal_finance_inquiries_count
      ,[total_cu_tl] AS credit_union_trades_count
      ,[inq_last_12m] AS inquiries_last_12_months
      ,[acc_open_past_24mths] AS accounts_opened_last_24_months
      ,[avg_cur_bal] AS average_current_balance
      ,[bc_open_to_buy] AS bankcard_open_to_buy_amount
      ,[bc_util] AS bankcard_utilization_rate
      ,[chargeoff_within_12_mths] AS chargeoffs_last_12_months
      ,[delinq_amnt] AS delinquency_amount
      ,[mo_sin_old_il_acct] AS months_since_oldest_installment_account
      ,[mo_sin_old_rev_tl_op] AS months_since_oldest_revolving_account
      ,[mo_sin_rcnt_rev_tl_op] AS months_since_newest_revolving_account
      ,[mo_sin_rcnt_tl] AS months_since_newest_account
      ,[mort_acc] AS mortgage_accounts_count
      ,[mths_since_recent_bc] AS months_since_recent_bankcard
      ,[mths_since_recent_bc_dlq] AS months_since_recent_bankcard_delinquency
      ,[mths_since_recent_inq] AS months_since_recent_inquiry
      ,[mths_since_recent_revol_delinq] AS months_since_recent_revolving_delinquency
      ,[num_accts_ever_120_pd] AS accounts_120_days_past_due_ever_count
      ,[num_actv_bc_tl] AS active_bankcard_accounts_count
      ,[num_actv_rev_tl] AS active_revolving_accounts_count
      ,[num_bc_sats] AS satisfactory_bankcard_accounts_count
      ,[num_bc_tl] AS total_bankcard_accounts_count
      ,[num_il_tl] AS installment_accounts_count
      ,[num_op_rev_tl] AS open_revolving_accounts_count
      ,[num_rev_accts] AS total_revolving_accounts_count
      ,[num_rev_tl_bal_gt_0] AS revolving_accounts_with_balance_count
      ,[num_sats] AS satisfactory_accounts_count
      ,[num_tl_120dpd_2m] AS accounts_120_days_past_due_last_2_months
      ,[num_tl_30dpd] AS accounts_30_days_past_due_count
      ,[num_tl_90g_dpd_24m] AS accounts_90_days_late_last_24_months
      ,[num_tl_op_past_12m] AS accounts_opened_past_12_months_count
      ,[pct_tl_nvr_dlq] AS never_delinquent_accounts_percentage
      ,[percent_bc_gt_75] AS bankcards_over_75_percent_utilization_ratio
      ,[pub_rec_bankruptcies] AS public_record_bankruptcies_count
      ,[tax_liens] AS tax_liens_count
      ,[tot_hi_cred_lim] AS total_high_credit_limit
      ,[total_bal_ex_mort] AS total_balance_excluding_mortgage
      ,[total_bc_limit] AS total_bankcard_limit
      ,[total_il_high_credit_limit] AS total_installment_high_credit_limit
      ,[revol_bal_joint] AS joint_revolving_balance
      ,[sec_app_earliest_cr_line] AS secondary_earliest_credit_line_date
      ,[sec_app_inq_last_6mths] AS secondary_inquiries_last_6_months
      ,[sec_app_mort_acc] AS secondary_mortgage_accounts_count
      ,[sec_app_open_acc] AS secondary_open_accounts_count
      ,[sec_app_revol_util] AS secondary_revolving_utilization_rate
      ,[sec_app_open_act_il] AS secondary_active_installment_accounts_count
      ,[sec_app_num_rev_accts] AS secondary_total_revolving_accounts_count
      ,[sec_app_chargeoff_within_12_mths] AS secondary_chargeoffs_last_12_months
      ,[sec_app_collections_12_mths_ex_med] AS secondary_collections_last_12_months
      ,[sec_app_mths_since_last_major_derog] AS secondary_months_since_last_major_derogatory
      ,[hardship_flag] AS is_under_hardship_program
      ,[hardship_type] AS hardship_program_type
      ,[hardship_reason] AS hardship_reason_category
      ,[hardship_status] AS hardship_program_status
      ,[deferral_term] AS hardship_deferral_term_months
      ,[hardship_amount] AS hardship_monthly_payment_amount
      ,[hardship_start_date] AS hardship_start_date
      ,[hardship_end_date] AS hardship_end_date
      ,[payment_plan_start_date] AS hardship_payment_plan_start_date
      ,[hardship_length] AS hardship_plan_length_months
      ,[hardship_dpd] AS hardship_days_past_due
      ,[hardship_loan_status] AS hardship_loan_status
      ,[orig_projected_additional_accrued_interest] AS orig_projected_additional_accrued_interest	
      ,[hardship_payoff_balance_amount] AS hardship_payoff_balance
      ,[disbursement_method] AS disbursement_method
      ,[debt_settlement_flag] AS is_debt_settlement_active
      ,[debt_settlement_flag_date] 
      ,[settlement_status] 
      ,[settlement_date] 
      ,[settlement_amount]
      ,[settlement_percentage]
      ,[settlement_term] AS settlement_term_months
FROM [Leding_club_loan_dataset].[Silver].[loan];

GO

CREATE VIEW Gold.[LoanStats] AS
SELECT
    [LoanStatNew] AS loan_status_code
    ,[Description] 
FROM [Leding_club_loan_dataset].[Silver].[LoanStats] ;

GO 

CREATE VIEW Gold.[RejectStats] AS 
SELECT 
       [RejectStats_File]
      ,[Description]
FROM [Leding_club_loan_dataset].[Silver].[RejectStats];

GO 

CREATE VIEW Gold.[browseNotes] AS
SELECT 
       [BrowseNotesFile]
      ,[Description]
FROM [Leding_club_loan_dataset].[Silver].[browseNotes];

