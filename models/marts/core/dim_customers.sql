{{ config ( materialized="table")}}

with customers as (
    select * from {{ref('stg_customers')}}
),

orders as (
    select * from {{ref('stg_orders')}}
),

customer_orders as (
    select * from {{ref('fct_orders')}}
),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        --sum(customer_orders.amount) as lifetime_value --more sql-esque way to write this
        coalesce(customer_orders.amount, 0) as lifetime_value --more dbt way to write it

    from customers
    left join customer_orders 
    on customer_orders.customer_id = customers.customer_id
    --using (customer_id)
    group by customers.customer_id,
        customers.first_name,
        customers.last_name
)

select * from final
