# Write your MySQL query statement below

with agg as (select email, count(*) as cnt from Person group by email) select email from agg where cnt > 1