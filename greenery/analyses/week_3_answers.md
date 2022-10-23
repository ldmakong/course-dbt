# Week 3 project answers and queries in [Snowflake](https://app.snowflake.com/us-east-1/ryb00700/data/databases/DEV_DB/schemas/DBT_MAKLUDO07)

  
#### What is our overall conversion rate ? => __62.5%__

```sql
SELECT 
        SUM(CASE WHEN event_type='checkout'THEN 1 ELSE  0 END)
        /COUNT(DISTINCT session_id)*100.0 as conversion_rate
FROM dev_db.dbt_makludo07.stg_greenery__events;
```

OR

```sql
SELECT COUNT(CASE WHEN checkouts = 1 then session_id end)/ COUNT(session_id)*100.0 AS conversion_rate
FROM dev_db.dbt_makludo07.int_session_events_macro_agg;
```

#### What is our conversion rate by product? 

```sql
SELECT
    name
    , 100.0*total_checkout / total_page_view AS conversion_rate_per_product 
FROM dev_db.dbt_makludo07.dim_products
ORDER BY conversion_rate_per_product desc;
```

#### Which orders changed from week 2 to week 3 ?

The orders that changed from week 2 to week 3 are the following :

- 8385cfcd-2b3f-443a-a676-9756f7eb5404
- e24985f3-2fb3-456e-a1aa-aaf88f490d70
- 5741e351-3124-4de7-9dff-01a448e7dfd4
- 914b8929-e04a-40f8-86ee-357f2be3a2a2
- 05202733-0e17-4726-97c2-0520c024ab85
- 939767ac-357a-4bec-91f8-a7b25edd46c9

I noticed all of them had a "preparing" status. Moreoever, I applied the following SQL query on the snapshot model on orders [here](greenery/snapshots/snapshot_orders.sql) created in week 1 :

```sql
SELECT * FROM dev_db.dbt_makludo07.snapshot_orders WHERE DBT_VALID_TO IS NOT NULL;    
```