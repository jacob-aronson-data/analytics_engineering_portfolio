# Write your MySQL query statement below

with classified as (
    select account_id, 
            CASE
                WHEN income < 20000 THEN 'Low Salary'
                WHEN income <= 50000 THEN 'Average Salary'
                ELSE 'High Salary' END as category
    from Accounts
),

extra_union as(

select category, COUNT(account_id) as accounts_count
from classified
group by category

UNION ALL select "Average Salary" as category, 0 as accounts_count)

select category, sum(accounts_count) as accounts_count
from extra_union
group by category