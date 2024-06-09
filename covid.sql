-- creating Covid Database

create database covid;
show databases;
use covid;


-- CREATING FIRST TABLE INCLUDING DEATHS RECORD 

create table coviddeaths(iso_code varchar(100),continent varchar(100),location varchar(100),dates varchar(100),
population varchar(100),total_cases varchar(100),new_cases varchar(100),new_cases_smoothed  varchar(100),total_deaths varchar(100),
new_deaths varchar(100),new_deaths_smoothed varchar(100),total_cases_per_million varchar(100),new_cases_per_million varchar(100),
new_cases_smoothed_per_million varchar(100),total_deaths_per_million varchar(100),new_deaths_per_million varchar(100),
new_deaths_smoothed_per_million varchar(100),reproduction_rate varchar(100),icu_patients varchar(100),icu_patients_per_million varchar(100),
hosp_patients varchar(100),hosp_patients_per_million varchar(100),weekly_icu_admissions varchar(100),weekly_icu_admissions_per_million varchar(100),
weekly_hosp_admissions varchar(100),weekly_hosp_admissions_per_million varchar(100));

show tables;
describe coviddeaths;
select count(*) from coviddeaths;


-- CREATING SECOND TABLE INCLUDING VACCINATIONS RECORD

create table vaccinations(iso_code varchar(100),continent varchar(100),location varchar(100),`date` varchar(100),new_tests varchar(100),
total_tests varchar(100),total_tests_per_thousand varchar(100),new_tests_per_thousand varchar(100),
new_tests_smoothed varchar(100),new_tests_smoothed_per_thousand varchar(100),positive_rate varchar(100),
tests_per_case varchar(100),tests_units varchar(100),total_vaccinations varchar(100),
people_vaccinated varchar(100),people_fully_vaccinated varchar(100),new_vaccinations varchar(100),
new_vaccinations_smoothed varchar(100),total_vaccinations_per_hundred varchar(100),
people_vaccinated_per_hundred varchar(100),people_fully_vaccinated_per_hundred varchar(100),
new_vaccinations_smoothed_per_million varchar(100),stringency_index varchar(100),population_density varchar(100),
median_age varchar(100),aged_65_older varchar(100),aged_70_older varchar(100),gdp_per_capita varchar(100),
extreme_poverty varchar(100),cardiovasc_death_rate varchar(100),diabetes_prevalence varchar(100),
female_smokers varchar(100),male_smokers varchar(100),handwashing_facilities varchar(100),
hospital_beds_per_thousand varchar(100),life_expectancy varchar(100),human_development_index varchar(100));

show tables;
describe vaccinations;
select count(*) from vaccinations;

rename table coviddeaths to deaths;


-- DATA EXPLORATION FOR DEATHS TABLE

-- Checking the columns

select * from deaths limit 5;


-- total number of records in deaths table

select count(*) as total_deaths from deaths;


-- TOTAL DEATHS RECORDS BY CONTINENT

select count(continent) as continent_records from deaths group by continent;
select distinct continent from deaths;
select continent,count(total_deaths) as total_count from deaths where continent is not null and continent <> '' group by continent ;



-- TOTAL DEATHS RECORDS BY COUNTRY

select location,count(location) as country_records from deaths   group by location;
select distinct location from deaths;
select location,count(*) as total_count from deaths where continent is not null and continent <> '' group by location;
select *from deaths;


-- Checking the death percentage for  all the locations and then for India

select location,dates,total_cases,total_deaths,round((total_deaths/total_cases)*100,3) as death_percentage from deaths;

select location,dates,total_cases,total_deaths,round((total_deaths/total_cases)*100,3) as death_percentage from deaths where location like '%India%';


-- Checking the  total cases percentage for all the locations and then for India

select location,dates,total_cases,population,round((total_cases/population)*100,3) as total_cases_percentage from deaths where continent is not null and continent <> '';
select dates,total_cases,population,round((total_cases/population)*100,3) as total_case_percentage_india from deaths  
where continent is not null and continent <> '' and location like '%India%';


-- Checking the highest infection rate and percentage by location

select location,population,max(total_cases) as highest_infection_rate,max(round((total_cases/population)*100,3)) as highest_infection_percentage 
from deaths group by location,population order by highest_infection_percentage desc;	


-- Checking the highest infection rate and percentage for india

select location,max(total_cases) as highest_infection_rate,max(round((total_cases/population)*100,3)) as highest_infection_percentage 
from deaths where continent is not null and continent <> '' and location like '%India%'group by location;

-- Checking the highest death rate and highest infection by location

