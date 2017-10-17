// This do file provides a method to quickly add text to all variable labels.
// Originally drafted : Fall 2017
// Originally posted by : Adam Ross Nelson
// Original location : https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/renvarnames.do

// Load sample data.
sysuse auto, clear

// See variables before procedure.
desc make price mpg rep78

// Foreach syntax gets list of existing variables.
foreach varname of var * {
	// Set local = to existing variable lable.
	local curlab: variable label `varname'
	// Concatenate new text with local.
	local newlab = "ADDED PREFIX `curlab'"
	// Use local to set new variable label.
	label variable `varname' "`newlab'"
}

// See variables with "ADDED PREFIX" after procedure.
desc make price mpg rep78
