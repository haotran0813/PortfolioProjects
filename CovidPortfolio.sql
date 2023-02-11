SELECT *
FROM PortfolioProject..CovidDeaths
order by 3,4

SELECT *
FROM PortfolioProject..CovidVaccimations
order by 3,4

--Select Data that we are going to be using

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
order by 1,2


--Looking at Total Cases vs Total Deaths
--Shows likelihood of dying if you contract covid in your country

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Percentage
FROM PortfolioProject..CovidDeaths
Where location like '%states%'
order by 1,2



--Looking at the Total Cases vs Population
--Show % of population got covid

SELECT location, date, population,total_cases, (total_cases/population)*100 as Percentage_of_PopulationInfected
FROM PortfolioProject..CovidDeaths
Where location like '%states%'
order by 1,2



--Looking at countries with Highest Infection Rate coompared to Population

SELECT location,population,MAX(total_cases) as HighestInfection, max((total_cases/population))*100 as Percentage_of_PopulationInfected
FROM PortfolioProject..CovidDeaths
--Where location like '%states%'
Group by location, population
order by Percentage_of_PopulationInfected DESC



--Showing Countries with Highest Death Count per Population

SELECT location, max(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is NOT NULL
Group by location
order by TotalDeathCount desc


--BREAK THINGS DOWN BY CONTINENT

SELECT continent, max(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is NOT NULL
Group by continent
order by TotalDeathCount desc


--Global Number

SELECT date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as Deathpercentage
FROm PortfolioProject..CovidDeaths
Where continent is not null
Group by date
order by 1,2


--Looking at Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
 SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeoplevaccinated
From PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccimations vac
	ON dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
order by 2,3

--USE CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as 
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
 SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeoplevaccinated
  
From PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccimations vac
	ON dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--order by 2,3
)
Select * , (RollingPeopleVaccinated/Population)*100
From PopvsVac




--Temp Table

DROP table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert Into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
 SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeoplevaccinated
  --(RollingPeoplevacinated/Population)*100
From PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccimations vac
	ON dea.location = vac.location
	and dea.date = vac.date
--Where dea.continent is not null
--order by 2,3

Select * , (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated




--Creating View to store data or Visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
 SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeoplevaccinated
  --(RollingPeoplevacinated/Population)*100
From PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccimations vac
	ON dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--order by 2,3