// This do file demonstrates using margins and marginsplot to visualize trends
// using Stata. Data is fictional.

set more off
clear all

input unitid isYr fictvar
	240444 2005 630
	240444 2006 850
	240444 2007 760
	240444 2008 830
	240444 2009 980
	240444 2010 1030
	240444 2011 1240
	240444 2012 1190
	240444 2013 1580
	111111 2005 460
	111111 2006 710
	111111 2007 830
	111111 2008 930
	111111 2009 990
	111111 2010 980
	111111 2011 870
	111111 2012 790
	111111 2013 810
end

keep if unitid == 240444 | unitid == 111111

label define instname 240444 "Institution of Interest" 111111 "Comparison Institution"
label values unitid instname

reg fictvar i.unitid#i.isYr
margins, at(isYr=(2005/2013) unitid=(240444 111111))
marginsplot, plot2opts(lcolor(red) mcolor(red)) ytitle(Fictional Variable) ///
xtitle(" ") title("Using Marginsplot to Chart Trends" "- a demonstration -") ///
note("This figures demonstrates using Stata marginsplot to visualize trends." ///
"In this hypothetical example both institutions initiall trended up. After 2009" ///
"and 2010, the comparison institution began trending down, while the institution" ///
"of interest continued or resumed its upward trend." " " ///
"This plot also looks best after installing additional Stata graph schemes using:" ///
"do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/GetStataSchemes.do") ///
legend(rows(1) position(6))
