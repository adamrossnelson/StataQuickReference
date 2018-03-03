*! cumtab v1.0.0 ARNelson 02mar2018

program cumtab, rclass byable(recall)
    // Version control
    version 15

    preserve
    syntax varlist(min=2 max=3 numeric) [if] [in] [, UCase(string) CENter SColumn row]
    
    if "`ucase'" != "seeds" & "`ucase'" != "appls" & "`ucase'" != "stus" & "`ucase'" != "" {
        di "`ucase'"
        di as error "Use case option (ucase) incorrecly specified"
        error 197
    }

    marksample touse
    quietly count if `touse'
    if `r(N)' == 0 {
        error 2000
    }

    local nvar : word count `varlist'
    clonevar DIMENSION = `1'
    qui tab DIMENSION
    if r(r) > 40 {
        di as error "First argument must be less than 41 levels, currently `r(r)'"
        error 197
    }
    clonevar RESULT = `2'
    capture assert RESULT == 1 | RESULT == 2 | RESULT == 3
    if _rc {
        di as error "Second argument must be coded as 1, 2, or 3"
        error 197
    }
    local thevars "DIMENSION RESULT"
    if `nvar' == 3 {
        clonevar SUB_GROUP_CATEGORY = `3'
        local thevars "`thevars' SUB_GROUP_CATEGORY"
        qui tab SUB_GROUP_CATEGORY
        if r(r) > 5 {
            di as error "Third argument must be less than 6 levels, currently `r(r)'"
            error 197
        }
    }

    if "`ucase'" == "" | "`ucase'" == "seeds" {
        label define col_head 0 "Total Seeds" 1 "Not Grmntd" 2 "Grmnated" 3 "Fruited"
    }
    else if "`ucase'" == "appls" {
        label define col_head 0 "Total Apps" 1 "Not Offered" 2 "Jobs Offered" 3 "Offers Accepted"
    }
    else if "`ucase'" == "stus" {
        label define col_head 0 "Total Apps" 1 "Not Admitted" 2 "Admitted" 3 "Matriculated"
    }
    label values RESULT col_head

    qui {
        expand 2 if RESULT == 3, generate(_added1)
        replace RESULT = 2 if _added1
        expand 2 if _added1 == 0, generate(_added2)
        replace RESULT = 0 if _added2
    }

    table `thevars' if `touse', `center' `scolumn' `row'
    restore
end
