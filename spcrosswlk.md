# 1. Stata to Pandas Cross-Walk

<!-- TOC -->

- [1. Stata to Pandas Cross-Walk](#1-stata-to-pandas-cross-walk)
- [2. Introduction](#2-introduction)
- [3. Pendng & Unresolved Issues](#3-pendng--unresolved-issues)
- [4. Data Management](#4-data-management)
    - [4.1. Starting Out](#41-starting-out)
    - [4.2. Categorical Factor Variables](#42-categorical-factor-variables)
    - [4.3. Merge Datasets](#43-merge-datasets)
    - [4.4. Append Datasets](#44-append-datasets)
    - [4.5. Reshape Datasets](#45-reshape-datasets)
    - [4.6. Loops](#46-loops)
- [5. Exporting Pandas data to Stata](#5-exporting-pandas-data-to-stata)
    - [5.1. Problems With Unicode](#51-problems-with-unicode)
    - [5.2. Converting Object Data Types](#52-converting-object-data-types)
    - [5.3. Handling Column Names](#53-handling-column-names)
    - [5.4 Writing Variable Labels](#54-writing-variable-labels)
- [6. Also useful](#6-also-useful)
    - [6.1. Summary Statistics](#61-summary-statistics)
    - [6.2. Advanced Summary Stats With Pandas Profiling](#62-advanced-summary-stats-with-pandas-profiling)
    - [6.3. External Resouces](#63-external-resouces)
- [7. Questions, Comments, & Contributions](#7-questions-comments--contributions)

<!-- /TOC -->

# 2. Introduction

This repo uses Stata example data sets to crosswalk a variety of Stata-Pandas equivalent code.
  * `auto2.dta` available at http://www.stata-press.com/data/r15/auto2.dta 
  * `hbp2.dta` available at http://www.stata-press.com/data/r15/hbp2.dta
  * `autoexpense.dta` available at http://www.stata-press.com/data/r15/autoexpense.dta
  * `autosize.dta` available at http://www.stata-press.com/data/r15/autosize.dta

For pandas, this crosswalk assumes the following import statements:

```python
import numpy as np
import pandas as pd
from pandas import Series, DataFrame
# Additional optional setting
pd.set_option('display.max_rows', 8)
```

# 3. Pendng & Unresolved Issues

* If anyone knows how to make multi-line code blocks in a markdown table with syntax highlighting. Let me know.
* At least one programmer has provided the [option to execute Stata commands from Python](https://www.stata.com/meeting/columbus15/abstracts/materials/columbus15_childs.pdf).
* Also helpful is the [Jupyter Notebooks Kernel](https://kylebarron.github.io/stata_kernel/).
* Adding a hilight for those having trouble [Exporting Pandas data to Stata](#5-exporting-pandas-data-to-stata) below.

# 4. Data Management

## 4.1. Starting Out

Description | Stata Code | Pandas Code
------------|------------|------------
Load example data | `use http://www.stata-press.com/data/r15/auto2.dta` | `exfile = pd.read_stata('http://www.stata-press.com/data/r15/auto2.dta')`
Display data | `list` | `exfile`
Display subset of observations | `list in 1/10` <br> or <br> `list in 10/20` | `exfile.head(n=10)` <br> or <br> `exfile[9:20]`
Display subset of variables | `list make price mpg trunk` | `exfile[['make','price','mpg','trunk']]`
Display subset of obs & vars | `list make price mpg trunk in 1/10` | `exfile[['make','price','mpg','trunk']].head(n=10)`
Display specific observation | `list make price mpg trunk if _n == 10` | The most Stata-like will be <br> `exfile.iloc[9]` <br> also available is `df.loc` when label-location based index is available.
Display observation(s) by logic | `list make price mpg trunk if mpg > 30` | `exfile[exfile['mpg'] > 30]`
List variable names and/or get variable information | `desc` <br> or <br> `describe` | `exfile.dtypes` and <br> `exfile.describe()` or <br> `for var in exfile.columns:` <br> &nbsp;&nbsp;&nbsp;&nbsp; `print(var)`
Generate new text variable | `gen newtxt = "Some text here"` | `exfile['newtxt'] = 'Some text here'`
Change text variable value | `replace newtxt = "Newer text that is really looooooong."` | `exfile['newtxt'] = 'Newer text that is really looooooong.'`
Replace or change text variable based on existing variable | `replace newtxt = substr(newtxt, 1, 10)` <br> or <br> `gen newest = substr(newtxt, 1, 10)` | `exffile['newtxt'] = exfile['newtxt'].str.slice(0,10)` <br> or <br> `exffile['newest'] = exfile['newtxt'].str.slice(0,10)`
Split text variables | `split make, parse(" ")` | `exfile['ms'] = exfile['make'].str.split(' ')` *
Replace text in variables | `replace make = subinstr(make," ","-",.)` | `exfile['make'] = exfile['make'].str.replace(' ', '-')`
Replace or change value based on existing values | `replace headroom == 9.0 if headroom == 3.0` | `exfile['headroom'] = exfile['headroom'].replace(3.0,9.0)` <br> or <br> `exfile['foreign'] = exfile['foreign'].replace('Domestic','USA')`
Generate new int variable | `gen newnum = 10` | `exfile['newnum'] = 10`
Change int variable value | `replace newnum = 222` | `exfile['newnum'] = 222`
Generate dummy based on text variable | `gen fgn = (foreign == "Foreign")` | `exfile['fgn'] = np.where(exfile['foreign']=='Foreign', 1, 0)` <br> or <br> `exfile['fgn'] = exfile['foreign'].apply(lambda x: 1 if x == 'Foreign' else 0)`
Generate new variable relative to other variable | `gen rtd_disp = displacement / 10` <br> or <br> `gen mpg2 = mpg * mpg` <br> or <br> `gen lprice = ln(price)` | `exfile['rtd_disp'] = exfile['displacement'] / 10` <br> or <br> `exfile['mpg2'] = exfile['mpg'] * exfile['mpg']` <br> or <br> `exfile['lprice'] = np.log10(exfile['price'])` <br> or <br> `exfile['mpg2'] = [i * i for i in list(exfile['mpg'])]` <br> or <br> `exfile['mpg2'] = exfile['mpg'].apply(lambda x: x * x)`
Generate new variable equal to _n or index | `gen sorter = _n` | `exfile['sorter'] = np.arange(0,len(exfile.index))`
Rename a variable | `rename mpg milespg` | Two steps: `exfile['milespg'] = exfile['mpg']` <br> `del exfile['mpg']` <br> One steps: <br> `exfile.rename(columns = {'mpg':'milespg'}, inplace=True)`
Delete variable(s) | `drop newtxt newnum` | `exfile = exfile.drop(columns=['newtxt','newnum'])`  <br> or <br> `exfile = exfile.drop(['newtxt','newnum'], axis=1)`  <br> or <br> `del exfile['newtxt']` <br> `del exfile['newnum']`
Keep variable(s) | `keep make price mpg` | `exfile = exfile[['make','price','mpg']]`
Delete specific observation | `drop if _n = 10` | `exfile = exfile.drop(9)`
Delete observation(s) by logic | `drop if mpg > 30` <br> or <br> `keep if mpg < 31` | `exfile = exfile[exfile['mpg'] < 31]` <br> or <br> `exfile = exfile[exfile['mpg'] > 30]`
Sorting by a variable ascending | `sort price` | `exfile = exfile.sort_values(by=['price'])`
Sorting by a variable descending | `gsort -price` | `exfile = exfile.sort_values(by=['price'], ascending=False)`
Display summary statistics (specific variables) | `sum price mpg weight` | `exfile[['price','mpg','weight']].describe()` <br> or <br> `exfile[['price','mpg','weight']].describe().T`
Enstring numbers | `tostring price, gen(pricestr)` | `exfile['price_str'] = exfile['price'].astype(str)`
Destring strings | `destring pricestr, gen(pricenum)` | `exfile['price_num'] = exfile['price_str'].astype(int)`

* *Splits behave differently in Stata & Pandas. More development needed here.*

A function that Stata does quickly and simplistically `count`, is not well implemented in Pandas.

```Stata
set more off
clear all
use http://www.stata-press.com/data/r15/auto2.dta
count if foreign == 1
```

```
# Counting a categorical. Map the category you want to count into a series.
# Then use `series.count()` to get non NaN instatnces.
exfile = pd.read_stata('http://www.stata-press.com/data/r15/auto2.dta')
exfile['foreign'].map({1:1}).count()
```

## 4.2. Categorical Factor Variables

Description | Stata Code | Pandas Code
------------|------------|------------
Load example data | `use http://www.stata-press.com/data/r15/hbp2.dta` | `exfile = pd.read_stata('http://www.stata-press.com/data/r15/hbp2.dta')`
One-way tabulation | `tab year` <br> or <br> `tab race` | `exfile['year'].value_counts()` <br> or <br> `exfile['race'].value_counts()`
Two-way tabulation | `tab year race` | `pd.crosstab(exfile['year'], exfile['race'])`
Two-way tagulation with `row` option that normalizes by row | `tab year race, row` | `pd.crosstab(exfile['year'], exfile['race']).apply(lambda r: r/r.sum(), axis=1)`
Two-way tabulation with `col` option that normalizes by column | `tab year race, col` | `pd.crosstab(exfile['year'], exfile['race']).apply(lambda r: r/r.sum(), axis=0)`
Three-way tabulation | `table year race sex` | `pd.crosstab(exfile['year'], [exfile['sex'], exfile['race']])`
Encode a categorical (That was originally string) | `encode sex, gen(sex_cat)` | `exfile['sex_cat'] = exfile['sex'].astype('category')` <br> then <br> `exfile['sex_cat_code'] = exfile['sex_cat'].cat.codes`
Create an array of dummies from categorical | `tab sex, gen(sex_)` | `exfile = pd.get_dummies(exfile, columns=['sex'])`

Practice tip for those transitioning from Stata to Python. Where Stata lets you reference rows and columns with the very human readable optional arguments `row` and `col`, Python wants an axis number. To make Python code more human readable, possibly easier to read it is an option to declare a row and a col variable. An example that builds on the two-way tabulation examples above.

```Python
>>> import pandas as pd
>>> exfile = pd.read_stata('http://www.stata-press.com/data/r15/hbp2.dta')
>>> row = 1; col = 0
>>> 
>>> # Now user row and col variables instead of axis index.
>>> pd.crosstab(exfile['year'], exfile['race']).apply(lambda r: r/r.sum(), axis=row)

race     White     Black  Hispanic
year                              
1988  0.104167  0.812500  0.083333
1989  0.077670  0.796117  0.126214
1990  0.195652  0.686957  0.117391
1991  0.207547  0.664151  0.128302
1992  0.200873  0.620087  0.179039
1993  0.147410  0.701195  0.151394

>>> pd.crosstab(exfile['year'], exfile['race']).apply(lambda r: r/r.sum(), axis=col)

race     White     Black  Hispanic
year                              
1988  0.025510  0.050453  0.025478
1989  0.040816  0.106080  0.082803
1990  0.229592  0.204398  0.171975
1991  0.280612  0.227684  0.216561
1992  0.234694  0.183700  0.261146
1993  0.188776  0.227684  0.242038
```

## 4.3. Merge Datasets

Description | Stata Code | Pandas Code
------------|------------|------------
Load example data | `use http://www.stata-press.com/data/r15/autoexpense.dta`<br> and <br> `use http://www.stata-press.com/data/r15/autosize.dta` | `autoexp = pd.read_stata('http://www.stata-press.com/data/r15/autoexpense.dta')` <br> and <br> `autosiz = pd.read_stata('http://www.stata-press.com/data/r15/autosize.dta')`
Merge autoexpense autosize (using make as the key variable) | After loading `autosize.dta` <br> `merge 1:1 make using http://www.stata-press.com/data/r15/autoexpense.dta` | `pd.merge(autoexp,autosiz, on='make', how='outer')`

**Mismatched Defaults.** By default Stata performs what Pandas would refer to as an `outer` merge. Meaning "use union of keys from both frames, similar to a SQL full outer join; sort keys lexicographically." (cite)[https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.merge.html]. More simply, the result will include all records from both datasets.

The default in Pandas performs an `inner` merge which means "use intersection of keys from both frames, similar to a SQL inner join; preserve the order of the left keys." (cite)[https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.merge.html]. Again more simply, the result will only include records that matched in both datasets.

For Stata users looking to replicate Stata's behavior on a merge operation it is necessary to specify the `how='outer'` argument in the `pd.merge()` statement.

**The missing ouput.** By default Stata performs the merge operation while also adding a variable called `_merge` which indicates for each observation it that observation was from the master dataset (equivalent to the left side), the using dataset (equivalent to the right side), or both datasets. Additionally, Stata provides output which can help verify the merge operation was successful. To replicate Stata's behavior in Pandas users can add the `indicator=True` argument to the `pd.merge()` statement. This indicator arguemtn then adds a variable that Pandas also calls `_merge` which can then be tabulated or cross-tabulated with other variables to assess merge results. A full example, using the above:

```Pthon
autoexp = pd.read_stata('http://www.stata-press.com/data/r15/autoexpense.dta')
autosiz = pd.read_stata('http://www.stata-press.com/data/r15/autosize.dta')
df = pd.merge(autoexp,autosiz, on='make', how='outer', indicator=True)
df['_merge'].value_counts()

both          5
right_only    1
left_only     0
Name: _merge, dtype: int64
```
Another example using mock data:

```Python
import random
data1 = {'var1':[1,2,3,4,5],
         'dat1':[random.randrange(10,99,1) for i in range(5)]}
data2 = {'var1':[2,3,4,5,6],
         'dat2':[random.randrange(10,99,1) for i in range(5)]}
df = pd.merge(pd.DataFrame(data1), pd.DataFrame(data2), on='var1', 
              how='outer', indicator=True)
df['_merge'].value_counts()

both          4
right_only    1
left_only     1
Name: _merge, dtype: int64
```

## 4.4. Append Datasets

Description | Stata Code | Pandas Code
------------|------------|------------
Load example data | `use http://www.stata-press.com/data/r15/capop.dta`<br> and <br> `use http://www.stata-press.com/data/r15/txpop.dta` | `capop = pd.read_stata('http://www.stata-press.com/data/r15/capop.dta')` <br> and <br> `txpop = pd.read_stata('http://www.stata-press.com/data/r15/txpop.dta')`
Append CA population with TX population | After loading `txpop.dta` <br> `append using http://www.stata-press.com/data/r15/capop.dta` | `pd.concat([capop,txpop])` <br> or <br> `pd.concat([capop,txpop]).reset_index()`
Append and mark sources | `append using http://www.stata-press.com/data/r15/capop.dta, generate(source)` | `pd.concat([capop,txpop],keys=['ca','tx'])`

## 4.5. Reshape Datasets

Description | Stata Code | Pandas Code
------------|------------|------------
Load example data | `use http://www.stata-press.com/data/r15/reshape1.dta` | `exfile = pd.read_stata('http://www.stata-press.com/data/r15/reshape1.dta')`
Reshape from wide to long | `reshape long inc ue, i(id) j(year)` | `exfile = pd.wide_to_long(exfile, stubnames=['inc','ue'], i=['id','sex'], j='year')` <br> for more Stata-like then: <br> `exfile = exfile.reset_index(0).reset_index(0).reset_index(0)`
Reshape long to wide | `reshape wide inc ue, i(id) j(year)` | Quick version: <br> `exfile2 = exfile.pivot_table(values=['sex','inc','ue'], columns='year', index='id')`

While Pandas provides `wide_to_long` option, it does not provide a `long_to_wide` option. Below is code that will produce a long to wide reshape more consistent with Stata's results.

```Python
# Load example data that in long format.
exfile = pd.read_stata('http://www.stata-press.com/data/r15/reshape6.dta')

# Perpare wide dataframes for each variable that changes over j.
exfile['inc_idx'] = 'inc' + exfile.year.astype(str)
inc = exfile.pivot(index='id',columns='inc_idx',values='inc')

exfile['ue_idx'] = 'ue' + exfile.year.astype(str)
ue = exfile.pivot(index='id',columns='ue_idx',values='ue')

# Concatenate / Append individual wide datasets.
exfile2 = pd.concat([inc,ue],axis=1).reset_index()

# Gather values for varaibles that do not change over j.
exfile_sex = DataFrame(exfile[['id','sex']])
exfile_sex = exfile_sex.pivot_table(index='id', values='sex').reset_index()

# Merge variables that do not change over j.
exfile3 = pd.merge(exfile_sex, exfile2, on='id')
exfile3
```

## 4.6. Loops

### Foreach Loops
**Stata Version**
```Stata
use http://www.stata-press.com/data/r15/auto2.dta

foreach var in price mpg weight length {
    sum `var'
    gen z`var' = (`var' - r(mean)) / r(sd)
}

list price mpg weight length zprice zmpg zweight zlength in 1/5
```
**Python Version**
```Python
import pandas as pd
from scipy.stats import zscore

exfile = pd.read_stata('http://www.stata-press.com/data/r15/auto2.dta')

for var in ['price','mpg','weight','length']:
    exfile['z{}'.format(var)] = exfile[[var]].apply(zscore)

exfile.head()
```

### Forvalues Loops

**Stata Version**

```Stata
clear all

input str10 Observer Day1 Day2 Day3
   "Adam" 3 7 8
   "Ken"  6 4 6
   "Zita" 7 6 4
   "Sam"  4 6 2
end

forvalues i = 1/3 {
   sum Day`i'
   gen zDay`i' = (Day`i' - r(mean)) / r(sd)
}

list
```
**Python Version**
```Python
import pandas as pd
from scipy.stats import zscore

df = pd.DataFrame({'Observer':['Adam','Ken','Zita','Ari','Sam'],
                  'Day1':[3,6,7,8,4],
                  'Day2':[7,4,6,5,6],
                  'Day3':[8,6,4,3,2]})

for i in range(1,4):
    df['zDay{}'.format(i)] = df[['Day{}'.format(i)]].apply(zscore)

df
```



# 5. Exporting Pandas data to Stata

## 5.1. Problems With Unicode

A problem that happens when saving to Stata is that `pandas.DataFrame.to_stata` sometimes writes unicode characters even though the format used by `pandas.DataFrame.to_stata` does not support unicode. Documented on [this issue](https://github.com/pandas-dev/pandas/issues/23573#issuecomment-441341673). A simplistc explanation is that unicode chracters can throw off the expected chracter count in Stata data. A crude solution is to make sure each chracter is only one chracter space:

```Python
# Define function that finds and replaces offensive characters.
def fix_char_ct(bad_text):
    ret_txt = ''
    for item in bad_text:
        ret_txt += item if len(item.encode(encoding='utf_8')) == 1 else ''
    return(ret_txt)

# Use apply to clean problematic text.
df['Problematic_Txt'] = df['Problematic_Txt'].apply(fix_char_ct)
```
## 5.2. Converting Object Data Types

Another frequent problem is that `pandas.DataFrame.to_stata` seems to have trouble writing the object data type. A solution to this trouble is:

```Python
# Define function that finds object data types, converts to string.
def obj_to_string(df):
    for obj_col in list(df.select_dtypes(include=['object']).columns):
        df[obj_col] = df[obj_col].astype(str)
    return(df)

# Pass dataframe with object data types to function.
df = obj_to_string(df)
```

## 5.3. Handling Column Names

Acceptable variable names in Stata is more limited than those in Pandas. To help `pandas.DataFrame.to_stata` is able to make corrections. However, sometimes the default corrections might not be preferred. A solution is to rename columns before writing to Stata:

```Python
# This function cleans a string so that only letters a-z and digits 0-9  remain. 
# Also removes spaces. Optional case argument controls variable name character case.
def clean_word(word, *, case='lower'):
    import re
    if case == 'lower':
        return(''.join(re.findall(r'[a-z|A-Z|0-9]', word.lower())))
    elif case == 'upper':
        return(''.join(re.findall(r'[a-z|A-Z|0-9]', word.upper())))
    elif case == 'asis':
        return(''.join(re.findall(r'[a-z|A-Z|0-9]', word)))
    else:
        raise Exception('Argument (case) incorrectly specified. \
                        Default is "lower" Alternate options \
                        are "upper" and "asis".')

# This funciton cleans list of column names so that only letters a-z and digits 0-9 
# remain. Also removes spaces. Makes sure each column name is unique. If duplicats
# present will print warning with explanation.
def clean_cols(clst, *, case='lower'):
    import warnings
    newcols = []
    for col in clst:
        newcols.append(clean_word(col, case=case))
    if len(clst) != len(set(newcols)):
        warnings.warn('\nDuplicates in column list. \
                      \nDuplicates appended with location.')
        newestcols = []
        suffix = 0
        for i in newcols:
            if newcols.count(i) > 1:
                newestcols.append(i + str(suffix))
            else:
                newestcols.append(i)
            suffix += 1
        return(newestcols)
    else:
        return(newcols)

# Using the above functions.
df.columns = clean_cols(df.columns)

# or

df.columns = clean_cols(df.columns, case='upper')

# or 

df.columns = clean_cols(df.columns, case='asis')
```

## 5.4 Writing Variable Labels

See here for a [demonstration of writing Variable Labels](https://github.com/adamrossnelson/StataQuickReference/blob/master/dtaconversion/WriteDTAValueLabels.ipynb).


# 6. Also useful

## 6.1. Summary Statistics

Quickly display table (a Pandas DataFrame) that lists variables, variable descriptions (variable labels), and summary statistics.

```python
import pandas as pd

auto = 'http://www.stata-press.com/data/r15/auto.dta'
reader = pd.io.stata.StataReader(auto)
exfile = pd.read_stata(auto)

pd.merge(pd.DataFrame(reader.variable_labels(), index=['Label']).transpose(), 
         exfile.describe(include='all').transpose(), 
         left_index=True, 
         right_index=True)
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Label</th>
      <th>count</th>
      <th>unique</th>
      <th>top</th>
      <th>freq</th>
      <th>mean</th>
      <th>std</th>
      <th>min</th>
      <th>25%</th>
      <th>50%</th>
      <th>75%</th>
      <th>max</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>make</th>
      <td>Make and Model</td>
      <td>74</td>
      <td>74</td>
      <td>Pont. Le Mans</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>price</th>
      <td>Price</td>
      <td>74</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>6165.26</td>
      <td>2949.5</td>
      <td>3291</td>
      <td>4220.25</td>
      <td>5006.5</td>
      <td>6332.25</td>
      <td>15906</td>
    </tr>
    <tr>
      <th>mpg</th>
      <td>Mileage (mpg)</td>
      <td>74</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>21.2973</td>
      <td>5.7855</td>
      <td>12</td>
      <td>18</td>
      <td>20</td>
      <td>24.75</td>
      <td>41</td>
    </tr>
    <tr>
      <th>rep78</th>
      <td>Repair Record 1978</td>
      <td>69</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>3.4058</td>
      <td>0.989932</td>
      <td>1</td>
      <td>3</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
    </tr>
    <tr>
      <th>headroom</th>
      <td>Headroom (in.)</td>
      <td>74</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2.99324</td>
      <td>0.845995</td>
      <td>1.5</td>
      <td>2.5</td>
      <td>3</td>
      <td>3.5</td>
      <td>5</td>
    </tr>
    <tr>
      <th>trunk</th>
      <td>Trunk space (cu. ft.)</td>
      <td>74</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>13.7568</td>
      <td>4.2774</td>
      <td>5</td>
      <td>10.25</td>
      <td>14</td>
      <td>16.75</td>
      <td>23</td>
    </tr>
    <tr>
      <th>weight</th>
      <td>Weight (lbs.)</td>
      <td>74</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>3019.46</td>
      <td>777.194</td>
      <td>1760</td>
      <td>2250</td>
      <td>3190</td>
      <td>3600</td>
      <td>4840</td>
    </tr>
    <tr>
      <th>length</th>
      <td>Length (in.)</td>
      <td>74</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>187.932</td>
      <td>22.2663</td>
      <td>142</td>
      <td>170</td>
      <td>192.5</td>
      <td>203.75</td>
      <td>233</td>
    </tr>
    <tr>
      <th>turn</th>
      <td>Turn Circle (ft.)</td>
      <td>74</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>39.6486</td>
      <td>4.39935</td>
      <td>31</td>
      <td>36</td>
      <td>40</td>
      <td>43</td>
      <td>51</td>
    </tr>
    <tr>
      <th>displacement</th>
      <td>Displacement (cu. in.)</td>
      <td>74</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>197.297</td>
      <td>91.8372</td>
      <td>79</td>
      <td>119</td>
      <td>196</td>
      <td>245.25</td>
      <td>425</td>
    </tr>
    <tr>
      <th>gear_ratio</th>
      <td>Gear Ratio</td>
      <td>74</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>3.01486</td>
      <td>0.456287</td>
      <td>2.19</td>
      <td>2.73</td>
      <td>2.955</td>
      <td>3.3525</td>
      <td>3.89</td>
    </tr>
    <tr>
      <th>foreign</th>
      <td>Car type</td>
      <td>74</td>
      <td>2</td>
      <td>Domestic</td>
      <td>52</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>


## 6.2. Advanced Summary Stats With Pandas Profiling

This is an implementation of [10 Simple Hacks To Speed... Data Analysis...](https://medium.com/p/10-simple-hacks-to-speed-up-your-data-analysis-in-python-ec18c6396e6b) but with Stata's `auto.dta`. The article's implemenation was pre version 2.0.0. The imlemenation below is 2.0.0+ syntax.

```python
pip install pandas-profiling

# or

conda install -c anaconda pandas-profiling
```

```python
import pandas as pd
import pandas_profiling

df = pd.read_stata('http://www.stata-press.com/data/r15/auto2.dta')

profile = df.profile_report()
rejected = profile.get_rejected_variables()
df.profile_report(title='Stata Auto.dta Pandas Profiled',
                  correlation_overrides=[rejected])
profile.to_file(output_file='Stata_Auto.dta_Profile.html')
```

The `Stata_Auto.dta_Profile.html` output is available [here](Classic_Auto.dta_Profile.html).


## 6.3. External Resouces

* [Pandas cheatsheet](https://s3.amazonaws.com/assets.datacamp.com/blog_assets/PandasPythonForDataScience.pdf)
* [Stata cheesheets](https://github.com/adamrossnelson/StataQuickReference/blob/master/chtshts/AllCheatSheets.pdf)
* [Guide to Encoding Categorical Values in Python](http://pbpython.com/categorical-encoding.html)
* Ordinary Least Squares Regression Starting Points
  * [SciKit Learn linear regression example](https://scikit-learn.org/stable/auto_examples/linear_model/plot_ols.html).
  * [Simple & multiple linear regression in Python](https://towardsdatascience.com/simple-and-multiple-linear-regression-in-python-c928425168f9)
  * [Regression with Pandas (Stackoverflow Post)](https://stackoverflow.com/questions/19991445/run-an-ols-regression-with-pandas-data-frame)
  * [python stats models - quadratic term in regression](https://stackoverflow.com/a/36539157/9572143)

# 7. Questions, Comments, & Contributions

Send me your questions, comments, contributions, and tell me what I did wrong.

Fork and pull requests welcome.
