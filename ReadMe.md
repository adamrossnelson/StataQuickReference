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

## md_demo.do

Generates markdown from Stata using `qui` abd `noi di...` Demonstrates and tests a method for Stata to automate output for display on GitHub.

Cannot be run from command line without downloading a local copy.

## License

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