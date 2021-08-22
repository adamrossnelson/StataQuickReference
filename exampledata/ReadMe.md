# Example Data Files

This folder contains fictional data for demonstration or testing uses.

There are four series of fictional and demonstration data here.

1 DatasaRus, Modified
2 Example IPEDS data
3 General Purpose IPEDS data
4 Mock Fictional GPA Data

More information on each of the four data sets below.

## DatasaRus, Modified

Ficational data from the [DatasaRus project](https://github.com/lockedata/datasauRus). This modified data adds a group variable which also explains the upward slants.

```Stata
Contains data from datasaurus_dozen_wide.rda.dta
 Observations:           142                  
    Variables:             5                  22 Aug 2021 13:13
------------------------------------------------------------------------------------------------------------
Variable      Storage   Display    Value
    name         type    format    label      Variable label
------------------------------------------------------------------------------------------------------------
hypo_x          double  %10.0g                
hypo_y          double  %10.0g                
hours           double  %10.0g                
score           double  %10.0g                
gcat            long    %8.0g      gcat       
------------------------------------------------------------------------------------------------------------
Sorted by: hours
     Note: Dataset has changed since last saved.
```

To open in Stata copy and past the following to the command line or do file.

```Stata
use https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/exampledata/DatasaRusCorrelationModified.dta, clear

// To view the grouped upward slant...
twoway ///
(scatter score hours if group == "5yr") ///
(scatter score hours if group == "4yr") ///
(scatter score hours if group == "3yr") ///
(scatter score hours if group == "2yr") ///
(scatter score hours if group == "1yr") ///
(scatter score hours), legend(off) name("Check1", replace)

```

## ExampleIPEDS.dta & ExampleIPEDSsmall.dta

`ExampleIPEDS.dta` contains three years of data from IPEDS. For more information see also [StataIPEDSAll](https://github.com/adamrossnelson/StataIPEDSAll). 

To open in Stata copy and past the following to the command line or do file.

```Stata
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

## General Purpose IPEDS data

`ExampleIPEDS.dta` contains one year of data from IPEDS (2016) 3,645 observations. For more information see also [StataIPEDSAll](https://github.com/adamrossnelson/StataIPEDSAll). 

```Stata
 Observations:         3,645                  PanelBuildInfo:
                                                https://github.com/adamrossnelson/StataIPEDSAll/tree/master
    Variables:            35                  17 Aug 2021 14:20
                                              (_dta has notes)
------------------------------------------------------------------------------------------------------------
Variable      Storage   Display    Value
    name         type    format    label      Variable label
------------------------------------------------------------------------------------------------------------
unitid          long    %12.0g                Unique identification number of the institution
isYr            int     %8.0g                 
instnm          str105  %105s                 Institution (entity) name
addr            str81   %81s                  Street address or post office box
city            str28   %28s                  City location of institution
stabbr          str2    %9s                   State abbreviation
zip             str10   %10s                  ZIP code
sector          byte    %43.0g     label_sector
                                              Sector of institution
iclevel         byte    %38.0g     label_iclevel
                                              Level of institution
control         byte    %25.0g     label_control
                                              Control of institution
locale          byte    %19.0g     label_locale
                                              Degree of urbanization (Urban-centric locale)
ccbasic         byte    %83.0g     label_ccbasic
                                              Carnegie Classification 2005/2010: Basic
efytotltall     long    %12.0g                ALL Grand total
efytotlmall     long    %12.0g                ALL Grand total men
efytotlwall     long    %12.0g                ALL Grand total women
efytotltugr     long    %12.0g                UGR Grand total
efytotlmugr     long    %12.0g                UGR Grand total men
efytotlwugr     long    %12.0g                UGR Grand total women
efytotltgra     long    %12.0g                GRA Grand total
efytotlmgra     int     %12.0g                GRA Grand total men
efytotlwgra     long    %12.0g                GRA Grand total women
relaffil        int     %45.0g     label_relaffil
                                              Religious affiliation
alloncam        byte    %18.0g     label_alloncam
                                              Full-time, first-time degree/certificate-seeking students
                                                required to live on ca
roomcap         int     %8.0g                 Total dormitory capacity
roomamt         int     %8.0g                 Typical room charge for academic year
boardamt        long    %8.0g                 Typical board charge for academic year
applcnm         long    %12.0g                Applicants men
applcnw         long    %12.0g                Applicants women
admssnm         int     %8.0g                 Admissions men
admssnw         int     %8.0g                 Admissions women
enrlm           int     %8.0g                 Enrolled men
enrlw           int     %8.0g                 Enrolled women
enrlt           int     %8.0g                 Enrolled total
applcn          long    %12.0g                Applicants total
admssn          long    %12.0g                Admissions total
------------------------------------------------------------------------------------------------------------
Sorted by: unitid  isYr
```

To open in Stata copy and past the following to the command line or do file.

````Stata
use https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/exampledata/GeneralPurposeIpedsDemo2016.dta, clear

````


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
