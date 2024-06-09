-- Queries Used To Build Power BI Project

use covid;

select continent,count(total_deaths) as total_count from deaths where continent is not null and continent <> '' group by continent ;

select location,population,max(total_cases) as highest_infection_rate,max(round((total_cases/population)*100,3)) as highest_infection_percentage 
from deaths group by location,population order by highest_infection_percentage desc;	

select location,max(total_cases) as highest_infection_rate,max(round((total_cases/population)*100,3)) as highest_infection_percentage 
from deaths where continent is not null and continent <> '' and location like '%India%'group by location;

select continent,max(cast(total_cases as unsigned)) as highest_infection_rate,max(round((total_cases/population)*100,3)) as highest_infection_percentage
 from deaths where continent is not null and continent <> '' group by continent order by highest_infection_percentage desc;
 
select location,sum(total_cases) as total_cases,sum(new_cases) as total_new_cases,sum(total_deaths) as total_deaths
from deaths where continent is not null and continent <> ''
and location like '%India%'  group by location;

select year(STR_TO_DATE(dates, '%d-%m-%Y')) as `year`,sum(total_cases) as total_cases,sum(new_cases) as total_new_tests,
sum(cast(total_deaths as unsigned)) as total_deaths,sum(cast(new_deaths as unsigned)) as total_new_deaths
from deaths where dates is not null and str_to_date(dates, '%d-%m-%Y')  is not null group by `year` order by `year` desc;

select location,sum(total_tests) as total_tests,sum(new_tests) as total_new_tests,sum(positive_rate) as total_positive_rate,
sum(total_vaccinations) as total_vaccinations,sum(new_vaccinations) as total_new_vaccinations,
sum(people_vaccinated) as total_people_vaccinated,sum(people_fully_vaccinated) as total_people_fully_vaccinated
from vaccinations where continent is not null and continent <> ''
 and location like '%India%'  group by location;
 
 select location,month(STR_TO_DATE(`date`, '%d-%m-%Y')) as `month`,count(total_tests) as total_tests_count,count(new_tests) as new_tests_count,count(positive_rate) as positive_rate_count
from vaccinations where `date` is not null and str_to_date(`date`, '%d-%m-%Y')  is not null and continent is not null and continent <> ''
and location like '%India%' group by location,`month`;

select location,month(STR_TO_DATE(`date`, '%d-%m-%Y')) as `month`,count(people_vaccinated) as people_vaccinated_count,count(people_fully_vaccinated) as people_fully_vaccinated_count
from vaccinations  where `date` is not null and str_to_date(`date`, '%d-%m-%Y') is not null and continent is not null and continent <> ''
and location like '%India%' group by location,`month`;

select location,sum(total_cases) as total_cases,sum(new_cases) as total_new_cases,sum(total_deaths) as total_deaths,max(cast(total_cases as unsigned)) as highest_infection_rate
from deaths where continent is not null and continent <> ''
group by location;

select location,month(STR_TO_DATE(`date`, '%d-%m-%Y')) as `month`,sum(people_vaccinated) as people_vaccinated_count,sum(people_fully_vaccinated) as people_fully_vaccinated_count
from vaccinations  where `date` is not null and str_to_date(`date`, '%d-%m-%Y') is not null and continent is not null and continent <> ''
 group by location,`month`;

select location,month(STR_TO_DATE(`date`, '%d-%m-%Y')) as `month`,count(total_tests) as total_tests_count,count(new_tests) as new_tests_count,count(positive_rate) as positive_rate_count
from vaccinations where `date` is not null and str_to_date(`date`, '%d-%m-%Y')  is not null and continent is not null and continent <> ''
 group by location,`month`;
 