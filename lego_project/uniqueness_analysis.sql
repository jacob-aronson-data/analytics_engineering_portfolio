-- Identify parts that only appear in one LEGO set
select parts.part_num, parts.name, count(distinct inventories.set_num) as lego_sets_part_is_found_in
from inventory_parts
join parts on inventory_parts.part_num = parts.part_num
join inventories on inventory_parts.inventory_id = inventories.id
group by all
having lego_sets_part_is_found_in = 1;

-- For each LEGO set, calculate the number of unique parts it includes and the total number of parts (count, not quantity);
with cte as (
    select sets.name, sets.year, count(parts.part_num) as total_num_parts, count(distinct parts.part_num) as unique_parts
    from sets
    join inventories on sets.set_num = inventories.set_num
    join inventory_parts on inventories.id = inventory_parts.inventory_id
    full join parts on parts.part_num = inventory_parts.part_num
    group by all
)

select name, year, unique_parts / total_num_parts as uniqueness_ratio from cte;

create or replace view sets_by_year_and_uniqueness as (

    with unique_parts as (
        select parts.part_num
        from parts
        join inventory_parts on parts.part_num = inventory_parts.part_num
        join inventories on inventories.id = inventory_parts.inventory_id
        join sets on sets.set_num = inventories.set_num
        group by parts.part_num
        having count(sets.name) = 1
    )
    
    select sets.name as set_name, 
           sets.year as "year", 
           themes.name as theme_name, 
           iff(unique_parts.part_num is null, 'Not Unique', 'Unique') as unique_part,
           count(parts.part_num) as parts
    from parts
    left join unique_parts on parts.part_num = unique_parts.part_num
    join inventory_parts on parts.part_num = inventory_parts.part_num
    join inventories on inventories.id = inventory_parts.inventory_id
    join sets on sets.set_num = inventories.set_num
    join themes on themes.id = sets.theme_id
    group by all
);

select *
from sets_by_year_and_uniqueness;
