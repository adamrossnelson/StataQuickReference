// Illustration designed to illustrate the allocation of time and
// effort on data science at a hypothetical company that is getting
// that has not previously employed data scientists but that may be
// planning to acquire one or more data scientists.

// Also demonstrates production of a stacked area chart in Stata.

set more off
clear all

input year str3 quarter day planning tooling science dissem keep
	1	Q1	0	30	30	30	10	1
	1	Q2	90	22	22	38	18	1
	1	Q3	180	20	17	38	25	1
	1	Q4	270	15	10	50	25	1
	2	Q5	360	10	20	50	20	1
	2	Q6	450	10	10	60	20	1
	2	Q7	540	30	5	35	30	1
	2	Q8	630	30	5	33	32	1
	3	Q9	720	10	20	50	20	1
	3	Q10	810	10	10	60	20	1
	3	Q11	900	25	5	35	35	1
	3	Q12	990	25	10	25	40	1
	4	Q13	1080	10	20	50	20	1
	4	Q14	1170	10	10	60	20	1
	4	Q15	1260	25	5	35	35	1
	4	Q16	1350	25	10	25	40	1
	5	Q17	1440	10	20	50	20	1
	5	Q18	1530	10	10	60	20	1
	5	Q19	1620	25	5	35	35	1
	5	Q20	1710	25	10	25	40	1
	6	Q21	1800	10	20	50	20	1
end

gen quar = subinstr(quarter,"Q","",.)
destring quar, replace

gen plan = planning
gen tool = planning + tooling
gen scie = planning + tooling + science
gen diss = planning + tooling + science + diss


twoway (area diss quar, fcolor(dkgreen) lwidth(vvthin)) ///
(area scie quar, fcolor(white%20) lwidth(vvthin)) ///
(area tool quar, fcolor(white%20) lwidth(vvthin)) ///
(area plan quar, fcolor(white%20) lwidth(vvthin)), ///
ytitle(Percent of Time & Effort) ///
xtitle(Quarter) xlabel(1(1)22) ///
title(Data Science Allocation) ///
subtitle(First Five Years) legend(off) ///
text(90 2 "Dissemination", place(e)) ///
text(55 3 "Science", place(e)) ///
text(20 4 "Tooling", place(e)) ///
text(8 7 "Planning", place(e)) name(five, replace)

twoway (area diss quar, fcolor(dkgreen) lwidth(vvthin)) ///
(area scie quar, fcolor(white%20) lwidth(vvthin)) ///
(area tool quar, fcolor(white%20) lwidth(vvthin)) ///
(area plan quar, fcolor(white%20) lwidth(vvthin)) in 1/9, ///
ytitle(Percent of Time & Effort) ///
xtitle(Quarter) xlabel(1(1)9) ///
title(Data Science Allocation) ///
subtitle(First Two Years) legend(off) ///
text(90 1.5 "Dissemination", place(e)) ///
text(55 2 "Science", place(e)) ///
text(30 2.5 "Tooling", place(e)) ///
text(10 3.25 "Planning", place(e)) name(two, replace)

twoway (area diss quar, fcolor(dkgreen) lwidth(vvthin)) ///
(area scie quar, fcolor(white%20) lwidth(vvthin)) ///
(area tool quar, fcolor(white%20) lwidth(vvthin)) ///
(area plan quar, fcolor(white%20) lwidth(vvthin)) in 8/21, ///
ytitle(Percent of Time & Effort) ///
xtitle(Quarter) xlabel(8(1)21) ///
title(Data Science Allocation) ///
subtitle(Years Three Through Five) legend(off) ///
text(90 8.5 "Dissemination", place(e)) ///
text(50 9.5 "Science", place(e)) ///
text(29 11.5 "Tooling", place(e)) ///
text(12 14.5 "Planning", place(e)) name(threefive, replace)


