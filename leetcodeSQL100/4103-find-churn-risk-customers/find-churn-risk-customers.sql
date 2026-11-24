# Write your MySQL query statement below

with preranking_for_current_plans as (
    select user_id, plan_name, event_type, monthly_amount, rank() over(partition by user_id order by event_date desc) as rnk
    from subscription_events
),

current_plans as (
    select user_id,
           plan_name as current_plan, 
           monthly_amount as current_monthly_amount 
    from preranking_for_current_plans 
    where rnk = 1 and event_type != 'cancel'
),

aggregations as (
    select user_id, max(monthly_amount) as max_historical_amount, abs(datediff(max(event_date), min(event_date))) as days_as_subscriber
    from subscription_events
    group by user_id
    having days_as_subscriber >= 60 and 
           max(case when event_type = 'downgrade' then 1 else 0 end) = 1
           and max(case when event_type = 'cancel' then 1 else 0 end) = 0
)

select c.*, a.max_historical_amount, a.days_as_subscriber
from current_plans c
join aggregations a
    on c.user_id = a.user_id
where current_monthly_amount * 2 < max_historical_amount
order by a.days_as_subscriber desc, user_id asc
