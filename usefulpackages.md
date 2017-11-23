# A list of useful Stata packages.

## conmtrx

Produces a useful confusion matrix and related statistics. More information: https://github.com/adamrossnelson/conmtrx

## SmartPut

The SmartPut package provides a command family that produces various tables through putdocx. Stata 15 introduced putdocx which provides options for saving results and output to word files. Stata 15 did not provide a quick or simple one-line command for saving one- or two-way table results to word files. `smrtbl` produces one- or two-way tables. `smrcol` produces a table of dummy varaibles and related summary statistics. 

`smrfmn` produces a table of summary statistics filtered by one or more indicator variables. More information: https://github.com/adamrossnelson/smrput.

## equation

Quicly converts regression results into an equation. Useful for troubleshooting your work. Also useful as a teaching or learning tool for users new to Stata or to statistics. For more information: http://fmwww.bc.edu/repec/bocode/e/equation. Or to install `ssc install equation`.

## Tablecol

`tablecol` has been a lifesaver. Simplifes the production of three way tabulations. Also can provide one and twoway tabulations that are easier to read. Example output:

```
. use https://github.com/adamrossnelson/StataQuickReference/raw/master/ExampleIPEDS.dta, clear

. tablecol isYr instsize hbcu if instsize > 0 & instsize < 5


------------------------------------------------------------------------------
          |   Historically Black College or University and Institution size   
          |                              category                             
          | ------------------------------- Yes ------------------------------
     isYr |     Under 1,000    1,000 - 4,999    5,000 - 9,999  10,000 - 19,999
----------+-------------------------------------------------------------------
     2014 |              25               55               15                4
     2015 |              31               52               15                3
     2016 |              31               52               16                2
------------------------------------------------------------------------------

------------------------------------------------------------------------------
          |   Historically Black College or University and Institution size   
          |                              category                             
          | ------------------------------- No -------------------------------
     isYr |     Under 1,000    1,000 - 4,999    5,000 - 9,999  10,000 - 19,999
----------+-------------------------------------------------------------------
     2014 |           4,811            1,610              489              343
     2015 |           4,644            1,544              490              333
     2016 |           4,705            1,501              501              336
------------------------------------------------------------------------------
```

## StataTools

Includes the following:

More information from: https://github.com/skhiggins/StataTools which explains:

* `exampleobs` prints (randomly selected) example observations and optionally stores the values in a local macro. This is useful to explore possible values of a variable in your data set without being biased by the ordering of the data.
* `head` prints the head observations (first observations in data set) and mimics the `head()` function in R and `head` command in Linux.
* `randomselect` randomly selects observations and marks them with a dummy variable. It differs from `sample` in that it does not drop the non-selected observations from the data set, and that either individual observations or other units, defined by a variable in the data set, can be randomly selected.
* `tail` prints the tail observations (last observations in data set) and mimics the `tail()` function in R and `tail` command in Linux.

Download and install through Stata using `ssc install <package_name>, replace`

## Classtabi

More information from: https://ideas.repec.org/c/boc/bocode/s458127.html which explains:

Command that reports summary statistics, including a 2 x 2 table for classification data. `classtabi` is helpful in cases where only summarized data are available. For example, data-mining software generally produce a 2 X 2 classification table (referred to as confusion matrix) as part of the output. Those values can then be entered into `classtabi` to produce the additional classification statistics.

Download and install through Stata using `ssc install classtabi, replace`.

See also: https://github.com/adamrossnelson/conmtrx

## Bradbook & Bradmean

More information from: https://github.com/bbradfield/brad-stata which explains:

* `bradmean` Computes multiple independent means in a single table.
* `bradbook` Creates a cleaner codebook for export.

Download and install using `net install <package>, from(https://raw.github.com/bbradfield/brad-stata/master/) replace`

Usage, once installed:
```
      bradbook [varlist] [, options]

      export(filename)    filename for PDF file to be saved
      replace             replaces file it already exists
```
## stata-tidy

Provides a new approach to `reshape`. More information from: https://github.com/matthieugomez/tidy.ado

Download and install using `net install tidy, from(https://github.com/matthieugomez/tidy.ado/raw/master/)`

# Notes about stata schemes.

Stata scheme notes eventually to be placed in seperate `md` file.

## burd

More information from: https://econpapers.repec.org/software/bocbocode/s457623.htm & https://github.com/briatte/burd which explains:

The burd Stata graph scheme is a reverse implementation of Cynthia Brewer's ColorBrewer `RdBu` diverging color scheme.
