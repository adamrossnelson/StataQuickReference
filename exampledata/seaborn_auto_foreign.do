// Update Seaborn's mpg dataset to more closely match
// Stata's auto dataset.
// Prepared by Dr. Adam Ross Nelson JD PhD

// Set and clear the workspace
set more off
clear all
cls

// Set the random seed
set seed 1000

sysuse auto
desc

import delimited ///
"https://raw.githubusercontent.com/mwaskom/seaborn-data/master/mpg.csv", clear

// Create a foreign variable
gen foreign = origin != "usa"
label define isForeign 0 "Domestic" 1 "Foreign"
label values foreign isForeign

// Model price as a function of year, origin, weight, and random
gen price = 1000 + (model_year - 70) * rnormal(120, 2) + ///
                   foreign * rnormal(230, 2) + ///
				   (weight - 1613) * rnormal(1, .5) + ///
				   rnormal(50, 50)

// Order variables to more closely match Stata's auto.dta
order name price mpg weight displacement foreign origin

// Check to make sure results 'look' random
scatter weight price, name(weight_price)
scatter mpg price, name(mpg_price)
scatter model_year price, name(year_price)

// Save resulting Stata data file (with foreign indicator)
save seaborn_auto_foreign.dta

// Save resulting Stata data file (without foreign indicator)
drop foreign
save seaborn_auto.dta


