# Stata to Pandas Cross-Walk

This repo uses Stata's example data set `auto2.dta` available at http://www.stata-press.com/data/r15/auto2.dta to crosswalk a variety of Stata-Pandas equivalent code.

For pandas, this crosswalk assumes the following import statements:

```python
import numpy as pd
import pandas as pd
from pandas import Series, DataFrame
```

(*Side note, if anyone knows how to make multi-line code blocks in a markdown table with syntax highlighting. Let me know.*)

Description | Stata Code | Pandas Code
------------|------------|------------
Load example data | `use http://www.stata-press.com/data/r15/auto2.dta` | `exfile = pd.read_stata('http://www.stata-press.com/data/r15/auto2.dta')`
Display data | `list` | `exfile`
Display subset of observations | `list in 1/10` <br> or <br> `list in 10/20` | `exfile.head(n=10)` <br> or <br> `exfile[9:20]`
Display subset of variables | `list make price mpg trunk` | `exfile[['make','price','mpg','trunk']]`
Display subset of obs & vars | `list make price mpg trunk in 1/10` | `exfile[['make','price','mpg','trunk']].head(n=10)`
Display specific observation | `list make price mpg trunk if _n == 10` | `exfile.ix[9]`
Display observation(s) by logic | `list make price mpg trunk if mpg > 30` | `exfile[exfile['mpg'] > 30]`
List variable names | `desc` <br> or <br> `describe` | `exfile.dtypes` <br> or <br> `for var in exfile.columns:` <br> &nbsp;&nbsp;&nbsp;&nbsp; `print(var)`
Generate new text variable | `gen newtxt = "Some text here"` | `exfile['newtxt'] = 'Some text here'`
Change text variable value | `replace newtxt = "Newer text"` | `exfile['newtxt'] = 'Newer text'`
Generate new int variable | `gen newnum = 10` | `exfile['newnum'] = 10`
Change int variable value | `replace newnum = 222` | `exfile['newnum'] = 222`
Generate new variable relative to other variable | `gen rtd_disp = displacement / 10` <br> or <br> `gen mpg2 = mpg * mpg` <br> or <br> `gen lprice = ln(price)` | `exfile['rtd_disp'] = exfile['displacement'] / 10` <br> or <br> `exfile['mpg2'] = exfile['mpg'] * exfile['mpg']` <br> or <br> `exfile['lprice'] = np.log10(exfile['price'])`
Generate new variable equal to _n or index | `gen sorter = _n` | `exfile['sorter'] = np.arange(0,len(exfile.index))`
Rename a variable | `rename mpg milespg` | `exfile['milespg'] = exfile['mpg']` <br> `del exfile['mpg']`
Delete variable(s) | `drop newtxt newnum` | `exfile = exfile.drop(columns=['newtxt','newnum'])`  <br> or <br> `exfile = exfile.drop(['newtxt','newnum'], axis=1)`  <br> or <br> `del exfile['newtxt']` <br> `del exfile['newnum']`
Keep variable(s) | `keep make price mpg` | `exfile = exfile[['make','price','mpg']]`
Delete specific observation | `drop if _n = 10` | `exfile = exfile.drop(9)`
Delete observation(s) by logic | `drop if mpg > 30` <br> or <br> `keep if mpg < 31` | `exfile = exfile[exfile['mpg'] < 31]` <br> or <br> `exfile = exfile[exfile['mpg'] > 30]`

## Also useful

* [Pandas cheatsheet](https://s3.amazonaws.com/assets.datacamp.com/blog_assets/PandasPythonForDataScience.pdf)
* [Stata cheesheets](https://github.com/adamrossnelson/StataQuickReference/blob/master/chtshts/AllCheatSheets.pdf)

## Questions, Comments, & Contributions

Send me your questions, comments, contributions, and tell me what I did wrong.

Fork and pull requests welcome.
