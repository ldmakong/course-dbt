{{
    config(
        materialized = 'table'
    )
}}

with users_source as (
    select * from {{ source('src_greenery', 'users')}}
)

select * from users_source