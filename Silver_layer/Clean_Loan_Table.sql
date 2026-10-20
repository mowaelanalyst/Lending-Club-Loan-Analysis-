CREATE VIEW Silver.Clean_loan AS
   
        SELECT 
            -- 1. Handling Column Shift for Loan Status, Verification Status, and Issue Date
            CAST(loan_amnt AS INT) AS loan_amnt,
            CAST(funded_amnt AS INT) AS funded_amnt,
            CAST(funded_amnt_inv AS FLOAT) AS funded_amnt_inv,
        
            -- Clean Rate & Term
            CAST(REPLACE(TRIM(int_rate), '%', '') AS FLOAT) / 100.0 AS int_rate,
            CAST(REPLACE(TRIM(term), ' months', '') AS INT) AS term_months,
        
            grade,
            sub_grade,
            CASE 
                WHEN emp_title IS NULL OR LEN(TRIM(emp_title)) <= 1 THEN 'n/a'
    
                WHEN TRIM(emp_title) LIKE '[A-G][1-5]' THEN 'n/a'
   
                WHEN TRIM(emp_title) LIKE '%year%' THEN 'n/a'
             
                WHEN LOWER(TRIM(emp_title)) IN ('rent', 'mortgage', 'own', 'none', 'other') THEN 'n/a'

                ELSE LOWER(TRIM(TRANSLATE(emp_title, '0123456789-/".`', '               ')))
            END AS emp_title,
            CASE
                WHEN [emp_length] NOT IN ('10+ years','< 1 year','1 year','2 years','3 years','4 years',
                '5 years','6 years','7 years','8 years','9 years','n/a') THEN 'n/a'

                WHEN [emp_length] IS NULL THEN 'n/a'

                ELSE [emp_length] 
            END AS [emp_length],

            CASE 
                WHEN LOWER(TRIM(home_ownership)) IN ('rent', 'mortgage', 'own', 'other') 
                THEN LOWER(TRIM(home_ownership))
                ELSE 'n/a'
            END AS home_ownership,

            TRY_CAST(TRIM(annual_inc) AS FLOAT) AS annual_inc,

            -- Fix Shifted Verification Status
            CASE 
                WHEN LOWER(TRIM(verification_status)) IN ('verified', 'source verified', 'not verified')
                THEN LOWER(TRIM(verification_status))

                WHEN LOWER(TRIM(loan_status)) IN ('verified', 'source verified', 'not verified') 
                THEN LOWER(TRIM(loan_status))

                WHEN LOWER(TRIM(pymnt_plan)) IN ('verified', 'source verified', 'not verified')
                THEN LOWER(TRIM(pymnt_plan))
                ELSE 'n/a'
            END AS verification_status,

            -- Fix Shifted Issue Date
            CASE 
                WHEN TRY_CAST('01-' + issue_d AS DATE) IS NOT NULL 
                THEN TRY_CAST('01-' + issue_d AS DATE)

                WHEN TRY_CAST('01-' + loan_status AS DATE) IS NOT NULL
                THEN TRY_CAST('01-' + loan_status AS DATE)

                WHEN TRY_CAST('01-' + pymnt_plan AS DATE) IS NOT NULL
                THEN TRY_CAST('01-' + pymnt_plan AS DATE)
                ELSE TRY_CAST('01-' + [url] AS DATE)
            END AS issue_d,

            -- Fix Shifted Loan Status
            CASE 
                WHEN LOWER(TRIM([loan_status])) IN ('current','fully paid','charged off','default','in grace period','late (16-30 days)','late (31-120 days)',
                'does not meet the credit policy. status:fully paid','does not meet the credit policy. status:charged Off') 
                THEN LOWER(TRIM([loan_status]))

                WHEN LOWER(TRIM([pymnt_plan])) IN ('current','fully paid','charged off','default','in grace period','late (16-30 days)','late (31-120 days)',
                'does not meet the credit policy. status:fully paid','does not meet the credit policy. status:charged Off') 
                THEN LOWER(TRIM([pymnt_plan]))

                WHEN LOWER(TRIM([url])) IN ('current','fully paid','charged off','default','in grace period','late (16-30 days)','late (31-120 days)',
                'does not meet the credit policy. status:fully paid','does not meet the credit policy. status:charged Off') 
                THEN  LOWER(TRIM([url]))
                ELSE 'n/a'
            END [loan_status],
            CASE 
                WHEN LOWER(TRIM([pymnt_plan])) IN ('y','n') 
                THEN LOWER(TRIM([pymnt_plan]))
            
                WHEN LOWER(TRIM([url])) IN ('y','n')
                THEN LOWER(TRIM([url]))
                ELSE 'n/a'
            END AS [pymnt_plan],
            SUBSTRING(REPLACE(REPLACE(TRIM([desc]),'<br>',''),'"',''),CHARINDEX('>',[desc])+1 , LEN([desc])) AS [desc],
            SUBSTRING(TRIM(REPLACE(REPLACE([purpose],'<br>',''),'"','')),CHARINDEX('>',[purpose]) -1, LEN([purpose])) AS [purpose],
            ISNULL(REPLACE(REPLACE(REPLACE([title],'<br>',''),'<br >',''),'<br/>',''),'n/a') AS [title],
            CASE 
                WHEN LEN(TRY_CAST(REPLACE(TRIM([zip_code]),'XX','') AS INT)) = 3 THEN TRIM([zip_code])

                ELSE NULL
            END [zip_code],
            CASE 

                WHEN LEN(TRIM([addr_state])) = 2 
                     AND TRIM([addr_state]) NOT LIKE '%[^a-zA-Z]%'

                     AND UPPER(TRIM([addr_state])) NOT IN ('CC', 'GE', 'TV', 'RV')
                THEN UPPER(TRIM([addr_state]))
        
                ELSE 'n/a'
            END AS [addr_state],
            CASE
                    WHEN TRY_CAST([dti] AS FLOAT) < 0 THEN NULL
                    ELSE TRY_CAST([dti] AS FLOAT)
            END AS [dti],

            TRY_CAST(delinq_2yrs AS INT) AS delinq_2yrs,

            TRY_CAST('01-' + earliest_cr_line AS DATE) AS earliest_cr_line,

            TRY_CAST(inq_last_6mths AS INT) AS inq_last_6mths,

            TRY_CAST(mths_since_last_delinq AS INT) AS mths_since_last_delinq,

            TRY_CAST(mths_since_last_record AS INT) AS mths_since_last_record,

            TRY_CAST(open_acc AS INT) AS open_acc,

            TRY_CAST(pub_rec AS INT) AS pub_rec,

            TRY_CAST(REPLACE(revol_bal,'$','') AS FLOAT) AS revol_bal,

            TRY_CAST(REPLACE(revol_util, '%', '') AS FLOAT) / 100.0 AS revol_util,

            TRY_CAST(total_acc AS INT) AS total_acc,
            CASE 
                WHEN UPPER(TRIM([initial_list_status])) IN ('F','W') 
                THEN UPPER(TRIM([initial_list_status]))
                ELSE 'n/a'
            END [initial_list_status],


            TRY_CAST([out_prncp] AS FLOAT) AS [out_prncp],

            TRY_CAST([out_prncp_inv] AS FLOAT) AS [out_prncp_inv],

            TRY_CAST([total_pymnt] AS FLOAT) AS [total_pymnt],

            TRY_CAST([total_rec_prncp] AS FLOAT) AS [total_rec_prncp],

            TRY_CAST([total_pymnt_inv] AS FLOAT) AS [total_pymnt_inv], 

            TRY_CAST([total_rec_int] AS FLOAT) AS [total_rec_int],

            TRY_CAST([total_rec_late_fee] AS FLOAT) AS [total_rec_late_fee],

            TRY_CAST([recoveries] AS FLOAT) AS [recoveries],

            TRY_CAST([collection_recovery_fee] AS FLOAT) AS [collection_recovery_fee],

            TRY_CAST('1-' + [last_pymnt_d] AS DATE) AS [last_pymnt_d],

            TRY_CAST([last_pymnt_amnt] AS FLOAT)  AS [last_pymnt_amnt],

            TRY_CAST('01-'+[next_pymnt_d] AS DATE) AS [next_pymnt_d],

            TRY_CAST('01-'+[last_credit_pull_d] AS DATE) AS [last_credit_pull_d],

            TRY_CAST([collections_12_mths_ex_med] AS INT) AS [collections_12_mths_ex_med],

            TRY_CAST([mths_since_last_major_derog] AS INT)  AS [mths_since_last_major_derog],

            TRY_CAST([mths_since_rcnt_il] AS SMALLINT) AS [mths_since_rcnt_il],
            CASE 
                WHEN TRY_CAST([policy_code] AS INT) IN (1,2)
                THEN TRY_CAST([policy_code] AS INT)
                ELSE NULL
            END AS [policy_code] ,
              CASE 
                  WHEN TRY_CAST(TRIM(LOWER([application_type])) AS VARCHAR(50)) IN ('individual','joint app','joint')
                  THEN TRY_CAST(TRIM(LOWER([application_type])) AS VARCHAR(50))
                  ELSE NULL
              END AS  [application_type],

              TRY_CAST([annual_inc_joint] AS FLOAT) AS [annual_inc_joint],

              TRY_CAST([dti_joint] AS FLOAT) AS [dti_joint],

              CASE 
                  WHEN LOWER(TRIM([verification_status_joint])) IN ('verified', 'source verified', 'not verified')
                  THEN  LOWER(TRIM([verification_status_joint])) 
                  ELSE NULL
              END AS [verification_status_joint],

              TRY_CAST([acc_now_delinq] AS SMALLINT) AS [acc_now_delinq],

              TRY_CAST([tot_coll_amt] AS FLOAT) AS [tot_coll_amt],

              TRY_CAST([tot_cur_bal] AS FLOAT) AS [tot_cur_bal],

              TRY_CAST([open_acc_6m] AS SMALLINT) AS [open_acc_6m],

              TRY_CAST([open_act_il] AS SMALLINT) AS [open_act_il],

              TRY_CAST([open_il_12m] AS SMALLINT) AS [open_il_12m],

              TRY_CAST([open_il_24m] AS SMALLINT) AS [open_il_24m],

              TRY_CAST([total_bal_il] AS FLOAT) AS [total_bal_il] ,

              TRY_CAST([il_util] AS FLOAT) AS [il_util] ,

              TRY_CAST([open_rv_12m] AS SMALLINT) AS [open_rv_12m],

              TRY_CAST([open_rv_24m] AS SMALLINT) AS [open_rv_24m],

              TRY_CAST([max_bal_bc] AS FLOAT)  AS [max_bal_bc] ,
              
              TRY_CAST([all_util] AS FLOAT)  AS [all_util] ,

              TRY_CAST([total_rev_hi_lim] AS FLOAT)   AS [total_rev_hi_lim],

              TRY_CAST([inq_fi] AS SMALLINT)  AS [inq_fi],

              TRY_CAST([total_cu_tl] AS SMALLINT) AS [total_cu_tl],

              TRY_CAST([inq_last_12m] AS SMALLINT) AS [inq_last_12m],

              TRY_CAST([acc_open_past_24mths] AS SMALLINT)  AS [acc_open_past_24mths],

              TRY_CAST([avg_cur_bal] AS FLOAT) AS [avg_cur_bal],

              TRY_CAST([bc_open_to_buy] AS FLOAT)  AS [bc_open_to_buy],

              TRY_CAST([bc_util] AS FLOAT) AS [bc_util],
              
              TRY_CAST([chargeoff_within_12_mths] AS SMALLINT) AS [chargeoff_within_12_mths],

              TRY_CAST([delinq_amnt] AS FLOAT) AS [delinq_amnt],

              TRY_CAST([mo_sin_old_il_acct] AS SMALLINT) AS [mo_sin_old_il_acct],

              TRY_CAST([mo_sin_old_rev_tl_op] AS SMALLINT) AS [mo_sin_old_rev_tl_op],

              TRY_CAST([mo_sin_rcnt_rev_tl_op] AS SMALLINT) AS [mo_sin_rcnt_rev_tl_op],

              TRY_CAST([mo_sin_rcnt_tl] AS SMALLINT) AS [mo_sin_rcnt_tl],

              TRY_CAST([mort_acc] AS SMALLINT) AS [mort_acc],

              TRY_CAST([mths_since_recent_bc]AS SMALLINT) AS [mths_since_recent_bc],

              TRY_CAST([mths_since_recent_bc_dlq] AS SMALLINT) AS [mths_since_recent_bc_dlq],

              TRY_CAST([mths_since_recent_inq] AS SMALLINT) AS [mths_since_recent_inq],

              TRY_CAST([mths_since_recent_revol_delinq] AS SMALLINT) AS [mths_since_recent_revol_delinq] ,

              TRY_CAST([num_accts_ever_120_pd] AS SMALLINT) AS [num_accts_ever_120_pd],

              TRY_CAST([num_actv_bc_tl] AS SMALLINT) AS [num_actv_bc_tl],

              TRY_CAST([num_actv_rev_tl] AS SMALLINT) AS [num_actv_rev_tl] ,

              TRY_CAST([num_bc_sats] AS SMALLINT) AS [num_bc_sats],

              TRY_CAST([num_bc_tl] AS SMALLINT) AS [num_bc_tl] ,

              TRY_CAST([num_il_tl] AS SMALLINT) AS [num_il_tl],

              TRY_CAST([num_op_rev_tl] AS SMALLINT) AS [num_op_rev_tl],

              TRY_CAST([num_rev_accts] AS SMALLINT) AS [num_rev_accts],

              TRY_CAST([num_rev_tl_bal_gt_0] AS SMALLINT) AS [num_rev_tl_bal_gt_0],

              TRY_CAST([num_sats] AS SMALLINT) AS [num_sats],

              TRY_CAST([num_tl_120dpd_2m] AS SMALLINT) AS [num_tl_120dpd_2m],

              TRY_CAST([num_tl_30dpd] AS SMALLINT) AS [num_tl_30dpd],

              TRY_CAST([num_tl_90g_dpd_24m] AS SMALLINT) AS [num_tl_90g_dpd_24m],

              TRY_CAST([num_tl_op_past_12m] AS SMALLINT) AS [num_tl_op_past_12m],

              TRY_CAST([pct_tl_nvr_dlq] AS FLOAT) AS [pct_tl_nvr_dlq],

              TRY_CAST([percent_bc_gt_75] AS FLOAT) AS [percent_bc_gt_75],

              TRY_CAST([pub_rec_bankruptcies] AS SMALLINT) AS [pub_rec_bankruptcies],

              TRY_CAST([tax_liens] AS SMALLINT) AS [tax_liens],

              TRY_CAST([tot_hi_cred_lim] AS INT) AS [tot_hi_cred_lim],

              TRY_CAST([total_bal_ex_mort] AS INT) AS [total_bal_ex_mort],

              TRY_CAST([total_bc_limit] AS INT) AS [total_bc_limit],

              TRY_CAST([total_il_high_credit_limit] AS INT) AS [total_il_high_credit_limit],

              TRY_CAST([revol_bal_joint] AS INT) AS [revol_bal_joint],

              TRY_CAST('-01'+[sec_app_earliest_cr_line] AS DATE) AS [sec_app_earliest_cr_line], 

              TRY_CAST([sec_app_inq_last_6mths] AS SMALLINT) AS [sec_app_inq_last_6mths], 

              TRY_CAST([sec_app_mort_acc] AS SMALLINT) AS [sec_app_mort_acc],
              
              TRY_CAST([sec_app_open_acc] AS SMALLINT) AS [sec_app_open_acc],

              TRY_CAST([sec_app_revol_util] AS FLOAT) AS [sec_app_revol_util],

              TRY_CAST([sec_app_open_act_il] AS SMALLINT) AS [sec_app_open_act_il],

              TRY_CAST([sec_app_num_rev_accts] AS SMALLINT) AS [sec_app_num_rev_accts],

              TRY_CAST([sec_app_chargeoff_within_12_mths] AS SMALLINT) AS [sec_app_chargeoff_within_12_mths],

              TRY_CAST([sec_app_collections_12_mths_ex_med] AS SMALLINT) AS [sec_app_collections_12_mths_ex_med],

              TRY_CAST([sec_app_mths_since_last_major_derog] AS SMALLINT) AS [sec_app_mths_since_last_major_derog],
              CASE 
                  WHEN TRY_CAST(UPPER(TRIM([hardship_flag])) AS VARCHAR(5)) NOT IN ('Y','N')
                  THEN NULL
                  WHEN TRY_CAST(UPPER(TRIM([hardship_flag])) AS VARCHAR(5)) IS NULL AND (TRY_CAST(UPPER(TRIM([hardship_type])) AS VARCHAR(50)) IN ('Y','N')
                  OR TRY_CAST(UPPER(TRIM([hardship_reason])) AS VARCHAR(50)) IN ('Y','N'))
                  THEN TRY_CAST(UPPER(TRIM([hardship_type])) AS VARCHAR(5)) 
                  ELSE TRY_CAST(UPPER(TRIM([hardship_flag])) AS VARCHAR(5))
              END AS [hardship_flag],
              CASE 
                  WHEN TRY_CAST(UPPER(TRIM([hardship_type])) AS VARCHAR(50)) = 'INTEREST ONLY-3 MONTHS DEFERRAL'
                  THEN TRY_CAST(UPPER(TRIM([hardship_type])) AS VARCHAR(50))
                  WHEN TRY_CAST(UPPER(TRIM([hardship_type])) AS VARCHAR(50)) IS NULL AND 
                  TRY_CAST(UPPER(TRIM([hardship_reason])) AS VARCHAR(50)) = 'INTEREST ONLY-3 MONTHS DEFERRAL'
                  THEN TRY_CAST(UPPER(TRIM([hardship_reason])) AS VARCHAR(50)) 
                  ELSE NULL
              END AS [hardship_type] ,
              CASE 
                  WHEN TRY_CAST(UPPER(TRIM([hardship_status])) AS VARCHAR(50)) IN ('ACTIVE','COMPLETED','BROKEN')
                  THEN TRY_CAST(UPPER(TRIM([hardship_status])) AS VARCHAR(50))
                  ELSE NULL
              END AS [hardship_status] ,
              CASE 
                  WHEN TRY_CAST(UPPER(TRIM([hardship_reason])) AS VARCHAR(50)) IN ('NATURAL_DISASTER','EXCESSIVE_OBLIGATIONS','UNEMPLOYMENT','INCOME_CURTAILMENT','DISABILITY','MEDICAL',
                  'FAMILY_DEATH','DIVORCE','REDUCED_HOURS')
                  THEN TRY_CAST(UPPER(TRIM([hardship_reason])) AS VARCHAR(50))
                  ELSE NULL
              END AS [hardship_reason] ,

              TRY_CAST([deferral_term] AS SMALLINT) AS [deferral_term],

              TRY_CAST([hardship_amount] AS FLOAT) AS [hardship_amount],

              TRY_CAST('01-'+[hardship_start_date] AS DATE) AS [hardship_start_date],
            
              TRY_CAST('01-'+[hardship_end_date] AS DATE) AS [hardship_end_date] ,

              TRY_CAST('01-'+[payment_plan_start_date] AS DATE) AS [payment_plan_start_date],

              TRY_CAST([hardship_length] AS SMALLINT) AS [hardship_length],

              TRY_CAST([hardship_dpd] AS SMALLINT) AS [hardship_dpd],

              CASE 
                  WHEN TRY_CAST(LOWER(TRIM([hardship_loan_status])) AS VARCHAR(50)) IN ('late (16-30 days)','in grace period','current','late (31-120 days)')
                  THEN TRY_CAST(TRIM([hardship_loan_status]) AS VARCHAR(50))
                  ELSE NULL
              END AS [hardship_loan_status] ,

              TRY_CAST([orig_projected_additional_accrued_interest] AS FLOAT) AS [orig_projected_additional_accrued_interest],

              TRY_CAST([hardship_payoff_balance_amount] AS FLOAT) AS [hardship_payoff_balance_amount],

              CASE 
                  WHEN TRY_CAST(LOWER(TRIM([disbursement_method])) AS VARCHAR(20)) IN ('Cash','directpay')
                  THEN TRY_CAST(TRIM([disbursement_method]) AS VARCHAR(20))
                  WHEN TRY_CAST(LOWER(TRIM([disbursement_method])) AS VARCHAR(20)) IS NULL 
                  AND TRY_CAST(LOWER(TRIM([debt_settlement_flag])) AS VARCHAR(20)) IN ('Cash','directpay')
                  THEN TRY_CAST(LOWER(TRIM([debt_settlement_flag])) AS VARCHAR(20)) 
                  ELSE NULL
              END AS [disbursement_method],
              CASE 
                  WHEN TRY_CAST(LOWER(TRIM([debt_settlement_flag])) AS VARCHAR(20)) IN ('y','n')
                  THEN TRY_CAST(TRIM([debt_settlement_flag]) AS VARCHAR(50))
                  WHEN TRY_CAST(TRIM([debt_settlement_flag]) AS VARCHAR(50))IS NULL AND TRY_CAST(LOWER(TRIM([debt_settlement_flag_date])) AS VARCHAR(20)) IN ('y','n')
                  THEN NULL
                  ELSE NULL
              END AS [debt_settlement_flag],

              TRY_CAST('01-'+[debt_settlement_flag_date] AS DATE) AS [debt_settlement_flag_date],

              CASE 
                  WHEN TRY_CAST(UPPER(TRIM([settlement_status])) AS VARCHAR(20)) IN ('ACTIVE','COMPLETE','BROKEN')
                  THEN TRY_CAST(UPPER(TRIM([settlement_status])) AS VARCHAR(20))
                  ELSE NULL
              END AS [settlement_status] ,

              TRY_CAST('01-'+[settlement_date] AS DATE) AS [settlement_date] ,

              TRY_CAST([settlement_amount] AS INT) AS [settlement_amount] ,

              TRY_CAST([settlement_percentage] AS FLOAT) AS [settlement_percentage],

              TRY_CAST([settlement_term] AS SMALLINT) AS [settlement_term]


FROM [Bronze].[Loan];
