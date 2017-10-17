// Clear workspace
set more off
clear all

// Recommend running install routine for additional Stata graph schemes.
// To add these additional schemes use the following command:
// do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/plotting/GetStataSchemes.do

// Load example data
use https://github.com/adamrossnelson/StataQuickReference/raw/master/exampledata/ExampleIPEDS.dta

// Create a basic histogram plots.

local overtitle: variable label instsize
histogram instsize if instsize > 0, percent addlabel xtitle("") ///
xlabel(1 2 3 4 5, valuelabel alternate) title(`overtitle') ///
note("A feature of this plot is that a use of a local places the variable label in the main plot title. Additionally, the x axis is labled with valuelabels." ///
"The value lables are alternately spaced." " " "This plot also looks best after installing additional Stata graph schemes using:" ///
"do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/GetStataSchemes.do") ///
name(HistA, replace)

// Create a stacked bar chart.

tab instsize if instsize > 0 & instsize < ., gen(var)

foreach sname in burd burd5 burd11 {
	local overtitle: variable label instsize
	graph hbar (mean) var* ///
	if (sector == 1 | sector == 2 | sector == 4 | sector == 5) & isYr == 2015 & ///
	(instsize > 0 & instsize < .), over(sector) stack title("`overtitle' shown by institution sector") ///
	legend(title("Proportional sector share", size(medsmall)) ///
	order(1 "Under 1,000" 2 "1,000 - 4,999" 3 "5,000 - 9,999" 4 "10,000 - 19,999" 5 "20,000 and +") ///
	rows(1) position(6)) scheme(`sname') xsize(6) ysize(3) ///
	note("This figure, a stacked bar chart, illustrates the proportion of institutions in each size range at four" ///
	"of the institutional sector types. This chart illustrates that Private not-for-profit 2-year institutions" ///
	"are mostly small at under 1,000 students. Public institutions appear to include institutions evenly" ///
	"distributed among the size categories." " " /// 
	"This plot also looks best after installing additional Stata graph schemes using:" ///
	"do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/GetStataSchemes.do") ///
	name("Stack`sname'", replace)
}

// Create demonstration scatterplots

foreach sname in plottig plotplain plotplainblind s1rcolor  {
	scatter latitud longitud if longitud < -50 & latitud > 20 & longitud > -140 & latitud < 50, ///
	title("Scatterplot demonstrated using `sname' scheme") ///
	scheme(`sname') name("scatter`sname'", replace) ///
	note("This plot also looks best after installing additional Stata graph schemes using:" ///
	"do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/GetStataSchemes.do", ///
	size(vsmall))
}
