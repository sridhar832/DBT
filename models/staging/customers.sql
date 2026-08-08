{{config(materialized='table',transient=false)}}


SELECT 
CAST(ID AS VARCHAR(10)) AS ID,
FIRST_NAME,
LAST_NAME
FROM {{source('datafeed_shared_schema','RAW_CUSTOMER_DATA')}}