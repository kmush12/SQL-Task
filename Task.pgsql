--Task 1
CREATE TABLE input_tab
(
    msisdn                      VARCHAR(11)    UNIQUE    NOT NULL,
    subscr_id                   VARCHAR(8)     PRIMARY KEY,
    email_address               TEXT,
    age                         INTEGER,
    join_date                   DATE,
    gender                      TEXT,
    postal_sector               CHAR(5),
    handset_model               TEXT,
    handset_manufacturer        TEXT,
    needs_segment_name          TEXT,
    smart_phone_ind             TEXT,
    operating_system_name       TEXT,
    lte_subscr_ind              TEXT,
    bill_cycle_day              INTEGER,
    avg_3_mths_spend            DECIMAL,
    avg_3_mths_calls_usage      INTEGER,
    avg_3_mths_sms_usage        INTEGER,
    avg_3_mths_data_usage       INTEGER,
    avg_3_mths_intl_calls_usage INTEGER,
    avg_3_mths_roam_calls_usage INTEGER,
    avg_3_mths_roam_sms_usage   INTEGER,
    avg_3_mths_roam_data_usage  INTEGER,
    data_bolton_ind             TEXT,
    insurance_bolton_ind        TEXT,
    o2travel_optin_ind          TEXT,
    pm_registered_ind           TEXT,
    connection_dt               DATE,
    contract_start_dt           DATE,
    contract_end_dt             DATE,
    contract_term_mths          INTEGER,
    upgrade_dt                  DATE,
    cust_tenure_mths            INTEGER,
    pay_and_go_migrated_ind     TEXT,
    pay_and_go_migrated_dt      DATE,
    ported_in_ind               TEXT,
    ported_in_dt                DATE,
    ported_in_from_netwk_name   TEXT,
    disconnection_dt            DATE,
    tariff_name                 TEXT,
    sim_only_ind                TEXT,
    acquisition_channel_name    TEXT,
    billing_system_name         TEXT,
    last_billing_date           DATE,
    event_desc                  TEXT,
    contact_event_type_cd       TEXT,
    event_start_dt              DATE,
    campaign_cd                 TEXT,
    texts_optin_ind             TEXT,
    email_optin_ind             TEXT,
    phone_optin_ind             TEXT,
    post_optin_ind              TEXT,
    all_marketing_optin_ind     TEXT
);
 
COPY input_tab(msisdn,
    subscr_id,
    email_address,
    age,
    join_date,
    gender,
    postal_sector,
    handset_model,
    handset_manufacturer,
    needs_segment_name,
    smart_phone_ind,
    operating_system_name,
    lte_subscr_ind,
    bill_cycle_day,
    avg_3_mths_spend,
    avg_3_mths_calls_usage,
    avg_3_mths_sms_usage,
    avg_3_mths_data_usage,
    avg_3_mths_intl_calls_usage,
    avg_3_mths_roam_calls_usage,
    avg_3_mths_roam_sms_usage,
    avg_3_mths_roam_data_usage,
    data_bolton_ind,
    insurance_bolton_ind,
    o2travel_optin_ind,
    pm_registered_ind,
    connection_dt,
    contract_start_dt,
    contract_end_dt,
    contract_term_mths,
    upgrade_dt,
    cust_tenure_mths,
    pay_and_go_migrated_ind,
    pay_and_go_migrated_dt,
    ported_in_ind,
    ported_in_dt,
    ported_in_from_netwk_name,
    disconnection_dt,
    tariff_name,
    sim_only_ind,
    acquisition_channel_name,
    billing_system_name,
    last_billing_date,
    event_desc,
    contact_event_type_cd,
    event_start_dt,
    campaign_cd,
    texts_optin_ind,
    email_optin_ind,
    phone_optin_ind,
    post_optin_ind,
    all_marketing_optin_ind)
FROM 'input.csv' 
DELIMITER ',';
 
SELECT 
	msisdn, 
	email_adress,
	CASE
                WHEN age < 18 THEN '<18'
                WHEN age BETWEEN 18 AND 25 THEN '18-25'
                WHEN age BETWEEN 26 AND 35 THEN '26-35'
                WHEN age BETWEEN 36 AND 45 THEN '36-45'
                ELSE '>45'
            END AS age_band,
  CASE    WHEN gender = 'male' THEN 'M' 
          WHEN gender = 'female' THEN 'F' 
          ELSE 'U' 
          END AS gender,
    (DATE_PART('day', join_date) - 1) AS j_day,
    (DATE_PART('month', join_date)) AS j_month,
    (DATE_PART('year', join_date)) AS j_year,
    postal_sector,
    handset_model,
    handset_manufacturer,
    needs_segment_name,
    smart_phone_ind,
    operating_system_name,
    lte_subscr_ind,
    bill_cycle_day,
    avg_3_mths_spend,
    avg_3_mths_calls_usage,
    avg_3_mths_sms_usage,
    avg_3_mths_data_usage,
    avg_3_mths_intl_calls_usage,
    avg_3_mths_roam_calls_usage,
    avg_3_mths_roam_sms_usage,
    avg_3_mths_roam_data_usage,
    CASE WHEN avg_3_mths_spend <> 0 OR
    avg_3_mths_calls_usage <> 0 OR
    avg_3_mths_sms_usage <> 0 OR
    avg_3_mths_data_usage <> 0 OR
    avg_3_mths_intl_calls_usage <> 0 OR
    avg_3_mths_roam_calls_usage <> 0 OR
    avg_3_mths_roam_sms_usage <> 0 OR
    avg_3_mths_roam_data_usage <> 0 THEN 'Y' ELSE 'N' 
    END AS avg_available,
	  data_bolton_ind,
    insurance_bolton_ind,
    o2travel_optin_ind,
    pm_registered_ind,
    connection_dt,
    contract_start_dt,
    contract_end_dt,
    contract_term_mths,
    upgrade_dt,
    cust_tenure_mths,
    pay_and_go_migrated_ind,
    pay_and_go_migrated_dt,
    ported_in_ind,
    ported_in_dt,
    ported_in_from_netwk_name,
    disconnection_dt,
    tariff_name,
    sim_only_ind,
    acquisition_channel_name,
    billing_system_name,
    last_billing_date,
    event_desc,
    contact_event_type_cd,
    event_start_dt,
    campaign_cd,
    texts_optin_ind,
    email_optin_ind,
    phone_optin_ind,
    post_optin_ind,
    all_marketing_optin_ind
	FROM input_tab WHERE (msisdn, subscr_id, email_address) IS NOT NULL;

