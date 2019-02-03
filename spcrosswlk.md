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
- [5. Exporting Pandas data to Stata](#5-exporting-pandas-data-to-stata)
    - [5.1. Problems With Unicode](#51-problems-with-unicode)
    - [5.2. Converting Object Data Types](#52-converting-object-data-types)
    - [5.3. Handling Column Names](#53-handling-column-names)
- [6. Also useful](#6-also-useful)
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
* Adding a hilight for those having trouble exporting Pandas data to Stata at below.

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
Generate dummy based on text variable | `gen fgn = (foreign == "Foreign")` | `exfile['fgn'] = np.where(exfile['foreign']=='Foreign', 1, 0)`
Generate new variable relative to other variable | `gen rtd_disp = displacement / 10` <br> or <br> `gen mpg2 = mpg * mpg` <br> or <br> `gen lprice = ln(price)` | `exfile['rtd_disp'] = exfile['displacement'] / 10` <br> or <br> `exfile['mpg2'] = exfile['mpg'] * exfile['mpg']` <br> or <br> `exfile['lprice'] = np.log10(exfile['price'])`
Generate new variable equal to _n or index | `gen sorter = _n` | `exfile['sorter'] = np.arange(0,len(exfile.index))`
Rename a variable | `rename mpg milespg` | Two steps: `exfile['milespg'] = exfile['mpg']` <br> `del exfile['mpg']` <br> One steps: <br> `exfile.rename(columns = {exfile.columns[2]:'milespg'}, inplace=True)`
Delete variable(s) | `drop newtxt newnum` | `exfile = exfile.drop(columns=['newtxt','newnum'])`  <br> or <br> `exfile = exfile.drop(['newtxt','newnum'], axis=1)`  <br> or <br> `del exfile['newtxt']` <br> `del exfile['newnum']`
Keep variable(s) | `keep make price mpg` | `exfile = exfile[['make','price','mpg']]`
Delete specific observation | `drop if _n = 10` | `exfile = exfile.drop(9)`
Delete observation(s) by logic | `drop if mpg > 30` <br> or <br> `keep if mpg < 31` | `exfile = exfile[exfile['mpg'] < 31]` <br> or <br> `exfile = exfile[exfile['mpg'] > 30]`
Sorting by a variable ascending | `sort price` | `exfile = exfile.sort_values(by['price'])`
Sorting by a variable descending | `gsort -price` | `exfile = exfile.sort_values(by['price'], ascending=False)`
Display summary statistics (specific variables) | `sum price mpg weight` | `exfile[['price','mpg','weight']].describe()` <br> or <br> `exfile[['price','mpg','weight']].describe().T`
Enstring numbers | `tostring price, gen(pricestr)` | `exfile['price_str'] = exfile['price'].astype(str)`
Destring strings | `destring pricestr, gen(pricenum)` | `exfile['price_num'] = exfile['price_str'].astype(int)`

* *Splits behave differently in Stata & Pandas. More development needed here.*

## 4.2. Categorical Factor Variables

Description | Stata Code | Pandas Code
------------|------------|------------
Load example data | `use http://www.stata-press.com/data/r15/hbp2.dta` | `exfile = pd.read_stata('http://www.stata-press.com/data/r15/hbp2.dta')`
One-way tabulation | `tab year` <br> or <br> `tab race` | `exfile['year'].value_counts()` <br> or <br> `exfile['race'].value_counts()`
Two-way tabulation | `tab year race` | `pd.crosstab(exfile['year'], exfile['race'])`
Three-way tabulation | `table year race sex` | `pd.crosstab(exfile['year'], [exfile['sex'], exfile['race']])`
Encode a categorical (That was originally string) | `encode sex, gen(sex_cat)` | `exfile['sex_cat'] = exfile['sex'].astype('category')` <br> then <br> `exfile['sex_cat_code'] = exfile['sex_cat'].cat.codes`
Create an array of dummies from categorical | `tab sex, gen(sex_)` | `exfile = pd.get_dummies(exfile, columns=['sex'])`

## 4.3. Merge Datasets

Description | Stata Code | Pandas Code
------------|------------|------------
Load example data | `use http://www.stata-press.com/data/r15/autoexpense.dta`<br> and <br> `use http://www.stata-press.com/data/r15/autosize.dta` | `autoexp = pd.read_stata('http://www.stata-press.com/data/r15/autoexpense.dta')` <br> and <br> `autosiz = pd.read_stata('http://www.stata-press.com/data/r15/autosize.dta')`
Merge autoexpense autosize (using make as the key variable) | After loading `autosize.dta` <br> `merge 1:1 make using http://www.stata-press.com/data/r15/autoexpense.dta` | `pd.merge(autoexp,autosiz, on='make',how='outer')`

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

# 6. Also useful

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
