-- with accepts as (select accepter_id, count(accepter_id) as cnt from RequestAccepted group by accepter_id),
-- requests as (
--     select requester_id, count(requester_id) as cnt from RequestAccepted group by requester_id
--     )

-- select a.accepter_id as id, IFNULL(a.cnt, 0) + IFNULL(r.cnt, 0) as num
-- from accepts a join requests r on a.accepter_id = r.requester_id
-- order by num desc
-- limit 1

with accepts as (select accepter_id as id from RequestAccepted),
requests as (select requester_id as id from RequestAccepted),
full_list as (select id as id
                FROM accepts UNION ALL 
                select id as id
                from requests )

select id, count(id) as num from full_list group by id order by num desc limit 1