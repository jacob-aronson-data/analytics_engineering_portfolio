# Write your MySQL query statement below


with joined_and_ranked as (
    select d.name as Department, e.name as Employee, e.salary as Salary, rank() over (partition by departmentId order by salary desc) dep_sal_rank
    from Employee e
    join Department d
    on e.departmentId = d.id 
)

select Department, Employee, Salary
from joined_and_ranked
where dep_sal_rank = 1