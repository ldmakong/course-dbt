{{
    config(
        materialized= 'table'
    )
}}

with session_length as (
    select
      session_id
      , min(created_at) as first_event
      , max(created_at) as last_event
    from {{ ref('stg_greenery__events')}}
    group by 1
)

, session_events_agg as (
  select * from {{ref('int_session_events_macro_agg')}}
)

, users as (
  select * from {{ref('stg_greenery__users')}}
)

select 
  session_events_agg.session_id
  , session_events_agg.user_id
  , users.first_name
  , users.last_name
  , users.email
  , session_events_agg.page_views
  , session_events_agg.add_to_carts
  , session_events_agg.checkouts
  , session_events_agg.package_shippeds
  , session_length.first_event as first_session_event
  , session_length.last_event as last_session_event
  , datediff('minute', session_length.first_event, session_length.last_event) as session_length_minutes

from session_events_agg
left join users
 on session_events_agg.user_id = users.user_id
left join session_length
 on session_events_agg.session_id = session_length.session_id
