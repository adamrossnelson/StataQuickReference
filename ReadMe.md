# 1. Table of Coneents

Fellow Stata enthusiast [Kyle Barron](https://kylebarron.github.io/) has developed and made available `stata_kernel` which makes Stata available in Jupyter Notebooks. Check [here](https://kylebarron.github.io/stata_kernel/getting_started/) for more information on setup and installation. Otherwise [here](https://github.com/adamrossnelson/StataQuickReference/blob/master/StataNotebookExample.ipynb) is a working example.

<!-- TOC -->

- [1. Table of Coneents](#1-table-of-coneents)
- [2. Stata Quick Reference](#2-stata-quick-reference)
    - [2.1. Fictional Grade Point Average Data](#21-fictional-grade-point-average-data)
    - [2.2. Examples related to plotting images and figures](#22-examples-related-to-plotting-images-and-figures)
        - [2.2.1. BasicPlotting.do](#221-basicplottingdo)
        - [2.2.2. Stacked area chart StackArea.do](#222-stacked-area-chart-stackareado)
        - [2.2.3. marginstrend.do](#223-marginstrenddo)
        - [2.2.4. geoplotipeds.do](#224-geoplotipedsdo)
        - [2.2.5. Facradar.do](#225-facradardo)
        - [2.2.6. GetStataSchemes.do](#226-getstataschemesdo)
        - [2.2.7. Lesser Known But Helpful](#227-lesserknownbuthelpful)
    - [2.3. ProgArgs.do](#23-progargsdo)
    - [2.4. renvarlabs.do](#24-renvarlabsdo)
    - [2.5. md_demo.do](#25-md_demodo)
    - [2.6. asciiadam.do](#26-asciiadamdo)
- [3. Stata to Pandas Cross-Walk](#3-stata-to-pandas-cross-walk)
- [4. Importing JSON to Stata](#4-importing-json-to-stata)
- [5. License](#5-license)

<!-- /TOC -->

# 2. Stata Quick Reference

These examples are designed to run from the web. Where possible and where time has permitted these examples are both Mac and Windows compatible. But, no promises.

For a curated list of packages, their descriptions, and links to further documentation see: [list of useful packages](https://github.com/adamrossnelson/StataQuickReference/blob/master/usefulpackages.md)

The folks over [geocenter.github.io](https://geocenter.github.io/StataTraining/portfolio/01_resource/) have produced and provided a series of Stata quick references. I keep copies printed out on cardstock at all of my workstations. They're great as gifts! [Local copies here](https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/chtshts/AllCheatSheets.pdf). Also worth reviewing are similar [quick references for R and RStudio](https://www.rstudio.com/resources/cheatsheets/).

Send comments or suggestions via GitHub or Twitter : @adamrossnelson

## 2.1. Fictional Grade Point Average Data

[Fictional GPA data](https://github.com/adamrossnelson/StataQuickReference/tree/master/exampledata). Demonstration of stata random number generators.

## 2.2. Examples related to plotting images and figures

### 2.2.1. BasicPlotting.do

Simple graphics using IPEDS data `ExampleIPEDS.dta`

```Stata
// To run from command line:
do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/plotting/BasicPlotting.do
// To load example data:
use https://github.com/adamrossnelson/StataQuickReference/raw/master/exampledata/ExampleIPEDS.dta
```

Want to make your own schemes? Vince Wiggins of StataCorp provided a walk-through on this topic.

- [Scheming your way to consistent graphs](https://econpapers.repec.org/paper/bocusug06/11.htm).
- Vince's presentation materials [schemetalk.zip](http://repec.org/usug2006/schemetalk.zip).
- Also worth noting, [clever use of SMCL as a slide deck](http://repec.org/usug2006/VW_README.txt).

### 2.2.2. Stacked area chart StackArea.do

Demonstrates production of a stacked area chart in Stata. Also shows dropping a standard legend in favor of explanatory text over stacked areas/regions.

```Stata
// To run from command line:
do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/plotting/StackArea/StackArea.do
```

### 2.2.3. marginstrend.do

This do file shows using `margins` and `marginsplot` to visualize trends using Stata. Data is fictional.
```Stata
// To run from command line:
do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/plotting/marginstrend.do
```

### 2.2.4. geoplotipeds.do

Using the longitude and latitude variables stored in IPEDS data, this routine builds a visualization of the institutions in North America.

```Stata
// To run from command line:
do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/plotting/geoplotipeds.do
```

### 2.2.5. Facradar.do

Another plotting demonstration. Demonstrates generating a radar plot. Requires the `radar` package available at `http://fmwww.bc.edu/repec/bocode/r/radar.html`. The example given in `radar` documentation shows the package excels at plotting a categorical y (such as automobile make) and a continuous x (automobile weight).

This implementation plots a categorical y (such as a series of factor scores) and a continuous x (which would be each factor score's mean).

**Help wanted note:** Seeking collaborator in converting `facradar.do` into Stata `.ado` package.

### 2.2.6. GetStataSchemes.do

This file is a quick routine that will install a range of graphic schemes. Stata's graphic schemes are a useful way to improve the visual presentation of data.

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

### 2.2.7. Lesser Known But Helpful

`numlabel, add` With the `, add` option and no other arguments this command will operate on all categorical variables. Helpful when displaying and inspecting data.

`about` Displays information about your version of Stata.

`sysdir` Query system directories

`macro list` Displays information about your version and/or installation instance of Stata.

`creturn list` Displays information about your version, your computer, your installation, and a variety of system variables.

## 2.3. ProgArgs.do

Demonstration of defining a program, passing arguments, referencing and displaying the arguments passed. Demonstrates material presented Stata 15 User Manual sections 18.1 & 18.4.

To execute from command line:

```Stata
do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/ProgArgs.do
```

## 2.4. renvarlabs.do

This do file provides a method that adds text to all variable labels. Also provides an example code that can reference existing variable labels which is useful when automating output for graphs or putdoc/pdf, etc.

```Stata
// To run from command line:
do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/renvarlabs.do
```

## 2.5. md_demo.do

Generates markdown from Stata using `qui` and `noi di...` Demonstrates and tests a method for Stata to automate output for display on GitHub or Markdown.

Cannot run from the command line without downloading a local copy.

## 2.6. asciiadam.do

Example of a vaity branding splash.

To execute from command line (or do file):

```Stata
do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/asciiadam.do
```

# 3. Stata to Pandas Cross-Walk

This repo also provides a [Stata to Pandas Cross-Walk](https://github.com/adamrossnelson/StataQuickReference/blob/master/spcrosswlk.md)

# 4. Importing JSON to Stata

This  task is not as straight forward as it should or could be. At least two excellent packages exist including [insheetjson](https://ideas.repec.org/c/boc/bocode/s457407.html) and [jsonio](https://wbuchanan.github.io/StataJSON/). The [discussion boards](https://www.statalist.org/forums/forum/general-stata-discussion/general/1357829-creating-a-stata-data-file-from-a-json-formatted-file) provide friendly advice, too.

For myself, I often find it less difficult and more reliable to use Python's Pandas library. Until recently, for some use cases, this roundabout (json > pandas > stata) approach was necessary. In version 0.23.0, Pandas released support for Stata's `strL` data type. Before `strL` support, if any text fields in the JSON data contained over 2045 characters, it was difficult to go directly from `JSON` to Stata `dta`. The issue documenation (https://github.com/pandas-dev/pandas/issues/16450), resolved, and now available in the latest release. The [revised documentation](https://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.to_stata.html) also provides helpful information.

Now that Pandas supports Stata's `strL` data type, the first of the two code samples below should be sufficient. Also, if all text fields are 2045 characters or less the second code block below works well to produce a Stata `dta` file:

```Python
import pandas as pd
pd.read_json('DemoFileRaw.json').to_stata('DemoFileRaw.dta', write_index=False, 
              version=117, convert_strl=['list', 'of', 'fields')
```

A workaround that will also be sufficient for many is to first convert to MS Excel `xlsx` which Stata can then imported the command line:

```Python
import pandas as pd
pd.read_json('DemoFileRaw.json').to_excel(pd.ExcelWriter('DemoFileRaw.xlsx'), index=False)
```

# 5. License

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
