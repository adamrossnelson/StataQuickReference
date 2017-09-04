// Clear workspace
set more off
clear all

// Recommend running install routine for additional Stata graph schemes.
// To add these additional schemes use the following command:
// do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/GetStataSchemes.do

// Load example data
use https://github.com/adamrossnelson/StataQuickReference/raw/master/ExampleIPEDS.dta

// Create a basic histogram plots.

local overtitle: variable label instsize
histogram instsize if instsize > 0, percent addlabel xtitle("") ///
xlabel(1 2 3 4 5, valuelabel alternate) title(`overtitle') ///
note("A feature of this plot is that a use of a local places the variable label in the main plot title. Additionally, the x axis is labled with valuelabels." ///
"The value lables are alternately spaced." " " "This plot also looks best after installing additional Stata graph schemes using:" ///
"do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/GetStataSchemes.do") ///
name(HistA, replace)

