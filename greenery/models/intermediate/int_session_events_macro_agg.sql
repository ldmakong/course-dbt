{{
    config(
        materialized= 'table'
    )
}}

{%-
   set event_types = dbt_utils.get_column_values(
     table = ref('stg_greenery__events')
     , column = 'event_type'
     , order_by = 'event_type asc'
   )
-%}

SELECT
  user_id
  , session_id
  {%- for event_type in event_types %}
  , sum(case when event_type ='{{ event_type }}' then 1 else 0 end) as {{ event_type }}s
  {%- endfor %}
FROM {{ ref('stg_greenery__events') }}

group by 1,2