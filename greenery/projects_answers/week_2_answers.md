# Week 2 project answers and queries in [Snowflake](https://app.snowflake.com/us-east-1/ryb00700/data/databases/DEV_DB/schemas/DBT_MAKLUDO07)

  
#### What is our user repeat rate ? => __Repeat Rate = Users who purchased 2 or more times / users who purchase = 79.8%__

```sql
WITH orders_cohort AS (
   SELECT
    user_guid
    , COUNT(DISTINCT order_guid) as user_orders
   FROM dev_db.dbt_makludo07.stg_greenery__orders
   GROUP BY 1
)

, user_bucket as (
  SELECT
    user_guid
    , (user_orders = 1)::int as has_one_purchases
    , (user_orders >= 2)::int as has_two_plus_purchases
  FROM orders_cohort
)

SELECT
  div0(SUM(has_two_plus_purchases), COUNT(DISTINCT user_guid)) AS repeat_rate
FROM user_bucket;
```
      
