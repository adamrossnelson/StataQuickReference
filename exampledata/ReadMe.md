# Example Data Files

This folder contains fictional data for demonstration or testing uses.

## mock fictional gpa series

`mock_fictional_gpa.do`, `mock_fictional_gpa.dta`, and `mock_fictional_gpa.csv` respectively contain a Stata do file that builds the related dta and csv data files. The following variables are available:

````
Contains data from C:\GITS\StataQuickReference\exampledata\mock_fictional_gpa.dta
  obs:        40,000                          
 vars:             4                          7 Nov 2017 12:30
 size:       640,000                          
--------------------------------------------------------------------------------------
              storage   display    value
variable name   type    format     label      variable label
--------------------------------------------------------------------------------------
age             float   %9.0g                 Fictional age in months
mockgpa         float   %9.0g                 Fictional Term GPA Data
gender          float   %9.0g      gend       Fictional gender. 1 Female, 2 Male
major           float   %9.0g      maj        Fictional Major
--------------------------------------------------------------------------------------
````


## FictionalGPAData series

`FictionalGPAData.dta` and `FictionalGPAData.csv` contain fictional gpa data. The following variables are available:

````
Contains data from C:\GITS\StataQuickReference\exampledata\FictionalGPAData.dta
  obs:         1,268                          
 vars:             9                          12 Sep 2017 11:11
 size:        45,648                          
---------------------------------------------------------------------------------
              storage   display    value
variable name   type    format     label      variable label
---------------------------------------------------------------------------------
isMale          float   %9.0g                 
isStem          float   %9.0g                 
hallNum         float   %9.0g                 
fallgpa         float   %9.0g                 
fallcr          float   %9.0g                 
sprigpa         float   %9.0g                 
spricr          float   %9.0g                 
cumgpa          float   %9.0g                 
SAP             float   %9.0g                 
---------------------------------------------------------------------------------
````

## ExampleIPEDS.dta

`ExampleIPEDS.dta` contains three years of data from IPEDS. For more information see also [StataIPEDSAll](https://github.com/adamrossnelson/StataIPEDSAll).