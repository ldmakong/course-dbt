{{
  config(
    materialized='table'
  )
}}


select
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.created_at,
    u.updated_at,
    a.address,
    a.zipcode,
    a.state,
    a.country
from {{ ref('stg_greenery__users') }} u
left join {{ ref('stg_greenery__addresses') }} a 
  on u.address_id = a.address_id 
