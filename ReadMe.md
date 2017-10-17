# 1. Table of Coneents

<!-- TOC -->

- [1. Table of Coneents](#1-table-of-coneents)
- [2. Stata Quick Reference](#2-stata-quick-reference)
    - [2.1. Examples replated to plotting images and figures](#21-examples-replated-to-plotting-images-and-figures)
        - [2.1.1. BasicPlotting.do](#211-basicplottingdo)
        - [2.1.2. geoplotipeds.do](#212-geoplotipedsdo)
        - [2.1.3. Facradar.do](#213-facradardo)
        - [2.2. GetStataSchemes.do](#22-getstataschemesdo)
    - [2.3. renvarlabs.do](#23-renvarlabsdo)
    - [2.4. FictionalGPAData.do](#24-fictionalgpadatado)
    - [2.5. md_demo.do](#25-mddemodo)
    - [2.6. asciiadam.do](#26-asciiadamdo)
- [3. License](#3-license)

<!-- /TOC -->

# 2. Stata Quick Reference

These examples are designed to run from the web. Where possible and where time has permitted these examples are both Mac and Windows compatible. But, no promises.

For a currated list of packages, their descriptions, and links to further documentation see: [list of useful packages](https://github.com/adamrossnelson/StataQuickReference/blob/master/usefulpackages.md)

Send comments or suggestions via GitHub or Twitter : @adamrossnelson

## 2.1. Examples replated to plotting images and figures

### 2.1.1. BasicPlotting.do

Simple graphics using IPEDS data `ExampleIPEDS.dta`

```Stata
// To run from command line:
do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/plotting/BasicPlotting.do
// To load example data:
use https://github.com/adamrossnelson/StataQuickReference/raw/master/exampledata/ExampleIPEDS.dta
```

### 2.1.2. geoplotipeds.do

Using the longitude and latitude variables stored in IPEDS data this routine builds a visualization of the institutions located in North America.

```Stata
// To run from command line:
do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/plotting/geoplotipeds.do
```

### 2.1.3. Facradar.do

Another plotting demonstration. Demonstrates genderating a radar plot. Requires the `radar` package which is available at `http://fmwww.bc.edu/repec/bocode/r/radar.html`. The example given in `radar` documentation shows the package excels at plotting a categorical y (such as automobile make) and a continuous x (automobile weight).

This implementatino plots a categorical y (such as a series of factor scores) and a continuous x (which would be each factor score's mean).

### 2.2. GetStataSchemes.do

This file is a quick routine that will install a range of graphic schemes. Stata's raphic schemes are a useful way to improve the visual presentation of data.

This routine also sets the default scheme to `lean2wide` which is a modified version of lean1 and lean2. More information about development history in the do file.

To execute from command line:

```Stata
do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/plotting/GetStataSchemes.do

// Additional related commands include ...
// Show available schemes:
graph query, schemes

// Change default scheme:
set scheme [scheme name], perm
```
## 2.3. renvarlabs.do

This do file provides a method to quickly add text to all variable labels. Also provides an example code that can reference existing variable labels which is useful when automating output for graphs or putdoc/pdf, etc.

```Stata
// To run from command line:
do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/renvarlabs.do
```

## 2.4. FictionalGPAData.do

Builds a dataset with fictional GPA data. Demonstration of stata random number generators.

```Stata
do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/FictionalGPAData.do
```

## 2.5. md_demo.do

Generates markdown from Stata using `qui` abd `noi di...` Demonstrates and tests a method for Stata to automate output for display on GitHub.

Cannot be run from command line without downloading a local copy.

## 2.6. asciiadam.do

Example of a vaity branding splash.

To execute from command line (or do file):

```Stata
do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/asciiadam.do
```

# 3. License

Except where otherwise specifically noted:

MIT License

Copyright (c) 2018 Adam Ross Nelson JD PhD

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.