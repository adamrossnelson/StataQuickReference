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
To open in mock fictional gpa series in Stata copy and past the following to the command line or do file.

````Stata
use https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/exampledata/mock_fictional_gpa.dta, clear
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

## ExampleIPEDS.dta & ExampleIPEDSsmall.dta

`ExampleIPEDS.dta` contains three years of data from IPEDS. For more information see also [StataIPEDSAll](https://github.com/adamrossnelson/StataIPEDSAll). 

To open in Stata copy and past the following to the command line or do file.

````Stata
use https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/exampledata/ExampleIPEDS.dta, clear

use https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/exampledata/ExampleIPEDSsmall.dta, clear
````

Data dictional for the small file:

````

Contains data from C:\GITS\StataQuickReference\exampledata\ExampleIPEDSsmall.dta
  obs:            91                          dct_hd2016
 vars:            19                          7 Nov 2017 21:49
 size:        28,756                          (_dta has notes)
------------------------------------------------------------------------------------------------
              storage   display    value
variable name   type    format     label      variable label
------------------------------------------------------------------------------------------------
unitid          long    %12.0g                Unique identification number of the institution
isYr            int     %8.0g                 
instnm          str105  %105s                 Institution (entity) name
addr            str81   %81s                  Street address or post office box
city            str28   %28s                  City location of institution
stabbr          str2    %9s                   State abbreviation
zip             str10   %10s                  ZIP code
chfnm           str50   %50s                  Name of chief administrator
gentele         str15   %15s                  General information telephone number
sector          byte    %40.0g     label_sector
                                              Sector of institution
control         byte    %22.0g     label_control
                                              Control of institution
hbcu            byte    %8.0g      label_hbcu
                                              Historically Black College or University
locale          byte    %15.0g     label_locale
                                              Degree of urbanization (Urban-centric locale)
c15szset        byte    %79.0g     label_c15szset
                                              Carnegie Classification 2015: Size and Setting
landgrnt        byte    %28.0g     label_landgrnt
                                              Land Grant Institution
instsize        byte    %16.0g     label_instsize
                                              Institution size category
efytotltall     long    %12.0g                ALL Grand total
efytotltugr     long    %12.0g                UGR Grand total
efytotltgra     long    %12.0g                GRA Grand total
------------------------------------------------------------------------------------------------
````