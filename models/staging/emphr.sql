{{config(materialized='ephemeral')}}

select 
id,
first_name,
last_name 
from {{source('datafeed_shared_schema','RAW_CUSTOMER_DATA')}}