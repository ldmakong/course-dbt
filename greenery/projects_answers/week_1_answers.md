# Week 1 project answers and queries in [Snowflake](https://app.snowflake.com/us-east-1/ryb00700/data/databases/DEV_DB/schemas/DBT_MAKLUDO07)

 Markup : * How many users do we have? => __130 users__

                ```psql
                select count(distinct user_id) from dev_db.dbt_makludo07.stg_greenery__users
                ```

          * On average, how many orders do we receive per hour? =>__15 orders per hour__

                ```sql
                  with orders_per_hour as (
                     select
                        hour(created_at_utc) as created_hour,
                        count(order_guid) as orders
                     from dev_db.dbt_makludo07.stg_greenery__orders
                     group by 1
                  )

                  select avg(orders) from orders_per_hour;
                ```            

          * On average, how long does an order take from being placed to being delivered? =>__93 hours__

               ```sql
               select avg(timediff(hour, created_at_utc, delivered_at_utc)) from dev_db.dbt_makludo07.stg_greenery__orders;
               ```

          * How many users have only made one purchase? Two purchases? Three+ purchases? =>__25, 28 and 71 users for each case respectively__

               ```sql
               with number_orders_per_user as (
                  select
                     user_guid,
                     count(order_guid) as orders
                  from dev_db.dbt_makludo07.stg_greenery__orders
                  group by 1
               )

               select
                  case
                     when orders < 3 then orders::varchar
                     else '3+'
                  end as number_orders,
                  count(user_guid) as users
               from number_orders_per_user
               group by 1
               order by 1
               ;
               ```

          * _Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase._

          * On average, how many unique sessions do we have per hour? =>__39 unique sessions per hour__

            ```sql
            with unique_sessions_per_hour as (
               select
               hour(created_at) as created_hour,
               count(distinct session_id) as unique_sessions
               from dev_db.dbt_makludo07.stg_greenery__events
               group by 1
            )

            select avg(unique_sessions) from unique_sessions_per_hour;
            ```