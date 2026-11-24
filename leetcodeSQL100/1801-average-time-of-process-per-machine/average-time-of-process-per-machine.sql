# Write your MySQL query statement below

-- Write your PostgreSQL query statement below

with activity2 as (select * from activity)

select activity.machine_id, round(avg(activity2.timestamp - activity.timestamp), 3) as "processing_time"
from activity
    join activity2 on activity.machine_id = activity2.machine_id
where  activity.process_id = activity2.process_id
        and activity.activity_type = 'start' and activity2.activity_type = 'end'
group by activity.machine_id