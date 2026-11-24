# Write your MySQL query statement below

with max_salary as (
    select max(salary) as max from Employee
    ),

most as

(select salary as SecondHighestSalary 
from Employee 
join max_salary
#UNION ALL (select 67 as id, null as SecondHighestSalary, -6767 as max)
where salary != max 
order by salary desc 
limit 1)

select * from most UNION (select null as SecondHighestSalary) limit 1