// ####   REVISION HISTORY   ####
//   Nov/2017:    Adam Ross Nelson  Original Version
// ####   DESCRIPTION        ####
//   Do file builds a mock data set consisting of variables.
//   Fictional data includes variables that represent age, gpa,
//   gender, and major.
//   Maintained: https://github.com/adamrossnelson/StataQuickReference
//   License: https://github.com/adamrossnelson/StataQuickReference/blob/master/LICENSE.md

set more off
clear all

set obs 40000

set seed 1000

// Create age variable
gen age = round(rnormal(233,10))
label variable age "Fictional age in months"

// Generate underlying distributions (modest positive relationship with age)
gen aa4gpa = 0
replace aa4gpa = round(rnormal(3.286,.2532),.01) + round(age/1000+rnormal(0,.095),.01) if _n < 27633 & _n > 7734
gen aa3gpa = 0
replace aa3gpa = round(rnormal(2.298,.2482),.01) + round(age/1000+rnormal(0,.095),.01) if _n < 7734 & _n > 1195
gen aa2gpa = 0
replace aa2gpa = round(rnormal(1.292,.2401),.01) + round(age/1000+rnormal(0,.095),.01) if _n < 1196 & _n > 188
gen aa1gpa = 0
replace aa1gpa = round(rnormal(.3051,.2074),.01) + round(age/1000+rnormal(0,.095),.01) if _n < 189

// Combine distributions / drop underlying
egen mockgpa = rowtotal(aa*)
drop aa*

// Sort by new distribution
sort mockgpa

// Add fictional gender
gen gender = round(rnormal(.5,.1))
label variable gender "Fictional gender. 1 Female, 2 Male"
label define gend 0 "Male" 1 "Female"
label values gender gend

// Adjust fictional GPAs by fictional gender
replace mockgpa = mockgpa - round(rnormal(.25,.2984),.01) if ///
mockgpa != 0 & mockgpa != 1 & mockgpa != 2 & mockgpa != 3 & mockgpa != 4 & gender == 0

// Add fictional majors
gen major = round(runiform(1,6))
label variable major "Fictional Major"
replace major = 4 if major == 3 & _n > 5000
label define maj 1 "History" 2 "English" 3 "Dance" 4 "Math" 5 "Chemistry" 6 "Geography"
label values major maj

// Adjust fictional GPAs by fictional major
replace mockgpa = mockgpa - runiform(.0777,.3799) ///
if major == 3 & mockgpa != 1 & mockgpa != 2 & mockgpa != 3 & mockgpa < 3.8 & mockgpa > .75
replace mockgpa = mockgpa + runiform(.0777,.1199) ///
if major == 1 & mockgpa != 1 & mockgpa != 2 & mockgpa != 3 & mockgpa < 3.8 & mockgpa > .75
replace mockgpa = mockgpa + runiform(.0111,.6666) ///
if major == 2 & mockgpa != 1 & mockgpa != 2 & mockgpa != 3 & mockgpa < 3.3 & mockgpa > .75
replace mockgpa = mockgpa + runiform(.0999,.2222) ///
if major == 5 & mockgpa != 1 & mockgpa != 2 & mockgpa != 3 & mockgpa < 3.5 & mockgpa > .75
replace mockgpa = mockgpa - runiform(.0999,.2799) ///
if major == 6 & mockgpa != 1 & mockgpa != 2 & mockgpa != 3 & mockgpa < 3.5 & mockgpa > .75

// Generate modes at each of the gpa point.s
replace mockgpa = 1 if _n < 100
replace mockgpa = 2 if _n > 99 & _n < 350
replace mockgpa = 3 if _n > 349 & _n < 1400
replace mockgpa = 4 if _n > 1399 & _n < 5600

// Remove GPA above 4.0
replace mockgpa = round(runiform(1,4)) if mockgpa > 4.0

// Sort again by new distribution
sort mockgpa

// Minor adjustments removing frequent outliers.
replace mockgpa = round(rnormal(3.5,.05),.01) if _n < 2000
replace mockgpa = round(rnormal(2.5,.05),.01) if _n > 2000 & _n < 3000
replace mockgpa = round(rnormal(1.5,.05),.01) if _n > 3000 & _n < 3750
replace mockgpa = round(rnormal(.5,.05),.01) if _n > 3750 & _n < 4250

// Sort again by new distribution
sort mockgpa

// Add modes at the .5 points
replace mockgpa = 3.5 if _n > 39700
replace mockgpa = 2.5 if _n > 39500 & _n < 39700
replace mockgpa = 1.5 if _n > 39400 & _n < 39500
replace mockgpa = .5 if _n > 39325 & _n < 39400

// Label the new variable
label variable mockgpa "Fictional Term GPA Data"

// Simplify / round mock gpa
replace mockgpa = round(mockgpa,.01)

// Visuzlize the distribution
hist mockgpa, discrete frequency

// Do a random sort
gen srtr = rnormal(10,10)
sort srtr
drop srtr