select location,max(cast(total_deaths as unsigned)) as highest_death_rate from deaths where continent is not null and continent <> ''
 group by location order by highest_death_rate desc;
 
 
 -- Checking highest infection rate, highest infection percentage, highest death rate, and highest death percentage by continent
 
 select continent,max(cast(total_cases as unsigned)) as highest_infection_rate,max(round((total_cases/population)*100,3)) as highest_infection_percentage
 from deaths where continent is not null and continent <> '' group by continent order by highest_infection_percentage desc;
 
 select continent,max(cast(total_deaths as unsigned)) as highest_death_rate from deaths where continent is not null and continent <> '' 
 group by continent order by highest_death_rate desc;
 
 
 -- Checking total cases, total new cases, total deaths, total new deaths and death percentage grouping by dates
 
 select dates,sum(total_cases) as total_cases,sum(new_cases) as new_cases,sum(cast(total_deaths as unsigned)) as total_deaths,
 sum(cast(new_deaths as unsigned)) as new_deaths ,round((sum(cast(new_deaths as unsigned))/sum(new_cases))*100,3) as death_percentage
 from deaths where continent is not null and continent <> '' group by dates ;
 
 
 select location,sum(total_cases) as total_cases,sum(new_cases) as total_new_cases,sum(total_deaths) as total_deaths
from deaths where continent is not null and continent <> ''
 and location like '%India%'  group by location;
 
 -- Checking total cases, total new cases, total deaths, total new deaths and death percentage grouping by year
 
select year(STR_TO_DATE(dates, '%d-%m-%Y')) as `year`,sum(total_cases) as total_cases,sum(new_cases) as total_new_tests,
sum(cast(total_deaths as unsigned)) as total_deaths,sum(cast(new_deaths as unsigned)) as total_new_deaths
from deaths where dates is not null and str_to_date(dates, '%d-%m-%Y')  is not null group by `year` order by `year` desc;

 
 -- Checking total cases, total new cases, total deaths, total new deaths and death percentage grouping by location and month for India
 
select location,month(STR_TO_DATE(dates, '%d-%m-%Y')) as `month`,sum(total_cases) as total_cases,sum(new_cases) as total_new_tests,
sum(total_deaths) as total_deaths,sum(new_deaths) as total_new_deaths
from deaths where dates is not null and str_to_date(dates, '%d-%m-%Y')  is not null and continent is not null and continent <> ''
 and location like '%India%' group by location,`month`;
 

 -- DATA EXPLORATION FOR VACCINATIONS TABLE
 
 select * from vaccinations;
 
 select continent,location,`date`,new_tests,total_tests,positive_rate from vaccinations;
 
 select continent,location,`date`,total_vaccinations,people_vaccinated,people_fully_vaccinated from vaccinations;
 
 
 -- Checking total tests, total new tests, total positive rate by continent
 
select continent,sum(total_tests) as total_tests,sum(new_tests) as total_new_tests,sum(positive_rate) as total_positive_rate from vaccinations
where continent is not null and continent <> '' group by continent;


-- Checking total vaccinations, total new vaccinations by continent

select continent,sum(total_vaccinations) as total_vaccinations,sum(new_vaccinations) as total_new_vaccinations from vaccinations
where continent is not null and continent <> '' group by continent;


-- Checking total people vaccinated, total people fully vaccinated by continent

select continent,sum(people_vaccinated) as total_people_vaccinated,sum(people_fully_vaccinated) as total_people_fully_vaccinated from vaccinations
where continent is not null and continent <> '' group by continent;


-- Checking count of total tests, new tests, positive rate, total vaccinations, new vaccinations, people vaccinated, people fully vaccinated  on grouping by continent

select continent,count(total_tests) as total_tests_count,count(new_tests) as new_tests_count,count(positive_rate) as positive_rate_count from vaccinations
where continent is not null and continent <> '' group by continent;

select continent,count(total_vaccinations) as total_vaccinations_count,count(new_vaccinations) as new_vaccinations_count from vaccinations
where continent is not null and continent <> '' group by continent;

select continent,count(people_vaccinated) as people_vaccinated_count,count(people_fully_vaccinated) as people_fully_vaccinated_count from vaccinations
where continent is not null and continent <> '' group by continent;


-- Checking sum of total tests, new tests, positive rate, total vaccinations, new vaccinations, people vaccinated, people fully vaccinated  on grouping by location

select location,sum(total_tests) as total_tests,sum(new_tests) as total_new_tests,sum(positive_rate) as total_positive_rate
 from vaccinations where continent is not null and continent <> '' group by location;

select location,sum(total_vaccinations) as total_vaccinations,sum(new_vaccinations) as total_new_vaccinations from vaccinations
where continent is not null and continent <> '' group by location;

select location,sum(people_vaccinated) as total_people_vaccinated,sum(people_fully_vaccinated) as total_people_fully_vaccinated from vaccinations
where continent is not null and continent <> '' group by location;


-- Checking count of total tests, new tests, positive rate, total vaccinations, new vaccinations, people vaccinated, people fully vaccinated  on grouping by location

select location,count(total_tests) as total_tests_count,count(new_tests) as new_tests_count,count(positive_rate) as positive_rate_count
 from vaccinations where continent is not null and continent <> '' group by location;

select location,count(total_vaccinations) as total_vaccinations_count,count(new_vaccinations) as new_vaccinations_count from vaccinations
where continent is not null and continent <> '' group by location;

select location,count(people_vaccinated) as people_vaccinated_count,count(people_fully_vaccinated) as people_fully_vaccinated_count from vaccinations
where continent is not null and continent <> '' group by location;


