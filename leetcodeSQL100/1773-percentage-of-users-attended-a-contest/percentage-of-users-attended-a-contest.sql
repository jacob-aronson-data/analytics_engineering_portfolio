-- Write your PostgreSQL query statement below

with total_users as (select count(*) as "user_count" from users)

select contest_id, ROUND(count(distinct user_id) / user_count * 100, 2) as "percentage"
from register cross join total_users
group by contest_id
order by percentage desc, contest_id asc