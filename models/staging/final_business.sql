{{config(materialized='table',transient='false')}}

with customers as(
select id,
first_name,
last_name
from {{ref('emphr')}}
),
orders as(
    select id as order_id,
    user_id as customer_id,
    order_date,
    status
    from {{source('datafeed_shared_schema','RAW_ORDERS')}}
),
customers_orders as(
    select 
    customer_id,
    min(order_date) as first_order,
    max(order_date) as last_order,
    count(order_id) as number_of_orders
    from orders
    group by 1
),
final_data as(
    select 
    customers.id as customer_id,
    customers.first_name,
    customers.last_name,
    customers_orders.first_order,
    customers_orders.last_order,
    coalesce(customers_orders.number_of_orders,0) as no_of_orders
    from customers 
    left join customers_orders on customers.id=customers_orders.customer_id
)
select * from final_data
