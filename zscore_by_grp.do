// Demonstrate creation of zscore by group.
// This example standardizes the variable fte "Full-time equivalent enrollment"
// and also variable cindon "Price for in-district students living on campus"
// by state, sector, and year.

use IPEDSDirInfo02to16.dta

// Declare variables for later use. In this case it is necessary to declare
// the variables because the loop below which creates zscores relative to each
// state must iteratively reference grpz_`varname'. Thus, it is necssary to
// use replace instead of gen in the subsequent loop.
foreach varname in applied admitted matric {
	gen grpz_`varname' = 0 
}

// Look through varlist to apply standardized zscores for each variable.
// Store standardized score in grpz_`varname'.
encode state, gen(st)
levelsof isYr, local(yname)
levelsof fips, local(stname)
levelsof sector, local(secname)

foreach y of local yname {
  for each st of local stname {
    foreach sec of local secname { 
      foreach varname in fte cindon {
        local ifcond = "if isYr == `y' & fips == `st' & sector == `sec'"
        sum `varname' `ifcond'
        replace grpz_`varname' = (`varname' - `r(mean)')/`r(sd)' `ifcond'
      }
    }
  }
}
 
