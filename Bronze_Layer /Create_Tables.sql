
IF OBJECT_ID('Bronze.Loan','U') IS NOT NULL
    DROP TABLE Bronze.Loan

DROP TABLE IF EXISTS Bronze.Loan;

CREATE TABLE Bronze.Loan(
    id VARCHAR(MAX),
    member_id VARCHAR(MAX),
    loan_amnt VARCHAR(MAX),
    funded_amnt VARCHAR(MAX),
    funded_amnt_inv VARCHAR(MAX),
    term VARCHAR(MAX),
    int_rate VARCHAR(MAX),
    installment VARCHAR(MAX),
    grade VARCHAR(MAX),
    sub_grade VARCHAR(MAX),
    emp_title VARCHAR(MAX), 
    emp_length VARCHAR(MAX),
    home_ownership VARCHAR(MAX),
    annual_inc VARCHAR(MAX),
    verification_status VARCHAR(MAX),
    issue_d VARCHAR(MAX),
    loan_status VARCHAR(MAX),
    pymnt_plan VARCHAR(MAX),
    url VARCHAR(MAX),
    [desc] VARCHAR(MAX),
    purpose VARCHAR(MAX), 
    title VARCHAR(MAX),
    zip_code VARCHAR(MAX),
    addr_state VARCHAR(MAX),
    dti VARCHAR(MAX),
    delinq_2yrs VARCHAR(MAX),
    earliest_cr_line VARCHAR(MAX),
    inq_last_6mths VARCHAR(MAX),
    mths_since_last_delinq VARCHAR(MAX),
    mths_since_last_record VARCHAR(MAX),
    open_acc VARCHAR(MAX),
    pub_rec VARCHAR(MAX),
    revol_bal VARCHAR(MAX),
    revol_util VARCHAR(MAX),
    total_acc VARCHAR(MAX),
    initial_list_status VARCHAR(MAX),
    out_prncp VARCHAR(MAX),
    out_prncp_inv VARCHAR(MAX),
    total_pymnt VARCHAR(MAX),
    total_pymnt_inv VARCHAR(MAX),
    total_rec_prncp VARCHAR(MAX),
    total_rec_int VARCHAR(MAX),
    total_rec_late_fee VARCHAR(MAX),
    recoveries VARCHAR(MAX),
    collection_recovery_fee VARCHAR(MAX),
    last_pymnt_d VARCHAR(MAX),
    last_pymnt_amnt VARCHAR(MAX),
    next_pymnt_d VARCHAR(MAX),
    last_credit_pull_d VARCHAR(MAX),
    collections_12_mths_ex_med VARCHAR(MAX),
    mths_since_last_major_derog VARCHAR(MAX),
    policy_code VARCHAR(MAX),
    application_type VARCHAR(MAX),
    annual_inc_joint VARCHAR(MAX),
    dti_joint VARCHAR(MAX),
    verification_status_joint VARCHAR(MAX),
    acc_now_delinq VARCHAR(MAX),
    tot_coll_amt VARCHAR(MAX),
    tot_cur_bal VARCHAR(MAX),
    open_acc_6m VARCHAR(MAX),
    open_act_il VARCHAR(MAX),
    open_il_12m VARCHAR(MAX),
    open_il_24m VARCHAR(MAX),
    mths_since_rcnt_il VARCHAR(MAX),
    total_bal_il VARCHAR(MAX),
    il_util VARCHAR(MAX),
    open_rv_12m VARCHAR(MAX),
    open_rv_24m VARCHAR(MAX),
    max_bal_bc VARCHAR(MAX),
    all_util VARCHAR(MAX),
    total_rev_hi_lim VARCHAR(MAX),
    inq_fi VARCHAR(MAX),
    total_cu_tl VARCHAR(MAX),
    inq_last_12m VARCHAR(MAX),
    acc_open_past_24mths VARCHAR(MAX),
    avg_cur_bal VARCHAR(MAX),
    bc_open_to_buy VARCHAR(MAX),
    bc_util VARCHAR(MAX),
    chargeoff_within_12_mths VARCHAR(MAX),
    delinq_amnt VARCHAR(MAX),
    mo_sin_old_il_acct VARCHAR(MAX),
    mo_sin_old_rev_tl_op VARCHAR(MAX),
    mo_sin_rcnt_rev_tl_op VARCHAR(MAX),
    mo_sin_rcnt_tl VARCHAR(MAX),
    mort_acc VARCHAR(MAX),
    mths_since_recent_bc VARCHAR(MAX),
    mths_since_recent_bc_dlq VARCHAR(MAX),
    mths_since_recent_inq VARCHAR(MAX),
    mths_since_recent_revol_delinq VARCHAR(MAX),
    num_accts_ever_120_pd VARCHAR(MAX),
    num_actv_bc_tl VARCHAR(MAX),
    num_actv_rev_tl VARCHAR(MAX),
    num_bc_sats VARCHAR(MAX),
    num_bc_tl VARCHAR(MAX),
    num_il_tl VARCHAR(MAX),
    num_op_rev_tl VARCHAR(MAX),
    num_rev_accts VARCHAR(MAX),
    num_rev_tl_bal_gt_0 VARCHAR(MAX),
    num_sats VARCHAR(MAX),
    num_tl_120dpd_2m VARCHAR(MAX),
    num_tl_30dpd VARCHAR(MAX),
    num_tl_90g_dpd_24m VARCHAR(MAX),
    num_tl_op_past_12m VARCHAR(MAX),
    pct_tl_nvr_dlq VARCHAR(MAX),
    percent_bc_gt_75 VARCHAR(MAX),
    pub_rec_bankruptcies VARCHAR(MAX),
    tax_liens VARCHAR(MAX),
    tot_hi_cred_lim VARCHAR(MAX),
    total_bal_ex_mort VARCHAR(MAX),
    total_bc_limit VARCHAR(MAX),
    total_il_high_credit_limit VARCHAR(MAX),
    revol_bal_joint VARCHAR(MAX),
    sec_app_earliest_cr_line VARCHAR(MAX),
    sec_app_inq_last_6mths VARCHAR(MAX),
    sec_app_mort_acc VARCHAR(MAX),
    sec_app_open_acc VARCHAR(MAX),
    sec_app_revol_util VARCHAR(MAX),
    sec_app_open_act_il VARCHAR(MAX),
    sec_app_num_rev_accts VARCHAR(MAX),
    sec_app_chargeoff_within_12_mths VARCHAR(MAX),
    sec_app_collections_12_mths_ex_med VARCHAR(MAX),
    sec_app_mths_since_last_major_derog VARCHAR(MAX),
    hardship_flag VARCHAR(MAX),
    hardship_type VARCHAR(MAX),
    hardship_reason VARCHAR(MAX), 
    hardship_status VARCHAR(MAX),
    deferral_term VARCHAR(MAX),
    hardship_amount VARCHAR(MAX),
    hardship_start_date VARCHAR(MAX),
    hardship_end_date VARCHAR(MAX),
    payment_plan_start_date VARCHAR(MAX),
    hardship_length VARCHAR(MAX),
    hardship_dpd VARCHAR(MAX),
    hardship_loan_status VARCHAR(MAX),
    orig_projected_additional_accrued_interest VARCHAR(MAX),
    hardship_payoff_balance_amount VARCHAR(MAX),
    hardship_last_payment_amount VARCHAR(MAX),
    disbursement_method VARCHAR(MAX),
    debt_settlement_flag VARCHAR(MAX),
    debt_settlement_flag_date VARCHAR(MAX),
    settlement_status VARCHAR(MAX),
    settlement_date VARCHAR(MAX),
    settlement_amount VARCHAR(MAX),
    settlement_percentage VARCHAR(MAX),
    settlement_term VARCHAR(MAX)
);

GO


IF OBJECT_ID('Bronze.browseNotes','U') IS NOT NULL
	DROP TABLE Bronze.browseNotes

CREATE TABLE Bronze.browseNotes(
BrowseNotesFile VARCHAR(50) ,
Description VARCHAR(MAX)
);

GO 

IF OBJECT_ID('Bronze.LoanStats','U') IS NOT NULL
	DROP TABLE Bronze.LoanStats

CREATE TABLE Bronze.LoanStats(
LoanStatNew VARCHAR(50),
Description VARCHAR(MAX)
);

GO 

IF OBJECT_ID('Bronze.RejectStats','U') IS NOT NULL
	DROP TABLE Bronze.RejectStats

CREATE TABLE Bronze.RejectStats(
RejectStats_File VARCHAR(50),
Description VARCHAR(MAX)
);


