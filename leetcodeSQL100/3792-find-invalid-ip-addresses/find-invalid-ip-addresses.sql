# Write your MySQL query statement below

with cte as (

select ip,
    (case when    ip regexp '256'
              or ip regexp '257'
              or ip regexp '258'
              or ip regexp '259'
              or ip regexp '2[6789][0123456789]'
              or ip regexp '[3456789][0123456789][0123456789]'
         then 1 else 0 end

    +

    case when ip regexp '^0[0-9]' or ip regexp '\\.0[0-9]' then 1 else 0 end

    +

    case when length(ip) - length(replace(ip, '.', '')) != 3 then 1 else 0 end

    

) as invalid_count
from logs
)

select * from cte
where invalid_count > 0
order by invalid_count desc, ip desc