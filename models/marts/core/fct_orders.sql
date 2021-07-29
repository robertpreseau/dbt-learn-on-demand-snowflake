with customers as (
        select id as order_id,
        user_id as customer_id
        from dbt-tutorial.jaffle_shop.orders
),

orders as (
        select id as order_id,
        amount
        from dbt-tutorial.stripe.payment
)

select customers.order_id,
       customers.customer_id,
       orders.amount
from orders
join customers
on customers.order_id = orders.order_id
