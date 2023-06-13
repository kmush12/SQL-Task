# TASK

This is a simple project to transform records in a database.

## Installation


```bash
$ docker pull postgres
$ docker run -itd -e POSTGRES_USER=task -e POSTGRES_PASSWORD=task -p 5432:5432 -v /data:/var/lib/postgresql/data --name postgresql postgres
$ docker exec -it postgresql bash
$ psql -h localhost postgres task
```

## Usage

```sql
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
```
Load data from input.csv file.
```sql
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
```
Create output table.
```sql
SELECT 
	msisdn, 
	email_adress, 
    	CASE   WHEN gender = 'male' THEN 'M' 
                    WHEN gender = 'female' THEN 'F' 
                    ELSE 'U' 
		    END AS age_band,
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
```

## License

[MIT](https://choosealicense.com/licenses/mit/)
