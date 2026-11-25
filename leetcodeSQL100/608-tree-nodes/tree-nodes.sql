# Write your MySQL query statement below

with wide as (

select base.id as base_id, parents.id as parent_id, children.id as children_id
from Tree base
left join Tree parents
on base.p_id = parents.id
left join Tree children
on base.id = children.p_id

)

select base_id as id,
    case when parent_id is null then 'Root'
         when children_id is null then 'Leaf'
         else 'Inner' end as type
from wide
group by id
