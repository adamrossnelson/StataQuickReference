# Stata Quick Reference

These examples are designed to run from the web. Where possible and where time has permitted these examples are both Mac and Windows compatible. But, no promises.

Send comments or suggestions via GitHub or Twitter : @adamrossnelson

## SvSpcHndlr.do

Routine that interactively gathers input from the user. Prompts the user to specify a log file location. From log file location this do file also infers the same location for saving dta files. Lastly, this do also infers a sub dir which can be used to save and store temporary, working, or meta files.

Intended use is to call this do file from another do file. This do file will establish three globals for later use: lobal dtagbl = $dtagbl AND Global loggbl = $loggbl AND Global wkdgbl = $wkdgbl.

User need not specify Desktop location. User may specify any location.

Example of do file output:
```
#############################################################################

     This do file will create (replace):
          Datafile:  C:\Users\username\Desktop\UserInputName.dta
          Logfile:   C:\Users\username\Desktop\UserInputName.log

     This do file will create (use):
          Workspace: C:\Users\Adam Ross Nelson\Desktop\testtestwksp

     Dialogue window asks, Are you sure you wish to proceed?

#############################################################################

Now changed to new working direcotry; current working directory:
C:\Users\username\Desktop\UserInputNamewksp

Global dtagbl = C:\Users\username\Desktop\UserInputName.dta
Global loggbl = C:\Users\username\Desktop\UserInputName.log
Global wkdgbl = C:\Users\username\Desktop\UserInputNamewksp
```

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
