/* This do file demonstrates methods that may work well
   when seeking to visualize data relationships that involve
   multiple dimensions. Where dimensions are synonymous with
   variables.
   
   The ultimate result shown in this repo as:
   multi_dimension_bubble_stata.png visualizes three
   continuouous variables and one binary (4d).            
   
   This visual will work best with the lean2wide graph scheme
   available from: GetStataSchemes.do                              */

// Standard set the environment
cls
set more off
clear all

// Lets demonstrate a 'three-dimensional' visualization
sysuse auto
// --- Standard two dimensional (we've seen this)
twoway (scatter mpg weight), name(twod)
// --- This is a 'three-dimensiona' visualization
twoway (scatter mpg weight if foreign == 1) ///
       (scatter mpg weight if foreign == 0), ///
	   legend(order(1 "Foreign" 2 "Domestic")) ///
	   name(threed) 
// --- This is a 'four-dimensional' visualization
xtile pbubble = price, nquantiles(3)
set obs 80
replace weight = 4000 in 75
replace weight = 4350 in 76
replace weight = 4700 in 77

replace weight = 4000 in 78
replace weight = 4350 in 79
replace weight = 4700 in 80

replace mpg = 35 in 75
replace mpg = 35 in 76
replace mpg = 35 in 77

replace mpg = 32.5 in 78
replace mpg = 32.5 in 79
replace mpg = 32.5 in 80

replace foreign = 0 in 75
replace foreign = 0 in 76
replace foreign = 0 in 77

replace foreign = 1 in 78
replace foreign = 1 in 79
replace foreign = 1 in 80

replace pbubble = 1 in 75
replace pbubble = 2 in 76
replace pbubble = 3 in 77

replace pbubble = 1 in 78
replace pbubble = 2 in 79
replace pbubble = 3 in 80


twoway (scatter mpg weight if foreign == 1 & pbubble == 1, msize(small) msymbol(circle_hollow)) ///
       (scatter mpg weight if foreign == 0 & pbubble == 1, mcolor(%50) msize(small) msymbol(circle)) ///
	   (scatter mpg weight if foreign == 1 & pbubble == 2, msize(large) msymbol(circle_hollow)) ///
       (scatter mpg weight if foreign == 0 & pbubble == 2, mcolor(%50) msize(large) msymbol(circle)) ///
	   (scatter mpg weight if foreign == 1 & pbubble == 3, msize(huge) msymbol(circle_hollow)) ///
       (scatter mpg weight if foreign == 0 & pbubble == 3, mcolor(%50) msize(huge) msymbol(circle)), ///
	   text(37 4000 "Low Price") ///
	   text(37 4350 "Med Price") ///
	   text(37 4700 "High Price") ///
	   text(35 3750 "Domestic") ///
	   text(32.5 3750 "Foreign") ///
	   title("Bubble charts in Stata!") ///
	   note("@adamrossnelson")
	   legend(off) name(fourd)

	   
