-- looking at total cases vs. total deaths
-- shows likelihood of dying if you contract COVID-19 in your country
#location, date, total_cases, new_cases, total_deaths,(total_deaths/total_cases)*100 as death_percentage
#FROM coviddeaths
#WHERE location = "United States"
#ORDER BY 1,2

-- looking at total cases vs. population
-- shows what percentage of population got COVID-19
#SELECT location, date, total_cases, new_cases, total_deaths,(total_cases/population)*100 as percent_people_infected
#FROM coviddeaths
#WHERE location = "United States"
#ORDER BY 1,2

-- looking at country with highest infection rate compared to population
#SELECT location, population, MAX(total_cases) as highest_infection_count, MAX((total_cases/population))*100 as percent_people_infected
#FROM coviddeaths
#GROUP BY location, population
#ORDER BY percent_people_infected desc

-- showing the countries with the highest death count per population
#SELECT location, MAX(cast(total_deaths as int)) as total_death_count
#FROM coviddeaths
#WHERE continent is not null
#GROUP BY location
#ORDER BY total_death_count desc

-- showing the continents with the highest death count
#SELECT continent, MAX(cast(total_deaths as int)) as total_death_count
#FROM coviddeaths
#WHERE continent is null
#GROUP BY continent
#ORDER BY total_death_count desc

-- looking at total population vs. vaccination
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as rolling_vaccinations
FROM coviddeaths as dea
JOIN covidvaccinations as vac
  ON dea.location = vac.location
  AND dea.date = vac.date
WHERE dea.continent is not null
GROUP BY dea.continent, dea.location, dea.date, dea.population, new_vaccinations
ORDER BY 2,3