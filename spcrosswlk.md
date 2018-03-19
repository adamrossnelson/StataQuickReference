# Stata to Pandas Cross-Walk

This repo uses Stata's example data set `auto2.dta` available at http://www.stata-press.com/data/r15/auto2.dta to crosswalk a variety of Stata-Pandas equivalent code.

For pandas, this crosswalk assumes the following import statements:

```python
import numpy as pd
import pandas as pd
from pandas import Series, DataFrame
```


Description | Stata Code | Pandas Code
------------|------------|------------
Load example data | `use http://www.stata-press.com/data/r15/auto2.dta` | `exfile = pd.read_stata('http://www.stata-press.com/data/r15/auto2.dta')`
Display data | `list` | `exfile`
Display subset of observations | `list in 1/10` <br> or <br> `list in 10/20` | `exfile.head(n=10)` <br> or <br> `exfile[9:20]`
Display subset of variables | `list make price mpg trunk` | `exfile[['make','price','mpg','trunk']]`
Display subset of obs & vars | `list make price mpg trunk in 1/10` | `exfile[['make','price','mpg','trunk']].head(n=10)`
Display specific observation | `list make price mpg trunk if _n == 10` | `exfile.ix[9]`
Display observation by logic | `list make price mpg trunk if mpg > 30` | `exfile[exfile['mpg'] > 30]`
List variable names | `desc` <br> or <br> `describe` | `exfile.dtypes` <br> or <br> `for var in exfile.columns:` <br> &nbsp;&nbsp;&nbsp;&nbsp; `print(var)`
Generate new text variable | `gen newtxt = "Some text here"` | `exfile['newtxt'] = 'Some text here'`
Change text var value | `replace newtxt = "Newer text"` | `exfile['newtxt'] = 'Newer text'`
Generate new int variable | `gen newnum = 10` | `exfile['newnum'] = 10`
Change int variable value | `replace newnum = 222` | `exfile['newnum'] = 222`
Generate new variable relative to other variable | `gen rtd_disp = displacement / 10` | `exfile['rtd_disp'] = exfile['displacement'] / 10`
Generate new variable equal to _n or index | `gen sorter = _n` | 
Rename a variable | `rename mpg milespg` | `exfile['milespg'] = exfile['mpg']` <br> `del exfile['mpg']`
Delete a variable | `drop newtxt newnum` | `exfile = exfile.drop(columns=['newtxt','newnum'])`  <br> or <br> `exfile = exfile.drop(['newtxt','newnum'], axis=1)`  <br> or <br> `del exfile['newtxt']` <br> `del exfile['newnum']`
Delete an observation | `drop if _n = 10` | `exfile = exfile.drop(9)`

## Questions, Comments, & Contributions

Send me your questions, comments, contributions, and tell me what I did wrong.

Fork and pull requests welcome.
