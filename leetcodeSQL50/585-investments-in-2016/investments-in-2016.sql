# Write your MySQL query statement below


with same_as_15 as (
    select i1.*
    from Insurance i1
    join Insurance i2
    on i1.tiv_2015 = i2.tiv_2015
    where i1.pid != i2.pid
    group by i1.pid
),

different_city_part1 as(
    select i1.*, 
        i2.pid as pid2, 
        i2.tiv_2015 as tiv_20152, 
        i2.tiv_2016 as tiv_20162, 
        i2.lat as lat2, 
        i2.lon as lon2
    from Insurance i1
    join Insurance i2
),

different_city_part2 as(
    select pid#, pid2, min((abs(lat - lat2) + abs(lon - lon2))) as diff
    from different_city_part1
    where pid != pid2
    group by pid
    having min((abs(lat - lat2) + abs(lon - lon2))) != 0
)

select round(sum(tiv_2016), 2) as tiv_2016
from same_as_15 s join different_city_part2 d on s.pid = d.pid

#select * from same_as_15 s join different_city d on s.pid = d.pid