SELECT *
FROM coviddealth$
order by 3,4

--SELECT *
--FROM ['Covid Vaccination$']
--ORDER BY 3,4


-- select Data that we are going to be using

SELECT location,date,total_cases,new_cases,total_deaths,population
FROM coviddealth$
WHERE continent IS NOT NULL
ORDER BY 1,2

ALTER TABLE coviddealth$
ALTER COLUMN total_deaths FLOAT;

-- Loooking at Total Cases vs Total Dealths
-- shows likelihood of dying if you contract covid in your country

SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DealthPercentage
FROM coviddealth$ 
WHERE location like '%Australia%'
ORDER BY 1,2;

--Looking at Total cases Vs population
-- shows what percentage of population got Covid

SELECT location,date,total_cases,population,(total_cases/population)*100 as InfectionPercentage
FROM coviddealth$ 
WHERE location like '%Australia%'
ORDER BY 1,2


-- Looking at countries with Highest Infection Rate Compared to Population
SELECT location,population,MAX(total_cases) as HighestInfectionCount, MaX((total_cases/population))*100 as InfectionPercentage
FROM coviddealth$ 
WHERE continent IS NOT NULL
GROUP BY location,population
ORDER BY InfectionPercentage DESC

-- LET'S BREAK THONGS DOWN BY CONTITENT
SELECT continent,MAX(total_deaths) as HighestDeathsCount
FROM coviddealth$
WHERE continent is not null
GROUP BY continent
ORDER BY HighestDeathsCount DESC


-- showing with highest dealth count per population
SELECT location,MAX(total_deaths) as HighestDeathsCount
FROM coviddealth$
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY HighestDeathsCount DESC


-- Showing contintents with highesh dealth count per population
SELECT continent,population,MAX(total_deaths) as HighestDeathsCount
FROM coviddealth$
WHERE continent is not null
GROUP BY continent,population
ORDER BY HighestDeathsCount DESC

-- Global Number
SELECT SUM(new_cases) as total_cases, SUM(new_deaths)as total_deaths 
,SUM(new_deaths)/SUM(new_cases)*100 as DealthPercentage
FROM coviddealth$ 
WHERE continent is not null
--GROUP BY date
ORDER BY 1,2