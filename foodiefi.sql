use schema TIL_PLAYGROUND.CS3_FOODIE_FI;

-- Section A: Customer Journey -- 

-- Customer 1: Joined on the free trial at the start of August 2020, then upgraded to the basic monthly a week later
-- Customer 2: Joined on the free trial on September 20th, 2020 then upgraded to the pro annual a week later
-- Customer 11: Tried the free trial for a week in November 2020, then churned at the end
-- Customer 13: Joined on the free trial in December 2020, upgraded to the basic monthly at the end of it, then re-upgraded to the pro monthly after 3 more months
-- Customer 15: Joined on the free trial in March 2020, spent a month on the pro monthly after that, then churned afterwards
-- Customer 16: Bought the basic monthly after the free trial and upgraded to the pro annual after 4 months
-- Customer 18: Started on the free trial and bought the pro monthly immediately after
-- Customer 19: Started on the free trial, bought the basic monthly at the end, then upgraded to the pro monthly after 2 months

-- Section B: Data Analysis Questions --

-- 1. How many customers has Foodie-Fi ever had? --
select count(distinct customer_id) as customer_count
from subscriptions;

-- 2. What is the monthly distribution of trial plan start_date values for our dataset --
select date_trunc(month, s.start_date) as "Start Month", count(*) as count
from subscriptions s join plans p on s.plan_id = p.plan_id
where p.plan_name = 'trial'
group by all
order by "Start Month";

-- 3. What plan start_date values occur after the year 2020 for our dataset? --
select p.plan_name, count(*) as count
from subscriptions s join plans p on s.plan_id = p.plan_id
where s.start_date >= '2020-01-01'
group by all;

-- 4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place? --
with only_churners as(
    select s.customer_id, max(case when p.plan_name = 'churn' then 1 else 0 end) as ever_churned
    from subscriptions s join plans p on s.plan_id = p.plan_id
    group by s.customer_id
    having ever_churned = 1
)
select sum(ever_churned) as total_churners
from only_churners;

with all_customers as(
    select s.customer_id, max(case when p.plan_name = 'churn' then 1 else 0 end) as ever_churned
    from subscriptions s join plans p on s.plan_id = p.plan_id
    group by s.customer_id
)
select concat(to_varchar(round(avg(ever_churned) * 100, 1)), '%') as churn_rate
from all_customers;

-- 5. How many customers have churned straight after their initial free trial? --
with all_customers as(
    select customer_id,
       case when sum(plan_id) = 4 and 
                 avg(plan_id) = 2 and 
                 count(plan_id) = 2 
            then 1 else 0 end as trial_to_churn
    from subscriptions
    group by customer_id
)
select concat(to_varchar(round(avg(trial_to_churn) * 100, 0)), '%') as "Direct Trial to Churn Rate"
from all_customers;


-- 6. What is the number and percentage of customer plans after their initial free trial? --
with all_customers as (
    select customer_id,
            case when min(plan_id) = 0 and 
                 max(plan_id) > 0 and 
                 max(plan_id) < 4
            then 1 else 0 end as past_free_trial
    from subscriptions
    group by customer_id
)
select concat(to_varchar(round(avg(past_free_trial) * 100, 1)), '%') as "Past Free Trial Rate",
       sum(past_free_trial) as "Past Free Trial Customers"       
from all_customers;

-- 7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31? --

-- ????? 

-- 8. How many customers have upgraded to an annual plan in 2020? --
select count(distinct customer_id) as upgrader_count
from subscriptions
where plan_id = 3 and year(start_date) = 2020;

-- 9. How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi? --
with reformat as (
    select customer_id, datediff(day, min(start_date), min(case when plan_id = 3 then start_date else null end)) as days_to_annual
    from subscriptions
    group by customer_id
    having not is_null_value(days_to_annual)
)
select round(avg(days_to_annual), 1) as "Average Days to Annual" from reformat;

-- 10. Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc) --
with reformat as (
    select customer_id, datediff(day, min(start_date), min(case when plan_id = 3 then start_date else null end)) as days_to_annual
    from subscriptions
    group by customer_id
    having not is_null_value(days_to_annual)
)
select case 
        when days_to_annual < 30 then 'a. <30 days' 
        when days_to_annual <= 60 then 'b. 30-60 days' 
        when days_to_annual <= 120 then 'c. 61-120 days' 
        else 'd. >120 days' end as days_bucket,
       count(*) as customer_count
from reformat
group by all
order by days_bucket;

-- 11. How many customers downgraded from a pro monthly to a basic monthly plan in 2020? --
with lag_cte as (
    select customer_id,
            plan_id,
            start_date,
            lag(plan_id) over (partition by customer_id order by start_date) as previous_plan
    from subscriptions)
select count(*) as "Number of Downgraders"
from lag_cte 
where plan_id = 1 and previous_plan = 2 and year(start_date) = 2020;

select * from plans
