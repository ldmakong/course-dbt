
{{
    config(
        materialized = 'table'
    )
}}
with order_items_source as (
    select * from {{ source('src_greenery', 'order_items')}}
)

select * from order_items_source