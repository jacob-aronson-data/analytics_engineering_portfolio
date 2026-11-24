# Write your MySQL query statement below

select l.book_id, l.title, l.author, l.genre, l.publication_year, count(*) as current_borrowers
from library_books l
join borrowing_records b
    on l.book_id = b.book_id
where return_date is null
group by l.book_id
having max(total_copies) = count(*)
order by current_borrowers desc, l.title asc