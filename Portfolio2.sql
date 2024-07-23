With PopVSVac (Contient, Location, Date, Population, New_Vaccination, RollingPeopleVaccinated) AS
(
SELECT dea.continent,
dea.location,
dea.date,
dea.population,
vac.new_vaccinations,
SUM(CONVERT(float,vac.new_vaccinations))  
OVER (Partition by dea.location  ORDER BY dea.location,dea.date) as totalvaccination
FROM 
coviddealth$ as dea
JOIN ['Covid Vaccination$'] as vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
)

-- Temp Table

SELECT dea.continent,
dea.location,
dea.date,
dea.population,
vac.new_vaccinations,
SUM(CONVERT(float,vac.new_vaccinations))  
OVER (Partition by dea.location  ORDER BY dea.location,dea.date) as totalvaccination
INTO 
#PopVsVac
FROM 
coviddealth$ as dea
JOIN ['Covid Vaccination$'] as vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null




SELECT *,(totalvaccination/population)*100 as VaccinationPercentage
FROM #PopVsVac
order by location


-- Create View to store data for later see

CREATE  VIEW PercentPopulationVaccinated AS
SELECT dea.continent,
dea.location,
dea.date,
dea.population,
vac.new_vaccinations,
SUM(CONVERT(float,vac.new_vaccinations))  
OVER (Partition by dea.location  ORDER BY dea.location,dea.date) as totalvaccination
FROM 
coviddealth$ as dea
JOIN ['Covid Vaccination$'] as vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null