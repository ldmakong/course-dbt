{{
  config(
    materialized='table'
  )
}}


select 
  o.order_guid,
  o.user_guid,
  o.order_cost,
  o.shipping_cost,
  o.order_total_cost,
  o.order_status,
  o.created_at_utc,
  o.estimated_delivery_at_utc,
  o.delivered_at_utc,
  pr.discount,
  pr.status as promo_status
from {{ ref('stg_greenery__orders') }} o
left join {{ ref('stg_greenery__promos') }} pr
  on o.promo_desc = pr.promo_id 
