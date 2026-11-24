-- # Write your MySQL query statement below


 WITH leading_reviewer as (
    select u.name as results 
    from Users u 
        join MovieRating mr on u.user_id = mr.user_id 
        group by u.name
        order by count(mr.rating) desc, u.name asc
        limit 1),
    top_score as (
        select m.title as results
        from Movies m 
        join MovieRating mr 
            on m.movie_id = mr.movie_id 
        where date(mr.created_at) < date('2020-03-01') and date(mr.created_at) > date('2020-01-31')
        group by m.title 
        order by avg(mr.rating) desc, length(results) desc, m.title asc
        limit 1
        )

SELECT * from leading_reviewer UNION ALL TABLE top_score
