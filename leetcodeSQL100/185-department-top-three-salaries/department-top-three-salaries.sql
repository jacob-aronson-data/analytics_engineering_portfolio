# Write your MySQL query statement below

with top3s as (

select salary, departmentId, rank() over (partition by departmentId order by salary desc) intraDepRank 
from Employee group by salary, departmentId

),

almost as (

select d.name as Department, t.salary as Salary, t.departmentId
from top3s t
    join Department d on t.departmentid = d.id
where intraDepRank <= 3

)

select a.Department as Department, E.name as Employee, E.salary as Salary
from almost a right join Employee E on a.departmentId = E.departmentId and a.salary = E.salary
where not ISNULL(a.Department)