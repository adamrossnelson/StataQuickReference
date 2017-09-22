# Stata Quick Reference

These examples are designed to run from the web. Where possible and where time has permitted these examples are both Mac and Windows compatible. But, no promises.

Send comments or suggestions via GitHub or Twitter : @adamrossnelson

## BasicPlotting.do

Simple graphics using IPEDS data `ExampleIPEDS.dta`

```
// To run from command line:
do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/BasicPlotting.do
// To load example data:
use https://github.com/adamrossnelson/StataQuickReference/raw/master/ExampleIPEDS.dta
```

## FictionalGPAData.do

Builds a dataset with fictional GPA data. Demonstration of stata random number generators.

```
do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/FictionalGPAData.do
```

## GetStataSchemes.do

This file is a quick routine that will install a range of graphic schemes. Graphic schemes are a useful way to improve the visual presentation of data.

This routine also sets the default scheme to `lean2wide` which is a modified version of lean1 and lean2. More information about development history in the do file.

To execute from command line:

```
do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/GetStataSchemes.do
```
