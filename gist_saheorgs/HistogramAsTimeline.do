// Nov 3 2017 - Original Build by Adam Ross Nelson
// Demonstrates histogram as a timeline using data from:
// https://docs.google.com/spreadsheets/d/1mgbPK4tpVnFJkMVemV777_4p1STw_ZeCujVrbupQHKc/edit#gid=0

set more off
clear all
import excel using ///
"https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/gist_saheorgs/FoundingofStudentAffairsOrgs.xlsx", ///
firstrow cellrange(A1:C54)

rename History OrgName
rename Year isYr
rename Website web

gen isDec = round(isYr,10)
histogram isDec, discrete frequency ytitle(Count of Organizations) ///
xtitle(" ") xlabel(1860(10)2010) title("History of Founding of Student Affairs Organizations" ///
"(displayed by decade)") caption("Data Source: John Wesley Lowery (john.lowery@iup.edu)" ///
"Stata 15 Source Code: https://github.com/adamrossnelson/StataQuickReference/tree/master/gist_saheorgs")

