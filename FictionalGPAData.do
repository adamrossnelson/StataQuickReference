// This do builds a dataset with fictional GPA data.
// Author: Adam Ross Nelson
// Created: Fall 2017

set more off
clear all

set obs 12680

set seed 123456789

// Creates random gender, STEP major, and hall assignments.
gen isMale = round(runiform(0,1))
gen isStem = round(runiform(0,1))
gen hallNum = round(runiform(1,30))

// Generates random fall GPA that is partly also a function of hall assignment and gender.
gen fallgpa = round(rnormal(4.5,1) - ((hallNum / 250) + 1) - ((isMale / 11)-(isMale / 14)),.01)

// Adjust fall gpa as a function of hall assignments.
replace fallgpa = fallgpa - 4 if (hallNum == 25 & _n > 444) | ///
(hallNum == 26 & _n > 222) | (hallNum == 27 & _n > 333) | ///
(hallNum == 28 & _n > 333) | (hallNum == 29 & _n > 222) | ///
(hallNum == 20 & _n > 222) | (hallNum == 21 & _n > 444) | ///
(hallNum == 22 & _n > 555) | (hallNum == 23 & _n > 222) | ///
(hallNum == 19 & _n > 222) | (hallNum == 18 & _n > 333)

// GPA may only be between 0.0 and 4.0.
replace fallgpa = 4.0 if fallgpa > 4.0
replace fallgpa = 0.0 if fallgpa < 0.0

// Generates random fall credit load.
gen fallcr = round(rnormal(14,3))
replace fallcr = fallcr - round(rnormal(5,1)) if fallcr > 19

// Generates random spring GPA that is partly a funciton of hall assignment and gender.
gen sprigpa = fallgpa + round(rnormal(0,1) - ((hallNum / 150) + 1) - ((isMale / 11)-(isMale / 16)),.01)
replace sprigpa = 4.0 if sprigpa > 4.0
replace sprigpa = 0.0 if sprigpa < 0.0

// If Fall GPA is less than 4.0 - spring GPA must also be less than 4.0.
replace sprigpa = (sprigpa - (sprigpa - fallgpa)) if sprigpa == 4.0 & fallgpa < 4.0
replace sprigpa = sprigpa + round(rnormal(0,.04),.01) if sprigpa == fallgpa

// GPA may only be between 0.0 and 4.0.
replace sprigpa = 4.0 if sprigpa > 4.0
replace sprigpa = 0.0 if sprigpa < 0.0

// Generates random fall credit load.
gen spricr = round(rnormal(14,3))
replace spricr = spricr - round(rnormal(5,1)) if spricr > 19

// Generates cumulative GPA which would be an average of fall & spring.
gen cumgpa = round((fallgpa + sprigpa) / 2,.01)

// Generates indicator variable (TRUE) if cumgpa is less than 2.0.
gen SAP = (cumgpa < 2.01)

// Reduces the number of availale hall assignments.
replace hallNum = round(hallNum / 5)
