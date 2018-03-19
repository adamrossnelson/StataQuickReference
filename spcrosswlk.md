# Stata to Pandas Cross-Walk

This repo uses Stata's example data set `auto2.dta` available at http://www.stata-press.com/data/r15/auto2.dta to crosswalk a variety of Stata-Pandas equivalent code.

Description | Stata Code | Pandas Code
------------|------------|------------
Load example data | `use http://www.stata-press.com/data/r15/auto2.dta` | `exfile = pd.read_stata('http://www.stata-press.com/data/r15/auto2.dta')`
Display data | `list` | `exfile`
Display subset | `list in 1/10` | `exfile.head(n=10)`
List variable names | `desc` <br> or <br> `describe` | `exfile.dtypes` <br> or <br> `for row in range(len(exfile.columns)):` <br> &nbsp;&nbsp;&nbsp;&nbsp; `print(exfile.columns[row])`

## Questions, Comments, Contributions, & Hatemail

Send me your questions, comments, contributions, and tell me what I did wrong.

Fork and pull requests welcome.
