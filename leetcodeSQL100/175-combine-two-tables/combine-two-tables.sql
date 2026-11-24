# Write your MySQL query statement below

select Person.firstName, person.lastName, city, state
from Person
left join Address on
Person.personId = Address.personId