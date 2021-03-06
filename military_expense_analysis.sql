/* Query #1 */
/* What are the top countries that have spent the most of their military since 1914?
How much less did the next country spend?*/
WITH country_totalex AS (SELECT stateabb country, SUM(milex) total_expense
							FROM military_expense
						 	WHERE year >= 1914
							GROUP BY country
							ORDER BY total_expense DESC)

SELECT country,total_expense,
COALESCE(total_expense - LAG(total_expense) OVER (ORDER BY total_expense DESC), 0) AS difference
	FROM country_totalex
	LIMIT 100;

/* Query #2 */
/* On average, what percentage of the total population in each country are military personnel?*/
WITH top_country_exp AS(SELECT DISTINCT(stateabb) country, SUM(milex) total_expense
							FROM military_expense
							GROUP BY country
							ORDER BY total_expense DESC
					   		LIMIT 50)

SELECT expense.stateabb AS country, ROUND(AVG(milper)) AS avg_milper, ROUND(AVG(tpop)) AS avg_tpop,
((ROUND(AVG(milper))/(ROUND(AVG(tpop))) * 100)) AS milper_pop_per
	FROM military_expense expense
	JOIN population
	ON expense.stateabb = population.stateabb
		AND expense.year = population.year
	WHERE expense.year >= 1975 AND expense.stateabb IN (SELECT country
									   FROM top_country_exp)
	GROUP BY country
	ORDER BY milper_pop_per DESC;

/* Query #3 */
/* For the top 50 iron and steel production in history, what country and year acheived this?*/
WITH country_maxirst AS(SELECT DISTINCT(expense.stateabb) country, MAX(irst) max_irst
							FROM military_expense expense
							JOIN production_consumption prod_con
							ON expense.stateabb = prod_con.stateabb
								AND expense.year = prod_con.year
							GROUP BY country
							ORDER BY 2 DESC)

SELECT expense.stateabb country, expense.year, irst
	FROM military_expense expense
	JOIN production_consumption prod_con
	ON expense.stateabb = prod_con.stateabb
	AND expense.year = prod_con.year
	WHERE irst IN (SELECT max_irst
					FROM country_maxirst)
	ORDER BY irst DESC
	LIMIT 50;

/* Query #4 */
/* For the United states, has the military expense change year over year since 1914? In percentage?*/
SELECT stateabb, year, milex,
COALESCE(milex - LEAD(milex) OVER (ORDER BY year DESC), 0) diff,
(COALESCE(milex - LEAD(milex) OVER (ORDER BY year DESC), 0)/LEAD(milex) OVER (ORDER BY year DESC))*100 percent_change
	FROM military_expense
	WHERE stateabb = 'USA' AND year >= 1914
	ORDER BY year;

/* Query #5 */
/* Since the end of WW2, what is the average increase or decrease in total population,
and urban population per year?*/
WITH usa_pec_pop AS (SELECT stateabb country, year, tpop, upop,
					tpop - LEAD(tpop) OVER (ORDER BY year DESC) tpop_diff,
					upop - LEAD(upop) OVER (ORDER BY year DESC) upop_diff
						FROM population
						WHERE stateabb = 'USA' AND year >= 1945
						ORDER BY year)

SELECT ROUND(AVG(tpop_diff)) avg_tpop_diff, ROUND(AVG(upop_diff)) avg_upop_diff
	FROM usa_pec_pop;

/* Query #6 */
/* What is each country's average iron and steel production to primary energy consumption ratio since 1914? */
WITH pec_irst_ratio AS (SELECT stateabb country, AVG(irst) avg_irst, AVG(pec) avg_pec,
						CASE WHEN AVG(irst) = 0 THEN NULL
						ELSE AVG(irst)/AVG(pec) END AS ratio
							FROM production_consumption
							WHERE year >= 1914
							GROUP BY country
							ORDER BY ratio)
SELECT statenme country, ratio
	FROM pec_irst_ratio ratio_table
	JOIN country_code
	ON ratio_table.country = country_code.stateabb
	WHERE ratio > 0
	ORDER BY ratio DESC;

/* Query #7 */
/* In percentages, how has the urban population grown or shrunk over time compared to each country's total population?
How has the primary energy consumption (pec) changed over time?*/
SELECT prod_con.stateabb,prod_con.year,pec, upop, tpop,
ROUND((upop/tpop)*100, 2) upop_per, ROUND((pec/tpop), 2) pec_per_person
	FROM population
	JOIN production_consumption prod_con
	ON population.stateabb = prod_con.stateabb
		AND population.year = prod_con.year
