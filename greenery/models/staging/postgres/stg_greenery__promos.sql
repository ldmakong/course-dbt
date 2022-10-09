
{{
    config(
        materialized = 'table'
    )
}}
with promos_source as (
    select * from {{ source('src_greenery', 'promos')}}
)

select * from promos_source