IF OBJECT_ID('Silver.loan','U') IS NOT NULL
	DROP TABLE Silver.loan;

GO

CREATE TABLE Silver.loan(
[loan_amnt] INT,
[funded_amnt] INT,
[funded_amnt_inv] FLOAT,
[int_rate] FLOAT,
[term_months] VARCHAR(50),
[calculated_installment]FLOAT,
[grade] VARCHAR(2),
[sub_grade] VARCHAR(5),
[emp_title] VARCHAR(100),
[emp_length] VARCHAR(50),
[home_ownership] VARCHAR(50),
[annual_inc] FLOAT,
[verification_status] VARCHAR(50),
[issue_d] DATE,
[loan_status] VARCHAR(100),
[pymnt_plan] VARCHAR(5),
[desc] VARCHAR(MAX),
[purpose] VARCHAR(MAX),
[title] VARCHAR(MAX),
[zip_code] VARCHAR(6),
[addr_state] VARCHAR(5),
[dti] FLOAT,
[delinq_2yrs] INT,
[earliest_cr_line] DATE,
[inq_last_6mths] INT,
[mths_since_last_delinq] INT,
[mths_since_last_record] INT,
[open_acc] INT,
[pub_rec] INT,
[revol_bal] FLOAT,
[revol_util] FLOAT,
[total_acc] INT ,
[initial_list_status] VARCHAR(5),
[out_prncp] FLOAT ,
[out_prncp_inv] FLOAT ,
[total_pymnt] FLOAT ,
[total_pymnt_inv] FLOAT, 
[total_rec_prncp] FLOAT,
[total_rec_int] FLOAT,
[total_rec_late_fee] FLOAT ,
[recoveries] FLOAT,
[collection_recovery_fee] FLOAT ,
[last_pymnt_d]  DATE,
[last_pymnt_amnt] FLOAT,
[next_pymnt_d]  DATE,
[last_credit_pull_d] DATE,
[collections_12_mths_ex_med] INT ,
[mths_since_last_major_derog] INT,
[policy_code] INT,
[application_type] VARCHAR(50),
[annual_inc_joint] FLOAT ,
[dti_joint] FLOAT ,
[verification_status_joint] VARCHAR (50),
[acc_now_delinq] SMALLINT,
[tot_coll_amt] FLOAT,
[tot_cur_bal] FLOAT,
[open_acc_6m] SMALLINT,
[open_act_il] SMALLINT,
[open_il_12m] SMALLINT,
[open_il_24m] SMALLINT,
[mths_since_rcnt_il] SMALLINT,
[total_bal_il] FLOAT,
[il_util] FLOAT,
[open_rv_12m] SMALLINT,
[open_rv_24m] SMALLINT,
[max_bal_bc]  FLOAT,
[all_util] FLOAT,
[total_rev_hi_lim] FLOAT,
[inq_fi] SMALLINT,
[total_cu_tl] SMALLINT,
[inq_last_12m] SMALLINT,
[acc_open_past_24mths] SMALLINT,
[avg_cur_bal] FLOAT,
[bc_open_to_buy] FLOAT,
[bc_util] FLOAT,
[chargeoff_within_12_mths] SMALLINT,
[delinq_amnt] FLOAT,
[mo_sin_old_il_acct] SMALLINT,
[mo_sin_old_rev_tl_op] SMALLINT,
[mo_sin_rcnt_rev_tl_op] SMALLINT,
[mo_sin_rcnt_tl] SMALLINT,
[mort_acc] SMALLINT,
[mths_since_recent_bc] SMALLINT,
[mths_since_recent_bc_dlq] SMALLINT,
[mths_since_recent_inq] SMALLINT,
[mths_since_recent_revol_delinq] SMALLINT,
[num_accts_ever_120_pd] SMALLINT,
[num_actv_bc_tl] SMALLINT,
[num_actv_rev_tl] SMALLINT,
[num_bc_sats] SMALLINT,
[num_bc_tl] SMALLINT,
[num_il_tl] SMALLINT,
[num_op_rev_tl] SMALLINT,
[num_rev_accts] SMALLINT,
[num_rev_tl_bal_gt_0] SMALLINT,
[num_sats]  SMALLINT,
[num_tl_120dpd_2m] SMALLINT,
[num_tl_30dpd] SMALLINT,
[num_tl_90g_dpd_24m] SMALLINT,
[num_tl_op_past_12m] SMALLINT,
[pct_tl_nvr_dlq] FLOAT,
[percent_bc_gt_75] FLOAT,
[pub_rec_bankruptcies] SMALLINT,
[tax_liens] SMALLINT,
[tot_hi_cred_lim] INT,
[total_bal_ex_mort] INT,
[total_bc_limit]  INT,
[total_il_high_credit_limit]  INT,
[revol_bal_joint] INT,
[sec_app_earliest_cr_line] DATE, 
[sec_app_inq_last_6mths] SMALLINT,
[sec_app_mort_acc]  SMALLINT,
[sec_app_open_acc] SMALLINT,
[sec_app_revol_util] FLOAT,
[sec_app_open_act_il] SMALLINT,
[sec_app_num_rev_accts] SMALLINT,
[sec_app_chargeoff_within_12_mths] SMALLINT,
[sec_app_collections_12_mths_ex_med] SMALLINT,
[sec_app_mths_since_last_major_derog] SMALLINT,
[hardship_flag] VARCHAR(2),
[hardship_type] VARCHAR(50),
[hardship_reason] VARCHAR(50),
[hardship_status] VARCHAR(50),
[deferral_term] SMALLINT,
[hardship_amount] FLOAT,
[hardship_start_date] DATE,
[hardship_end_date] DATE,
[payment_plan_start_date] DATE,
[hardship_length] SMALLINT,
[hardship_dpd] SMALLINT,
[hardship_loan_status] VARCHAR(50),
[orig_projected_additional_accrued_interest] FLOAT,
[hardship_payoff_balance_amount] FLOAT,
[disbursement_method] VARCHAR(20),
[debt_settlement_flag] VARCHAR(2),
[debt_settlement_flag_date] DATE ,
[settlement_status] VARCHAR(20),
[settlement_date] DATE,
[settlement_amount] INT,
[settlement_percentage] FLOAT,
[settlement_term] SMALLINT
);

GO

IF OBJECT_ID ('Silver.[browseNotes]','U') IS NOT NULL
	DROP TABLE [Silver].[browseNotes];

GO

CREATE TABLE Silver.[browseNotes] (
[BrowseNotesFile] VARCHAR(50),
[Description] VARCHAR(MAX)
);

GO

IF OBJECT_ID ('Silver.[LoanStats]','U') IS NOT NULL
	DROP TABLE [Silver].[LoanStats];
GO

CREATE TABLE Silver.[LoanStats](
[LoanStatNew] VARCHAR(50),
[Description] VARCHAR(MAX)
);

GO

IF OBJECT_ID ('Silver.[RejectStats]','U') IS NOT NULL
	DROP TABLE [Silver].[RejectStats];
GO
CREATE TABLE Silver.[RejectStats](
[RejectStats_File] VARCHAR(50),
[Description] VARCHAR(MAX)
)

