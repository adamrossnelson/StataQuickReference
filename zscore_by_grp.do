// Demonstrate creation of zscore by group.

// This example standardizes the variable fte "Full-time equivalent enrollment"
// and also variable cindon "Price for in-district students living on campus"
// by state, sector, and year.

use IPEDSDirInfo02to16.dta, clear

// Make list of variables to work with.
local thevars fte cindon

// Declare variables for later use. In this case it is necessary to declare
// variables because the loop below which creates zscores relative to group
// members must iteratively reference grpz_`varname'. Thus, it is necssary to
// use replace instead of gen in the subsequent loop.
foreach varname in `thevars' {
	gen 1grpz_`varname' = . 
}

// Loop through varlist to apply standardized zscores for each variable.
// Store standardized score in grpz_`varname'.
levelsof isYr, local(yname)
levelsof fips, local(stname)
levelsof sector, local(secname)

foreach y of local yname {
	foreach st of local stname {
		foreach sec of local secname { 
			foreach varname in `thevars' {
				local ifcond = "if isYr == `y' & fips == `st' & sector == `sec'"
				sum `varname' `ifcond'
				if r(mean) > 0 & r(mean) < . {
					replace grpz_`varname' = (`varname' - `r(mean)')/`r(sd)' `ifcond'
				}
			}
		}
	}
}

// Check results. Mean of the standardized score within each should be zero. 
bysort sector: sum grpz_fte if stabbr == "WI"
bysort sector: sum grpz_fte if stabbr == "FL"
bysort sector: sum grpz_fte if stabbr == "TX"
bysort sector: sum grpz_fte if stabbr == "CA"
 
