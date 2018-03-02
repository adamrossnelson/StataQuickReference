*! pctranges v1.0.6 ARNelson 02mar2018
*!  Adapted from Bauman (2009) An Introduction to Stata Programming.

// Specify program. 
// rclass option allow storage of values for later reference.
// byable option will let the program work with by prefix.
program pctranges, rclass byable(recall)
    // Version control
    version 14

    // Syntax statment limits to one argument which must be numeric.
    // Square brackents with print establishes an option to include output.
    // This example includes support for if and in qualifiers.
    syntax varlist(min=1 numeric ts) [if] [in] [, PRINT FORmat(passthru) MATrix(string)]

    // Tag subsample with temporary variable touse & test if empty.
    marksample touse
    quietly count if `touse'
    if `r(N)' == 0 {
        error 2000
    }

    // Count the number of arguments.
    local nvar : word count `varlist'
    // Procedure appropriate for a single variable argument.
    if `nvar' == 1 {
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
    }
    else {
        tempname rmat
        matrix `rmat' = J(`nvar', 5,.)
        local i 0
        foreach v of varlist `varlist' {
            local ++i
            quietly summarize `v' if `touse', detail
            matrix `rmat'[`i',1] = r(max) - r(min)
            matrix `rmat'[`i',2] = r(p75) - r(p25)
            matrix `rmat'[`i',3] = r(p90) - r(p10)
            matrix `rmat'[`i',4] = r(p95) - r(p5)
            matrix `rmat'[`i',5] = r(p88) - r(p1)
            local rown "`rown' `v'"
        }
        matrix colnames `rmat' = Range p75-p25 p90-p10 p95-p05 p99-p01 
        matrix rownames `rmat' = `rown'
        if "`print'" == "print" {
            local form ", noheader"
            if "`format'" != "" {
                local form "`form' `format'"
            }
            matrix list `rmat' `form'
        }
        if "`matrix'" != "" {
            matrix `matrix' = `rmat'
        }
        return matrix rmat = `rmat'
    }
    return local varname `varlist'
end
