-- Lego Portfolio Project https://github.com/wjsutton/lego_analysis_challenge/tree/main ---

create schema til_portfolio_projects.ja_lego_project;
use schema til_portfolio_projects.ja_lego_project;

-- Create Tables --
create or replace table colors as select * from til_portfolio_projects.staging.lego_colors;
create or replace table inventory_parts as select * from til_portfolio_projects.staging.lego_inventory_parts;
create or replace table inventories as select * from til_portfolio_projects.staging.lego_inventories;
create or replace table inventory_sets as select * from til_portfolio_projects.staging.lego_inventory_sets;
create or replace table sets as select * from til_portfolio_projects.staging.lego_sets;
create or replace table themes as select * from til_portfolio_projects.staging.lego_themes;
create or replace table parts as select * from til_portfolio_projects.staging.lego_parts;
create or replace table categories as select * from til_portfolio_projects.staging.lego_part_categories;

-- Set Primary Keys --

-- table colors;
alter table colors add primary key (id);

-- table inventories;
alter table inventories add primary key (id);
--alter table inventories add foreign key (id) references inventory_parts(inventory_id);

-- table themes;
alter table themes add primary key (id);

-- table parts;
alter table parts add primary key (part_num);

-- table categories;
alter table categories add primary key (id);

-- Add Foreign Keys;
alter table inventory_sets add foreign key (inventory_id) references inventories(id);
alter table inventory_parts add foreign key (inventory_id) references inventories(id);
alter table inventory_parts add foreign key (part_num) references parts(part_num);
alter table inventory_parts add foreign key (color_id) references colors(id);
alter table inventories add foreign key (set_num) references sets(set_num);
alter table parts add foreign key (part_cat_id) references categories(id);
alter table sets add foreign key (theme_id) references themes(id);
