
select e.employee_id# , as manager_id
from employees e
left join (select e1.*, TRUE as 'still_managed_flag' from employees e1 join employees e2 on IFNULL(e1.manager_id, 676767) = e2.employee_id) f
on e.employee_id = f.employee_id
where ISNULL(f.still_managed_flag) AND NOT ISNULL(e.manager_id) AND e.salary < 30000
order by e.employee_id