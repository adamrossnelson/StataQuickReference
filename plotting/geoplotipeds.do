use https://github.com/adamrossnelson/StataQuickReference/raw/master/exampledata/ExampleIPEDS.dta, clear
scatter latitude longitud ///
if latitude > 25 & longitud < 0 & latitude < 50 & isYr == 2015, ///
scheme(s1rcolor) mcolor(white%60) msize(vsmall) msymbol(oh) ysize(4) xsize(6) ///
note("Produced by Adam Ross Nelson @adamrossnelson" ///
"Using Stata/SE 15, s1rcolor scheme, white markers 60% opacity")
