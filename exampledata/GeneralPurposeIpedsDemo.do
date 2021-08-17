// Prepare a general use data set from NCES IPEDS Data
// Prepared by : Dr. Adam Ross Nelson JD PhD
//               August 2021
//
// See also: https://github.com/adamrossnelson/StataIPEDSAll

// Resulting data set includes data reported in the year 2016.
// From:
/*
                  Sector of institution |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
             1. Public, 4-year or above |        759       20.82       20.82
2. Private not-for-profit, 4-year or ab |      1,705       46.78       67.60
                      4. Public, 2-year |        995       27.30       94.90
      5. Private not-for-profit, 2-year |        186        5.10      100.00
----------------------------------------+-----------------------------------
                                  Total |      3,645      100.00           */

// Set the environment					 
set more off
clear all

// Directory information load
use IPEDSDirInfo02to18.dta
// Twelve month unduplicated headcount data load
merge 1:1 unitid isYr using IPEDS12MoEnrl02to18.dta
// Institutional characteristics data load
merge 1:1 unitid isYr using IPEDSInstChar02to18.dta, gen(__merge)

// Keep selection of variables
keep unitid isYr instnm addr city stabbr zip sector control ///
iclevel locale ccbasic efytotltall efytotlmall efytotlwall ///
efytotltugr efytotlmugr efytotlwugr efytotltgra efytotlmgra ///
efytotlwgra relaffil alloncam roomcap roomamt boardamt applcn ///
admssn enrlt enrlw enrlm applcnm applcnw admssnm admssnw

// Add data choice values to data lables
numlabel, add

// Check the results
tab sector
// Filter to 2016 and only to public/private 4&2 years
keep if inlist(sector, 1, 2, 4, 5)
keep if isYr == 2016

// Save resulting data
save "GeneralPurposeIpedsDemo2016.dta", replace

// Also convert / save resulting data as csv & html
python
import pandas as pd
df = pd.read_stata('GeneralPurposeIpedsDemo2016.dta')
df.to_csv('GeneralPurposeIpedsDemo2016.csv', index=False)
df.to_html('GeneralPurposeIpedsDemo2016.html', index=False)
end

