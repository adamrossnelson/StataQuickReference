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
sort age

// Create class year variable
gen classyr = 1
replace classyr = round(rnormal(.9,.1)) if _n < 10000
replace classyr = round(rnormal(1.9,.2)) if _n > 9000 & _n < 18000
replace classyr = round(rnormal(2.9,.3)) if _n > 17800 & _n < 29200
replace classyr = round(rnormal(4.6,.4)) if _n > 29000
label define clyr 1 "YR 1" 2 "SY 2" 3 "TY 3" 4 "FY 4" 5 "FY 5" 6 "FY 6"
label values classyr clyr
label variable classyr "Fictional year in school"

// Adjust age to better relate with classyr
replace age = age + round(rnormal(12,6)) if classyr == 5
replace age = age + round(rnormal(12,6)) * 2 if classyr == 6

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

// Remove GPA above 4.0
replace mockgpa = round(runiform(1,4)) if mockgpa > 4.0

// Sort again by new distribution
sort mockgpa

// Sort again by new distribution
sort mockgpa

// Add modes at the .5 points
replace mockgpa = 3.5 if _n > 39700
replace mockgpa = 2.5 if _n > 39500 & _n < 39700
replace mockgpa = 1.5 if _n > 39400 & _n < 39500
replace mockgpa = .5 if _n > 39325 & _n < 39400

// Simplify / round mock gpa
replace mockgpa = round(mockgpa,.01)

// Add underlying distriptions at 1, 2, 3, and 4
gen srtr = rnormal(100,10)
sort srtr
drop srtr
replace mockgpa = round(rnormal(4,.025),.01) if _n < 10000
gen srtr = rnormal(100,10)
sort srtr
drop srtr
replace mockgpa = round(rnormal(3,.075),.01) if _n < 10000
gen srtr = rnormal(10,10)
sort srtr
drop srtr
replace mockgpa = round(rnormal(2,.075),.01) if _n < 8000
gen srtr = rnormal(10,100)
sort srtr
drop srtr
replace mockgpa = round(rnormal(1,.075),.01) if _n < 6000

// Add fictional residence hall information
gen hall = round(runiform(1,10))
replace hall = . if _n < 25000
replace hall = 7 if hall == 4 & _n > 30000
replace hall = 5 if (hall == 8 | hall == 9) & _n > 35000
recode hall (5 = 10) (10 = 5)

label variable hall "Fictional residence Hall Name"
label define halls 0 "Off-Campus" 1 "North Hall" 2 "South Hall" ///
3 "Govs Hall" 4 "Center Hall" 5 "Memorial Hall" 6 "Senate Hall" ///
7 "Alumni Hall" 8 "State Hall" 9 "Lakeshore Hall" 10 "Honors Hall"
label values hall halls

// Add fictional FinAid status
gen isFA = round(rnormal(.625,.01) + (mockgpa * rnormal(-.0363,.001)))
replace isFA = round(rnormal(.625,.01) + (mockgpa * rnormal(-.0363,.001))) + hall / 1000 if _n > 20000
replace isFA = round(rnormal(.5,.01)) if _n > 12000
label variable isFA "Fictional Financial Aid Status 1 = Applicant 0 = Non-applicant"

// Add fall spring cum gpa
gen fallgpa = round(rnormal(1.06,.2) + (mockgpa * runiform(.6855,.7016)),.01)
// replace fallgpa = 4 if fallgpa > 4
gen spgpa = round((fallgpa) + rnormal(0,.25),.01)
// replace spgpa = 4 if spgpa > 4

foreach varname in fallgpa spgpa mockgpa {
    // hist mockgpa, discrete frequency name(gph`varname'1)

    // Generate modes at each of the gpa point.
    sort `varname'
    replace `varname' = 1 if _n < 100
    replace `varname' = 2 if _n > 99 & _n < 400
    replace `varname' = 3 if _n > 399 & _n < 1600
    replace `varname' = 4 if _n > 1599 & _n < 5800
	replace `varname' = 2 if _n > 5799 & _n < 6000

    // Sort again by new distribution
    sort `varname'

    // Minor adjustments removing frequent outliers.
    replace `varname' = round(rnormal(3.5,.05),.01) if _n < 2000
    replace `varname' = round(rnormal(2.5,.05),.01) if _n > 2000 & _n < 3000
    replace `varname' = round(rnormal(1.5,.05),.01) if _n > 3000 & _n < 3750
    replace `varname' = round(rnormal(.5,.05),.01) if _n > 3750 & _n < 4250

    // Sort again by new distribution
    sort `varname'

    // Add modes at the .5 points
    replace `varname' = 3.5 if _n > 39700
    replace `varname' = 2.5 if _n > 39500 & _n < 39700
    replace `varname' = 1.5 if _n > 39400 & _n < 39500
    replace `varname' = .5 if _n > 39325 & _n < 39400

	replace `varname' = round(runiform(1,4),.01) if `varname' > 4 | `varname' < 0
	
    // Visuzlize the distribution
    hist `varname', discrete frequency name(gph`varname'2)
}

// Add a cumulative gpa (crudly calculated)
gen cumgpa = (fallgpa + spgpa) / 2

// Order variables
order mockgpa, first
order cumgpa fallgpa spgpa, after(mockgpa)

// Label gpa variables 
label variable mockgpa "Ficational mock gpa"
label variable cumgpa "Fictional cum gpa ((fall + sp) / 2)"
label variable fallgpa "Fictional fall gpa"
label variable spgpa "Fictional spring gpa"

// Final manipulation of halls
replace hall = . if _n < 15000

corr cumgpa fallgpa spgpa mockgpa

// Do a random sort
gen srtr = rnormal(10,10)
sort srtr
drop srtr

