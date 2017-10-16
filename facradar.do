// Radar plot inspired by post originally found at:
// https://www.statalist.org/forums/forum/general-stata-discussion/general/1414636-radar-plot-quesitons

set more off
clear all
   
// Alternate implementation of radar plot.
// Plot the means of a series of factor scores.
set obs 1000
set seed 123456
gen factor_a = rnormal(25,1.12)  // Fictional factor score
gen factor_b = rnormal(30,1.25)  // Fictional factor score
gen factor_c = rnormal(22,1.85)  // Fictional factor score
gen factor_e = rnormal(26,.756)  // Fictional factor score
gen factor_f = rnormal(28,1.32)  // Fictional factor score
gen factor_g = rnormal(22,3.00)  // Fictional factor score
gen factor_h = rnormal(31,.899)  // Fictional factor score
sum factor*, sep(0)              // Display factor score means
    
* facradar factor*               // Imaginary/hypothetical/proposed syntax
// Gxample goal: https://raw.githubusercontent.com/adamrossnelson/HelloWorld/master/SocRadar.PNG
// Bonus points if confidence intervals could also be included in the plot

// Calculate and store mean factor scores.	
foreach varname in factor_a factor_b factor_c factor_e ///
factor_f factor_g factor_h {
	sum `varname'
	// Placeholder to generate ci parameters.
	global mean`varname' = r(mean)
}

// Prepare new dataset.
drop *
set obs 20
gen caty = ""
gen conx = ""
local counti = 1

// Poluate new dataset.
foreach varname in meanfactor_a meanfactor_b meanfactor_c ///
meanfactor_e meanfactor_f meanfactor_g meanfactor_h {
	replace caty = "`varname'" in `counti'
	replace conx = "$`varname'" in `counti'
	local counti = `counti' + 1
}

// Clean new dataset.
destring conx, replace
drop if conx == .

// Use meta variables min and max to manipulate radar results.
sum conx
gen min = round(r(min) * .05)
gen max = round(r(max) * 1.2)

// Call radar package provided discussed at:
// http://fmwww.bc.edu/repec/bocode/r/radar.html
radar caty conx min max, lc(red white white)
