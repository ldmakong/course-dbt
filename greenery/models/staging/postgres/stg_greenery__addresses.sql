
{{
    config(
        materialized = 'table'
    )
}}
with addresses_source as (
    select * from {{ source('src_greenery', 'addresses')}}
)

select * from addresses_source