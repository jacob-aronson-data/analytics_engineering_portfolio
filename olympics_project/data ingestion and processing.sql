-- create schema til_portfolio_projects.ja_olympics_project;

create or replace table olympics_staging (
    ID INT,
    Name VARCHAR,
    Sex VARCHAR,
    Age INT,
    Height INT,
    Weight INT,
    Team VARCHAR,
    NOC VARCHAR,
    Games VARCHAR,
    Year INT,
    Season VARCHAR,
    City VARCHAR,
    Sport VARCHAR,
    Event VARCHAR,
    Medal VARCHAR,
    NOC_Region VARCHAR,
    NOC_notes VARCHAR
);

-- Loaded data using snowsight UI

-- Scan Data --
select * from olympics_staging limit 1;

create or replace table dim_team as (
    with uniques as(
        SELECT DISTINCT 
    	team,
    	noc,
    	noc_region,
    	NOC_notes
    	FROM olympics_staging
    )
    
    SELECT 
    ROW_NUMBER() OVER(ORDER BY team) as team_id,
    team,
    noc,
    noc_region,
    NOC_notes
    FROM uniques
);

create or replace table dim_athletes as (
    with uniques as(
        SELECT DISTINCT 
    	name,
    	sex
    	FROM olympics_staging
    )
    
    SELECT 
    ROW_NUMBER() OVER(ORDER BY name) as athlete_id,
        name,
    	sex
    FROM uniques
);

create or replace table dim_games as (
    with uniques as(
        SELECT DISTINCT 
    	year,
    	season,
        city,
        games
    	FROM olympics_staging
    )
    
    SELECT 
    ROW_NUMBER() OVER(ORDER BY games) as games_id,
        year,
    	season,
        city,
        games
    FROM uniques
);

create or replace table dim_events as (
    with uniques as(
        SELECT DISTINCT 
    	sport,
    	event
    	FROM olympics_staging
    )
    
    SELECT 
    ROW_NUMBER() OVER(ORDER BY event) as event_id,
        sport,
    	event
    FROM uniques
);

create or replace table fact_table as (
    select dt.team_id, da.athlete_id, dg.games_id, de.event_id, o.age, o.height, o.weight, o.medal
    from olympics_staging o
    left join dim_team dt
        on o.team = dt.team and o.noc = dt.noc and o.noc_region = dt.noc_region
    left join dim_athletes da 
        on o.name = da.name and o.sex = da.sex
    left join dim_games dg
        on o.year = dg.year and o.season = dg.season and o.city = dg.city and o.games = dg.games
    left join dim_events de
        on o.sport = de.sport and o.event = de.event

);

alter table dim_athletes add primary key(athlete_id);
alter table dim_team add primary key(team_id);
alter table dim_games add primary key(games_id);
alter table dim_events add primary key(event_id);

alter table fact_table add foreign key (athlete_id) references dim_athletes(athlete_id);
alter table fact_table add foreign key (team_id) references dim_team(team_id);
alter table fact_table add foreign key (games_id) references dim_games(games_id);
alter table fact_table add foreign key (event_id) references dim_events(event_id);
