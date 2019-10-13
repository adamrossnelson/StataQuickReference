# Quick Reference For Working With Dates

With date data in string format following the following convention:

```
2018-02-12 15:56:08.22 UTC
2016-03-12 15:56:57.15 UTC
2020-02-12 15:57:29.65 UTC
2022-08-12 16:38:14.48 UTC
2014-02-25 18:07:34.87 UTC
```
Can be converted to date time format with:

```Stata
gen date_str = substr(message_created_date,1,19)
gen double date_time = clock(date_str, "YMDhms")
format %tcMon_DD,_CCYY_HH:MM:SS date_time
```


