# Military Expense & Population Analysis -  SQL & Tableau
**Date Last Updated: 4/2/2022** <br> <br>
This project is still ongoing as of today. <br>
Currently working on: Right now the database is in the 1st normal form, I am going to continue with the normalization process which may results in code changes. I anticipate that I will be requiring more JOIN clauses. 

## Project Overview & Motivation
In this project, I am interested in exploring [the National Material Capabilities data set](https://correlatesofwar.org/data-sets/national-material-capabilities) containing annual values for total population, urban population, iron and steel production, energy consumption, military personnel, and military expenditure of all state members, currently from 1816-2016. The widely-used Composite Index of National Capability (CINC) index is based on these six variables and is included in the data set. The goal of this project is to explore and gain insights as to how military expense and energy consumption has changed over time, how much of the total population serves as military personnel on average, etc.

After I’ve gained some insights, I will then translate these insights into visualizations with Tableau; instead of creating a static report, I wanted to make an interactive one so users can have fun analyzing it. Furthermore, if users are only interested in certain years or countries, they will be able to filter out the unneeded values.

I also look at this as an opportunity to improve my SQL and Tableau skills. Before I started with the queries in SQL, I first cleaned up the data in Google Sheets where I made sure that all the data was consistent for analysis and removed unneeded columns. Please note that there there is only 1 table throughout this entire analysis process.

## Files
`data` folder : This folder consists of all the datasets that were used in my analysis and visualizations. `NMC-60-abridged - NMC-60-abridged.csv` is the original dataset that I began with while `usa_milex.csv` is the result of query 4. Both datasets were used in Tableau to visualize my insights.

`NMC_Documentation_v6_0_final_v2.pdf`: A pdf documentation where you can read about the variables used in my analysis and what they stand for. Please flip to page 10 for all variables used.

`military_expense_analysis.sql`: An SQL file that contains all my queries that I’ve written to gather insights before visualizing them.


## Tableau Public Link
Please click [here to access this project’s visuals on Public Tableau](https://public.tableau.com/app/profile/daniel.chang3070/viz/MilitaryExpensePopulationVisualizations/CountrysPrimaryEnergyConsumptionPerPerson_1).

## Licensing, Authors, Acknowledgements
I would like to thank [The Correlates of War](https://correlatesofwar.org/data-sets/national-material-capabilities) for making this dataset accessible for download.  
