// Demonstrates regression models and margins plot in Stata.
// September 2018

set more off
clear all

sysuse auto

// Simple regression mpg and weight.
reg mpg weight
margins, at(weight=(0(500)4000))
marginsplot, noci ///
text(23 100 "MPG = 39.44 + weight * -.0060087 + e", place(e)) ///
ytitle(Miles Per Gallon) ///
name(graph1)

// Calculate means of groups using dummy regressor variable.
reg mpg i.foreign
margins, at(foreign=(0/1))
marginsplot, noci ///
text(23.75 .0005 "MPG = 19.82 + foreign * 4.94 + e", place(e)) ///
text(22.7 .0005 "Where 19.82 (the intercept) is domestic mpg", place(e)) ///
text(22.4 .0005 " and 19.82 + 4.94 is foreign mpg.", place(e)) ///
ytitle(Miles Per Gallon) ///
name(graph2)

// Different intercept same slope.
reg mpg weight foreign
margins, at(weight=(0(500)4000) foreign=(0/1))
marginsplot, noci ///
text(34 1800 "Inroducing different intercept, same slope.", place(e)) ///
text(22 22 "Overall MPG = 41.67 + weight * -.0065 + foreign * -1.65 + e", place(e)) ///
text(18 22 "Note that when foreign = 0 there is no change in the intercept,", place(e)) ///
text(16.5 22 "however when foreign = 1 the intercept shifts down 1.65 mpg.", place(e)) ///
name(graph3)

// Same intercept different slope
reg mpg c.weight#i.foreign
margins, at(weight=(0(500)4000) foreign=(0/1))
marginsplot, noci ///
text(34 1800 "Inroducing same intercept, different slope.", place(e)) ///
text(23 0 "Overall MPG = 41.95 + weight * domestic -.0066 + ...", place(e)) ///
text(21 30 "weight * foreign *  -.0075 + e", place(e)) ///
text(16 0 "Note that domestic and foreign are dummy variables. When", place(e)) ///
text(14.5 0 "domestic = 1 the slope is -.0066 per pound. When foreign = 1", place(e)) ///
text(13 30 "the slope decreases to -.0075 per pound.", place(e)) ///
name(graph4)

// Different slope different intercept.
reg mpg weight foreign c.weight#c.foreign
margins, at(weight=(0(500)4000) foreign=(0/1))
marginsplot, noci ///
text(34 1800 "Introducing different slop, different intercept.", place(e)) ///
text(26 15 "Overall MPG = 39.64 + weight * -.0059 + ...", place(e)) ///
text(23.6 110 "foreign * 9.27 + ...", place(e)) ///
text(21.2 110 "weight * foreign * -.0044 + e", place(e)) ///
text(17.25 15 "Note that when foreign = 0 there is no change in the intercept,", place(e)) ///
text(14.75 20 "however when foreign = 1 the intercept shifts up 9.27 mpg. This means", place(e)) ///
text(12.25 20 "39.64 is the domestic intercept. Further, when foreign = 0 there is no change", place(e)) ///
text(9.75 20 "in the slope. This means weight * -.0059 is the domestic slope. Thus", place(e)) ///
text(7.25 45 "weight * (-.0059 + -.0044) is the domestic slope.", place(e)) ///
ytitle(Miles Per Gallon)
name(graph5)


