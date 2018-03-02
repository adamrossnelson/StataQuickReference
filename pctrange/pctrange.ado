*! pctrange v1.0.5 ARNelson 02mar2018

// Specify program with rclass which will store values for later reference.
program pctrange, rclass
    // Version control
    version 14

    // Syntax statment limits to one argument which must be numeric.
    // Square brackents with print establishes an option to include output.
    // This example includes support for if and in qualifiers.
    syntax varlist(max=1 numeric) [if] [in] [, PRINT]

    // Tag subsample with temporary variable touse & test if empty.
    marksample touse
    quietly count if `touse'
    if `r(N)' == 0 {
        error 2000
    }

    // Make list of scalars for later reference
    local res range p7525 p9010 p9505 p9901

    // Establishes that program concludes these assigned names are dropped
    tempname `res'
    
    // Calculate statistics. / Also includes support for the if statment
    quietly summarize `varlist' if `touse', detail

    // Calculate statistics of interests.
    scalar `range' = r(max) - r(min)     // Provides distance from min to max
    scalar `p7525' = r(p75) - r(p25)     // Somtimes used as a measure of spread
    scalar `p9010' = r(p90) - r(p10)     // Somtimes used as a measure of inequaltiy
    scalar `p9505' = r(p95) - r(p5)      // Somtimes used to identify outliers
    scalar `p9901' = r(p99) - r(p1)      // Somtimes used to identify outliers

    // Check if print option was specified.
    if "`print'" == "print" {
        // Format and display output.
        display as result _n "Percential ranges for `varlist'"
        display as txt "  75-25 : " `p7525'
        display as txt "  90-10 : " `p9010'
        display as txt "  95-05 : " `p9505'
        display as txt "  99-01 : " `p9901'
        display as txt "  Range : " `range'
    }

    // Save scalars for later reference.
    foreach r of local res {
        return scalar `r' = ``r''
    }
    return scalar N = r(N)
    return local varname `varlist'
end
