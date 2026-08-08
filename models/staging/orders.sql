{{config(materialized='table')}}


    select 
    id,
    user_id,
    order_date,
    status from {{source('datafeed_shared_schema','RAW_ORDERS')}}
