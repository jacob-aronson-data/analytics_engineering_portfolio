# Write your MySQL query statement below

WITH all_this AS(

WITH mins AS (select player_id, 
        min(event_date) AS first_login
from Activity
group by player_id)

select max(IF(datediff(m.first_login, a.event_date) = -1, 1, 0)) as day_after_login_check

from activity a left join

mins m

on

m.player_id = a.player_id

group by a.player_id

)

SELECT round(avg(day_after_login_check), 2) AS fraction FROM all_this
