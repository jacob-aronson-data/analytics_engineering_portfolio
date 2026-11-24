# Write your MySQL query statement below

select customer_id
from customer_transactions
group by customer_id
having sum(case when transaction_type = 'purchase' then 1 else 0 end) >= 3 
       and datediff(max(transaction_date), min(transaction_date)) >= 30 
       and avg(case when transaction_type = 'refund' then 1 else 0 end) < 0.2