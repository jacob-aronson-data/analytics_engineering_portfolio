# Write your MySQL query statement below

select *
from Patients
where conditions LIKE '%DIAB1%' and conditions NOT LIKE 'SADIAB%' and conditions NOT LIKE '%+DIAB%' and conditions Not LIKE 'PIN2%'