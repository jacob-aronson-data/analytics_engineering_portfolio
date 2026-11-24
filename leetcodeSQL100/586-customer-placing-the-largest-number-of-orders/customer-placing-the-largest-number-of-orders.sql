# Write your MySQL query statement below
select customer_number
from (select customer_number, count(order_number) as cnt from Orders group by customer_number order by cnt desc) test
limit 1