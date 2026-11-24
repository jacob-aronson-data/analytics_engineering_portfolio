-- Write your PostgreSQL query statement below
with e2 as (select * from employee)

select e.name
from employee as e inner join e2 on e.id = e2.managerID
group by e.name, e.id
having count(e2.name) >= 5 or e.name is null