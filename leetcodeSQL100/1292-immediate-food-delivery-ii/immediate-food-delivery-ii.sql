# Write your MySQL query statement below

WITH summary_table AS(
    WITH mins AS (select customer_id, min(order_date) as min_order_date
                        from Delivery
                        group by customer_id)
    select IF(order_date = customer_pref_delivery_date, 1, 0) as is_immediate 
            from delivery d JOIN mins m on d.customer_id = m.customer_id
            where order_date = min_order_date
)
select round(avg(is_immediate) * 100, 2) as immediate_percentage from summary_table