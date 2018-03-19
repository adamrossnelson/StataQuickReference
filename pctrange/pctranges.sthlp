{smcl}
{* *! pctranges v1.0.6 ARNelson 02mar2018}{...}
{cmd:help pctranges}
{hline}

{title:Title}

{phang}
{bf:pctranges {hline 2} Calculate percential ranges}

{title:Syntax}

{p 8 17 2}
{cmd:pctranges} {varlist} {ifin} [{cmd:,} {cmd:print}
{cmdab:for:mat(}{it:string}{cmd:)}
{cmdab:mat:rix(}{it:string}{cmd:)}]

{p 4 6 2}
{cmd:by} is allowed; see {manhelp byD}.{p_end}
{p 4 6 2}
{it:varlist} may contain time-series operators; see {help tsvarlist}.{p_end}

{title:Description}

{pstd}{cmd:pctranges} computes four percentile ranges of the specified variable(s): the 75-25 (interquartiles range), the 90-10, 95-05, and 99-01 ranges as well as the conventional range. These ranges are returned as scalars. If multiple variables are included in the {it:varlist}, the results are returned as a matrix.

{title:Options}

{phang}{opt print} specifies that the results are to be printed.

{phang}{opt format(string)} specifies the format to be used in displaying output.

{phang}{opt matrix(string)} specifies the name of the Stata matrix when also having specified multiple variables.

{title:Author}

{phang}Christopher F. Baum, Boston College {break}
baum@bc.edu{p_end}

{title:Editor}

{phang}Adam Ross Nelson {break}
@adamrossnelson{p_end}

{title:See Also}

{psee}Baum, C. (2016). An introduction to Stata programming. College Station, Texas: StataCorp LP.


