# Example Data Files

This folder contains fictional data for demonstration or testing uses.

## mock fictional gpa series

`mock_fictional_gpa.do`, `mock_fictional_gpa.dta`, and `mock_fictional_gpa.csv` respectively contain a Stata do file that builds the related dta and csv data files. The following variables are available:

````
Contains data
  obs:        40,000                          
 vars:            10                          
 size:     1,600,000                          
--------------------------------------------------------------------------------------------------
              storage   display    value
variable name   type    format     label      variable label
--------------------------------------------------------------------------------------------------
mockgpa         float   %9.0g                 Ficational mock gpa
cumgpa          float   %9.0g                 Fictional cum gpa ((fall + sp) / 2)
fallgpa         float   %9.0g                 Fictional fall gpa
spgpa           float   %9.0g                 Fictional spring gpa
age             float   %9.0g                 Fictional age in months
classyr         float   %9.0g      clyr       Fictional year in school
gender          float   %9.0g      gend       Fictional gender. 1 Female, 2 Male
major           float   %9.0g      maj        Fictional Major
hall            float   %14.0g     halls      Fictional residence Hall Name
isFA            float   %9.0g                 Fictional Fin Aid Status 1=Applicant 0=Non-applicant
--------------------------------------------------------------------------------------------------
````
To open in mock fictional gpa series in Stata copy and past the following to the command line or do file.

````Stata
use https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/exampledata/mock_fictional_gpa.dta, clear
````
To run the do file from Stata command line.
````Stata
do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/exampledata/mock_fictional_gpa.do
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