--Task2

--A

SELECT 
  msisdn, 
  email_address 
FROM 
  input_tab 
WHERE 
  age < '30' 
  AND contract_end_dt <= CURRENT_DATE 
  AND email_optin_ind = 'Y' 
  AND (msisdn, subscr_id, email_address) is NOT NULL;

--B
--v1
--max

SELECT 
  j_month AS max_j_month, 
  count(j_month) as most_subs_connected 
FROM 
  output_tab 
GROUP BY 
  j_month 
HAVING 
  COUNT (j_month)=(
    SELECT 
      MAX(mycount) 
    FROM 
      (
        SELECT 
          j_month, 
          COUNT(j_month) mycount 
        FROM 
          output_tab 
        GROUP BY 
          j_month
      ) b
  );

--min

SELECT 
  j_month AS min_j_month, 
  count(j_month) as least_subs_connected 
FROM 
  output_tab 
GROUP BY 
  j_month 
HAVING 
  COUNT (j_month)=(
    SELECT 
      min(mycount) 
    FROM 
      (
        SELECT 
          j_month, 
          COUNT(j_month) mycount 
        FROM 
          output_tab 
        GROUP BY 
          j_month
      ) b
  );

--v2

SELECT max_j_month, most_subs_connected, min_j_month, least_subs_connected
FROM  (SELECT j_month AS max_j_month, count(j_month) AS most_subs_connected
        FROM output_tab  
        GROUP BY j_month 
        HAVING COUNT (j_month)=( 
                                SELECT MAX(mycount) 
                                FROM ( 
                                        SELECT j_month, COUNT(j_month) mycount 
                                        FROM output_tab 
                                        GROUP BY j_month
                                    ) b1
                                )
        ) max,
       (SELECT j_month AS min_j_month, count(j_month) as least_subs_connected
        FROM output_tab  GROUP BY j_month 
        HAVING COUNT (j_month)=( 
                                SELECT min(mycount) 
                                FROM ( 
                                        SELECT j_month, COUNT(j_month) mycount 
                                        FROM output_tab 
                                        GROUP BY j_month
                                    ) b1
                                )
        ) min;

--C

--v1

SELECT 
  age_band, 
  SUM(avg_3_mths_spend) AS max_avg_3_mths_spend_sum 
FROM 
  output_tab 
GROUP BY 
  age_band 
ORDER BY 
  SUM(avg_3_mths_spend) DESC 
LIMIT 
  1;

--v2

SELECT 
  age_band, 
  MAX(sum_of_spend) AS max_avg_3_mths_spend_sum 
FROM 
  (
    SELECT 
      sum(avg_3_mths_spend) AS sum_of_spend, 
      age_band 
    FROM 
      output_tab 
    GROUP BY 
      age_band
  ) als 
GROUP BY 
  age_band 
ORDER BY 
  MAX(sum_of_spend) DESC 
LIMIT 
  1;

-- v3

SELECT 
  age_band, 
  max(dat.sum_of_spend) as max_avg_3_mths_spend_sum 
FROM 
  (
    SELECT 
      age_band, 
      (
        sum(avg_3_mths_spend)
      ) AS sum_of_spend 
    FROM 
      output_tab 
    GROUP BY 
      age_band
  ) dat 
GROUP BY 
  age_band 
ORDER BY 
  MAX(sum_of_spend) DESC 
LIMIT 
  1;

--D

SELECT calls.tariff_name AS best_tariff_name_calls, sms.tariff_name AS best_tariff_name_sms, datas.tariff_name AS best_tariff_name_data
FROM
    (SELECT tariff_name, avg_3_mths_calls_usage
    FROM output_tab 
    WHERE avg_3_mths_calls_usage = (SELECT MAX(avg_3_mths_calls_usage) 
                                    FROM output_tab
                                    )
    ) calls,
    (SELECT tariff_name, avg_3_mths_sms_usage
    FROM output_tab 
    WHERE avg_3_mths_sms_usage =   (SELECT MAX(avg_3_mths_sms_usage) 
                                    FROM output_tab
                                    )
    ) sms,
    (SELECT tariff_name, avg_3_mths_data_usage
    FROM output_tab 
    WHERE avg_3_mths_data_usage =  (SELECT MAX(avg_3_mths_data_usage) 
                                    FROM output_tab
                                    )
    ) datas;




















