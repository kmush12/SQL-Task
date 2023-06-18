# SQL project

This is a simple project to transform records in a database.

## Table of contents
* [Installation](#installation)
* [Task 1](#task_1)
* [Task 2](#task_2)
* [A.](#a.)
* [B.](#b.)
* [C.](#c.)
* [D.](#d.)
  
## Installation

```bash
$ docker pull postgres
$ docker run -itd -e POSTGRES_USER=task -e POSTGRES_PASSWORD=task -p 5432:5432 -v /data:/var/lib/postgresql/data --name postgresql postgres
$ sudo docker cp ./input.csv postgres:/
$ docker exec -it postgresql bash
$ psql -h localhost postgres task
```

## Task 1
### Create table input
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
### Load data
```sql
COPY input_tab(msisdn,subscr_id,
    email_address,
    age,
    join_date,
    gender,
    postal_sector,
    handset_model,
    handset_manufacturer,
    needs_segment_nameOutput:,
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
FROM '/input.csv' 
DELIMITER ',';
```
### Create table output.

```sql
SELECT msisdn, 
email_address, 
CASE WHEN age < 18 THEN '<18' WHEN age BETWEEN 18 AND 25 THEN '18-25' WHEN age BETWEEN 26 AND 35 THEN '26-35' WHEN age BETWEEN 36 AND 45 THEN '36-45' ELSE '>45' END AS age_band, 
CASE   WHEN gender = 'male' THEN 'M' WHEN gender = 'female' THEN 'F' ELSE 'U' END AS age_band,
(DATE_PART('day', join_date) - 1) AS j_day,
(DATE_PART('month', join_date)) AS j_month,
(DATE_PART('year', join_date)) AS j_year,
postal_sector,
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
 CASE WHEN avg_3_mths_spend <> 0 OR avg_3_mths_calls_usage <> 0 OR avg_3_mths_sms_usage <> 0 OR avg_3_mths_data_usage <> 0 OR avg_3_mths_intl_calls_usage <> 0 OR avg_3_mths_roam_calls_usage <> 0 OR avg_3_mths_roam_sms_usage <> 0 OR avg_3_mths_roam_data_usage <> 0 THEN 'Y' ELSE 'N'  END AS avg_available,
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
 campaign_cd, texts_optin_ind,
 email_optin_ind,
 phone_optin_ind,
 post_optin_ind,
 all_marketing_optin_ind FROM input_tab WHERE (msisdn, subscr_id, email_address) IS NOT NULL;
```

<a name="task_2"></a>
## Task 2

<a name="a."></a>
### A. 
#### The operator must create an e-mail advertising campaign for a specific group of customers. Selected subscribers who are under 30 years of age have an active contract (contract_end_dt) and have opted in to email advertising (email_optin_ind).

```SQL
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
```
Output:

![alt text](https://github.com/kmush12/SQL-Task/blob/master/tab_a.png?raw=true)

<a name="b."></a>
### B. 
#### In which month did the most subscribers connect (join_date) and in which the least?

V1. In 2 queries

The most subscribers connect:
```SQL
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
```
Output:

![alt text](https://github.com/kmush12/SQL-Task/blob/master/tab_b_v1_max.png?raw=true)

The least subscribers connect:
```sql
SELECT j_month AS min_j_month, count(j_month) as least_subs_connected
FROM output_tab  GROUP BY j_month 
HAVING COUNT (j_month)=( 
SELECT min(mycount) 
FROM ( 
SELECT j_month, COUNT(j_month) mycount 
FROM output_tab 
GROUP BY j_month)b1);
```
Output:

![alt text](https://github.com/kmush12/SQL-Task/blob/master/tab_b_v1_min.png?raw=true)

V2. In 1 query

```SQL
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
```

Output:

![alt text](https://github.com/kmush12/SQL-Task/blob/master/tab_b_v2.png?raw=true)

<a name="c."></a>
### C. 
#### Which age bracket has the highest average monthly spend (avg_3_mths_spend) in each quarter of the year each year.

V 1. Szybsza metoda lecz zwraca tylko 1 rekord

```SQL
SELECT age_band, SUM(avg_3_mths_spend)
FROM output_tab
GROUP BY age_band
ORDER BY SUM(avg_3_mths_spend) DESC
LIMIT 1;
```
V 2. 

```SQL
SELECT age_band, max(b1.sum_of_spend) as max_avg_3_mths_spend_sum
FROM    (SELECT age_band, (sum(avg_3_mths_spend_group)) AS sum_of_spend
        FROM ((SELECT age_band, avg_3_mths_spend AS avg_3_mths_spend_group
        FROM output_tab
        GROUP BY  age_band, avg_3_mths_spend
        ))b1
        GROUP BY  age_band
        )b1
GROUP BY  age_band;
```

<a name="d."></a>
### D. 
#### Which tariff (tariff_name) is the most advantageous for the operator, taking into account separately calls, text messages and data transmission per year. Use the avg_3_mths_*usage columns.

```SQL
SELECT 
  calls.tariff_name AS best_tariff_name_calls, 
  sms.tariff_name AS best_tariff_name_sms, 
  datas.tariff_name AS best_tariff_name_data 
FROM 
  (
    SELECT 
      tariff_name, 
      avg_3_mths_calls_usage 
    FROM 
      output_tab 
    WHERE 
      avg_3_mths_calls_usage = (
        SELECT 
          MAX(avg_3_mths_calls_usage) 
        FROM 
          output_tab
      )
  ) calls, 
  (
    SELECT 
      tariff_name, 
      avg_3_mths_sms_usage 
    FROM 
      output_tab 
    WHERE 
      avg_3_mths_sms_usage = (
        SELECT 
          MAX(avg_3_mths_sms_usage) 
        FROM 
          output_tab
      )
  ) sms, 
  (
    SELECT 
      tariff_name, 
      avg_3_mths_data_usage 
    FROM 
      output_tab 
    WHERE 
      avg_3_mths_data_usage = (
        SELECT 
          MAX(avg_3_mths_data_usage) 
        FROM 
          output_tab
      )
  ) datas;
```
Output:

![alt text](https://github.com/kmush12/SQL-Task/blob/master/tab_d.png?raw=true)
## License

[MIT](https://choosealicense.com/licenses/mit/)
