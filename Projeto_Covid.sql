/* 
2.Faça uma tabela com uma coluna de total de casos 
e outra com total de mortes por país
3.Mostre a probabilidade de morrer se contrair covid em cada país 
4.Faça uma tabela com uma coluna de total de casos  e outra com total população por país
5.Mostre a probabilidade de se infectar com Covid por país
6.Quais são os países com maior taxa de infecção?
7.Quais são os países com maior taxa de morte?
8.Mostre os continentes com a maior taxa de morte
9.População Total vs Vacinações: mostre a porcentagem da população que recebeu pelo menos uma vacina contra a Covid
*/

/*2.Faça uma tabela com uma coluna de total de casos 
e outra com total de mortes por país*/

SELECT 	
	sum(new_cases) as total_cases,
	sum(new_deaths) as total_deaths
from CovidDeaths cd 
where iso_code not like 'OWID%'


/*
 3.Mostre a probabilidade de morrer 
  se contrair covid em cada país
 */

SELECT 
	location,
	round(sum(new_deaths) / sum(new_cases) * 100, 2) as "Probabilidade morte"
from CovidDeaths cd 
where iso_code not like 'OWID%'
group by location
order by 2 DESC

/*
  4.Faça uma tabela com uma coluna de total de casos
  e outra com total população por país
 */

SELECT 
	location,
	sum(new_cases) as total_cases,
	max(population) as population
	from CovidDeaths cd 
where iso_code not like 'OWID%'
group by location

/*
 * 5.Mostre a probabilidade de se infectar
 *  com Covid por país
 */
SELECT 
	location,
	sum(new_cases) as total_cases,
	max(population) as population,
	round(1000* sum(new_cases) / max(population), 2) as "para cada 1000 pessoas x tem covid",
	round(1000* sum(new_deaths) / sum(new_cases), 2) as "para cada 1000 pessoas infectadas x morrem",
	round(sum(new_deaths) / sum(new_cases) * 100, 2) as "% Probabilidade de morte"
	from CovidDeaths cd 
where iso_code not like 'OWID%'
group by location




SELECT 	* from CovidDeaths cd 


SELECT 	* from CovidVaccinations cv
where location = 'Brazil'


/*
 * População Total vs Vacinações: mostre a 
 * porcentagem da população que recebeu pelo 
 * menos uma vacina contra a Covid
a. Importante mostrar acumulado de 
vacina por data e localização
 */

SELECT 
	cv.location,
	cv.date, 
	cd.population,
	cv.people_vaccinated,
	cv.total_vaccinations 
from CovidVaccinations cv 
LEFT JOIN CovidDeaths cd ON
	cv.iso_code = cd.iso_code
where cv.iso_code not like 'OWID%'
and cd.iso_code not like 'OWID%'

-- **********************
with base_oficial as (
SELECT 
	cv.location,
	cv.date, 
	cast(cv.people_vaccinated as REAL) as people_vaccinated,
	cd.population,
	cast(cv.total_vaccinations as REAL) as total_vaccinations
from CovidVaccinations cv 
LEFT JOIN CovidDeaths cd ON
	cv.iso_code = cd.iso_code
where cv.iso_code not like 'OWID%'
and cd.iso_code not like 'OWID%'
and cv.location = 'Brazil'
)
SELECT 
	location,
	date,
	total_vaccinations,
	people_vaccinated,
	max(people_vaccinated) / max(population) as tx_vacinacao	
from base_oficial
group by 1,2,3,4



YYYY-MM-DD


)/ max(cd.population) as "% que recebeu pelo menos 1 vacina",