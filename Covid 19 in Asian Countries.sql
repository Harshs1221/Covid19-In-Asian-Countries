
--Skills used Aggregate functions like Count, Max. Window function, Joins


-- 1 Count total population in each countries

Select date_covid,location, MAX(population) as population
from covid_deaths
group by location;

-- 2 total covid cases in each countries
select date_covid,location, max(total_cases) as covid_cases
from covid_deaths
group by location;
-- or by window function
select date_covid,location, sum(new_cases) over (partition by location order by date_covid) as total_covid_cases
from covid_deaths
group by location,date_covid;

-- 3 total deaths in each countries
select date_covid,location, max(total_deaths) as total_deaths
from covid_deaths
group by location;

-- 4 Find percentage of population infected
select location, date_covid , total_cases,
(total_cases/population)*100 as PercentagePopInfected
from covid_deaths
order by  location,date_covid;


-- 5. percentage of fully vaccinated people
select * from covid_vaccination;
select d.date_covid,d.location, max(v.total_vaccination),
max(v.people_fully_vaccinated)/max(v.total_vaccination)*100 as Fully_vaccinated_percentage
from covid_deaths d
JOIN covid_vaccination v ON d.date_covid = v.date_covid AND d.location=v.location
group by location;

-- 6. percentage of half vaccinated people
select d.date_covid,d.location, max(v.total_vaccination),
max(v.people_vaccinated)/max(v.total_vaccination)*100 as Half_vaccinated_percentage
from covid_deaths d
JOIN covid_vaccination v ON d.date_covid = v.date_covid AND d.location=v.location
group by location;