-- Checking count of total tests, new tests, positive rate, total vaccinations, new vaccinations, people vaccinated, people fully vaccinated for  India

select location,count(total_tests) as total_tests_count,count(new_tests) as new_tests_count,count(positive_rate) as positive_rate_count,
count(total_vaccinations) as total_vaccinations_count,count(new_vaccinations) as new_vaccinations_count,
count(people_vaccinated) as people_vaccinated_count,count(people_fully_vaccinated) as people_fully_vaccinated_count
from vaccinations where continent is not null and continent <> ''
 and location like '%India%'  group by location;


-- Checking sum of total tests, new tests, positive rate, total vaccinations, new vaccinations, people vaccinated, people fully vaccinated for  India

select location,sum(total_tests) as total_tests,sum(new_tests) as total_new_tests,sum(positive_rate) as total_positive_rate,
sum(total_vaccinations) as total_vaccinations,sum(new_vaccinations) as total_new_vaccinations,
sum(people_vaccinated) as total_people_vaccinated,sum(people_fully_vaccinated) as total_people_fully_vaccinated
from vaccinations where continent is not null and continent <> ''
 and location like '%India%'  group by location;
 
 
 -- Checking count of total tests, new tests, positive rate, total vaccinations, new vaccinations, people vaccinated, people fully vaccinated on grouping by year

select year(STR_TO_DATE(`date`, '%d-%m-%Y')) as `year`,count(people_vaccinated) as people_vaccinated_count,count(people_fully_vaccinated) as people_fully_vaccinated_count
 from vaccinations  where `date` is not null and str_to_date(`date`, '%d-%m-%Y') is not null group by `year` order by `year` desc;
 
select year(STR_TO_DATE(`date`, '%d-%m-%Y')) as `year`,count(total_tests) as total_tests_count,count(new_tests) as new_tests_count,count(positive_rate) as positive_rate_count
from vaccinations where `date` is not null and str_to_date(`date`, '%d-%m-%Y')  is not null group by `year` order by `year` desc;


 -- Checking count of total tests, new tests, positive rate, total vaccinations, new vaccinations, people vaccinated, people fully vaccinated on grouping by month
 
select location,month(STR_TO_DATE(`date`, '%d-%m-%Y')) as `month`,count(total_tests) as total_tests_count,count(new_tests) as new_tests_count,count(positive_rate) as positive_rate_count
from vaccinations where `date` is not null and str_to_date(`date`, '%d-%m-%Y')  is not null and continent is not null and continent <> ''
and location like '%India%' group by location,`month`;

select location,month(STR_TO_DATE(`date`, '%d-%m-%Y')) as `month`,count(people_vaccinated) as people_vaccinated_count,count(people_fully_vaccinated) as people_fully_vaccinated_count
from vaccinations  where `date` is not null and str_to_date(`date`, '%d-%m-%Y') is not null and continent is not null and continent <> ''
and location like '%India%' group by location,`month`;


-- Joining the deaths and vaccinations table

select d.location,d.total_cases,v.total_vaccinations
from deaths as d 
join vaccinations as v
on d.location=v.location
where d.continent is not null and d.continent <> '';


-- Joining to get the total number of cases and vaccinations by continent

select location,SUM(total_cases) over (partition by location) as total_cases,SUM(total_vaccinations) over (partition by location) as total_vaccinations
from (
    select d.location,SUM(d.total_cases) as total_cases,SUM(v.total_vaccinations) as total_vaccinations
    from deaths as d
    join vaccinations as v on d.location = v.location
    where d.continent is not null and d.continent <> ''
    group by d.location
    )as agreegated_data;

-- Joining to get daily cases and vaccinations for each country

select d.location,d.dates,d.new_cases,v.new_vaccinations
from deaths as d
join vaccinations as v
on d.location=v.location and d.dates=v.`date` 
where d.continent is not null and d.continent <> '';

-- Joining to get the percentage of population vaccinated in each country 

select d.location,d.continent,d.population,round(sum(v.total_vaccinations) over (partition by d.location) / d.population * 100,2) as percentage_vaccinated
from deaths as d
join vaccinations as v on d.location = v.location
where d.continent is not null and d.continent <> '';


select location,sum(total_cases) as total_cases,sum(new_cases) as total_new_cases,sum(total_deaths) as total_deaths,max(cast(total_cases as unsigned)) as highest_infection_rate
from deaths where continent is not null and continent <> ''
group by location;


select location,month(STR_TO_DATE(`date`, '%d-%m-%Y')) as `month`,sum(people_vaccinated) as people_vaccinated_count,sum(people_fully_vaccinated) as people_fully_vaccinated_count
from vaccinations  where `date` is not null and str_to_date(`date`, '%d-%m-%Y') is not null and continent is not null and continent <> ''
 group by location,`month`;

select location,month(STR_TO_DATE(`date`, '%d-%m-%Y')) as `month`,count(total_tests) as total_tests_count,count(new_tests) as new_tests_count,count(positive_rate) as positive_rate_count
from vaccinations where `date` is not null and str_to_date(`date`, '%d-%m-%Y')  is not null and continent is not null and continent <> ''
 group by location,`month`;