# Write your MySQL query statement below

with wide as (
    select  e1.employee_id as tier1, e2.employee_id as tier2, e3.employee_id as tier3, e4.employee_id as tier4
    from Employees e1
    left join Employees e2
    on e1.employee_id = e2.manager_id
    left join Employees e3
    on e2.employee_id = e3.manager_id
    left join Employees e4
    on e3.employee_id = e4.manager_id
),

unioned as (
    select tier1, tier2 from wide
    union all
    select tier1, tier3 from wide
    union all 
    select tier1, tier4 from wide
    union all
    select tier2, tier3 from wide
    union all
    select tier2, tier4 from wide
    union all 
    select tier3, tier4 from wide
),

pairs as (
    select tier1 as parent_id, tier2 as child_id
    from unioned 
    group by tier1, tier2 
    order by tier1, tier2
),

all_except_budget as (
    select e.employee_id, 
        e.employee_name,
        count(distinct ifnull(child_id, '')) - 1 as team_size
    from pairs p
    left join employees e
        on p.parent_id = e.employee_id
    left join wide w
        on w.tier1 = p.parent_id
    left join employees c
        on p.child_id = c.employee_id
    group by p.parent_id
),

add_most_budgets as (
    select a.*, sum(e.salary) + max(self.salary) as budget
    from pairs p
    left join all_except_budget a
        on p.parent_id = a.employee_id
    left join employees e
        on p.child_id = e.employee_id
    left join employees self
        on p.parent_id = self.employee_id
    where a.employee_id is not null
    group by a.employee_id
),

fix_null_budgets as (
    select snb.employee_id, snb.employee_name, snb.team_size, ifnull(snb.budget, e.salary) as budget
    from add_most_budgets snb
    join employees e
        on snb.employee_id = e.employee_id
),

levels as (

    select tier1 as id,
           case when tier1 in (select tier4 from wide where tier4 is not null) then 4
                when tier1 in (select tier3 from wide where tier3 is not null) then 3
                when tier1 in (select tier2 from wide where tier2 is not null) then 2
                else 1 end as level
    from wide
    group by id

)

select f.employee_id, f.employee_name, l.level, f.team_size, f.budget
from fix_null_budgets f
join levels l
on f.employee_id = l.id
order by level asc, budget desc, employee_name asc