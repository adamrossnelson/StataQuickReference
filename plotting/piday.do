// Code that built the March 2018 Reddit r/dataisbeautiful post
// in honor of #PiDay.

// Set workspace
set more off
clear all

// Load data. This data set built by:
// https://github.com/adamrossnelson/StataIPEDSAll/blob/master/IPEDSDirInfo02to16.do
use IPEDSDirInfo02to16.dta 

// Generate scatterplot
twoway (scatter latitude longitud, mcolor(white%90) msize(vsmall)) ///
if fips < 60, note("twoway (scatter latitude longitud, mcolor(white%90) msize(vsmall)) if fips < 60, scheme(s1rcolor)") ///
scheme(s1rcolor) text(63 -125 "I am an outlier..." "In honor of pi day I present" "one of my favoriate scatter plots!" "@adamrossnelson", ///
size(medlarge) color(white) placement(e))
