delete from person
where id in (
    select id from (
            select *, rank() over(partition by email order by id) as rnk
            from person
    ) ranked
    where rnk != 1
)