# Week 1 project answers and queries in [Snowflake](https://app.snowflake.com/us-east-1/ryb00700/data/databases/DEV_DB/schemas/DBT_MAKLUDO07)

  
## How many users do we have? => __130 users__

```sql
SELECT COUNT(DISTINCT user_id) FROM dev_db.dbt_makludo07.stg_greenery__users;
```
      
## On average, how many orders do we receive per hour? => __15 orders per hour__

      ```sql
      WITH orders_per_hour AS (
         SELECT
            hour(created_at_utc) AS created_hour,
            COUNT(order_guid) AS orders
         FROM dev_db.dbt_makludo07.stg_greenery__orders
         GROUP BY 1
      )

      SELECT AVG(orders) FROM orders_per_hour;
      ```            

## On average, how long does an order take from being placed to being delivered? => __93 hours__

      ```sql
      SELECT AVG(TIMEDIFF(hour, created_at_utc, delivered_at_utc)) FROM dev_db.dbt_makludo07.stg_greenery__orders;
      ```

## How many users have only made one purchase? Two purchases? Three+ purchases? =>__25, 28 and 71 users for each case respectively__

      ```sql
      WITH number_orders_per_user AS (
         SELECT
            user_guid,
            COUNT(order_guid) AS orders
         FROM dev_db.dbt_makludo07.stg_greenery__orders
         GROUP BY 1
      )

      SELECT
         CASE
            WHEN orders < 3 THEN orders::VARCHAR
            ELSE '3+'
         END AS number_orders,
         COUNT(user_guid) AS users
      FROM number_orders_per_user
      GROUP BY 1
      ORDER BY 1
      ;
      ```

 _Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase._

## On average, how many unique sessions do we     have per hour? =>__39 unique sessions per hour__

      ```sql
      WITH unique_sessions_per_hour AS (
         SELECT
         HOUR(created_at) AS created_hour,
         COUNT(DISTINCT session_id) AS unique_sessions
         FROM dev_db.dbt_makludo07.stg_greenery__events
         GROUP BY 1
      )

      SELECT AVG(unique_sessions) FROM unique_sessions_per_hour;
      ```