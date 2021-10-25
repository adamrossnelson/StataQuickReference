// Prepare Modified DatasaRus Data Files For Demo of Correlation & Limitations
// By: Dr. Adam Ross Nelson
// Summer 2021

set more off
clear all

// Use Python do download and convert R data to Stata data file.
python:

# Standard Python imports
import pandas as pd
import pyreadr
import requests

# Specify data locations
location = 'https://raw.githubusercontent.com/lockedata/datasauRus/master/data/'
filename = 'datasaurus_dozen_wide.rda'

# Download the data (requests), write to local disk
rdata = requests.get(location + filename)
rfile = open(filename, 'wb')
rfile.write(rdata.content)
rfile.close()

# Read R data file from disk, write as Stata data file
tdata = pyreadr.read_r(filename)
pd.DataFrame(tdata['datasaurus_dozen_wide']).to_stata(filename + '.dta')

end

// Load converted data
use datasaurus_dozen_wide.rda.dta, clear
// Keep variables of interest
keep dino* slant_up*

// Rename vars to fit hypothetical test score (stdy hours) scenario
rename slant_up_y score
rename slant_up_x hours

// Rename vars to hide away the punch line
rename dino_y hypo_y
rename dino_x hypo_x

// Rotate the slant to be flat
gen hrs2 = hours - score

// Check results of the rotation
scatter hrs2 score, name("Check0")

// Generate groups based on rotated vraibles
gen group = "Unk"
sort hours
replace group = "5yr" if hrs2 > 45
replace group = "4yr" if hrs2 < 45 & hrs2 > 10
replace group = "3yr" if hrs2 < 10 & hrs2 > -10
replace group = "2yr" if hrs2 < -10 & hrs2 > -45
replace group = "1yr" if hrs < -45

// Check work
twoway ///
(scatter score hours if group == "5yr") ///
(scatter score hours if group == "4yr") ///
(scatter score hours if group == "3yr") ///
(scatter score hours if group == "2yr") ///
(scatter score hours if group == "1yr") ///
(scatter score hours), legend(off) name("Check1")

// Check work
twoway ///
(scatter score hrs2 if group == "5yr") ///
(scatter score hrs2 if group == "4yr") ///
(scatter score hrs2 if group == "3yr") ///
(scatter score hrs2 if group == "2yr") ///
(scatter score hrs2 if group == "1yr"), legend(off) name("Check2")

// Data management, make string categorial, add value labels
encode group, gen(gcat)
numlabel, add

// Check work (Regression)
reg score hours
reg score hours i.gcat

// Check work (Corrlation)
pwcorr hours score, sig star(5) obs
pwcorr hypo*, sig star(5) obs

// Keep vars of interest for educational demonstrations
keep hypo* hours score gcat

// Add variable labels
label variable hours "Hours spent studying for an exam."
label variable score "The score earned on an exam."
label variable gcat "Grade in school."
label variable hypo_y "Hypothetical y variable."
label variable hypo_x "Hypothetical x variable."

// Save data
save "Lab 9.1 Correlation Analysis Limitations Supp.dta"
save "DatasaRusCorrelationModified.dta"
