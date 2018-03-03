*! cumtab v1.0.0 ARNelson 02mar2018

program cumtab, rclass byable(recall)
    // Version control
    version 15

    syntax varlist(min=2 max=3 numeric) [if] [in] [, UCase(string) CENter]
     
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

    preserve

    local nvar : word count `varlist'

    clonevar _plantyear = `1' 
    clonevar _result = `2'
    if `nvar' == 3 {
        clonevar _region = `3'
    }

    if "`ucase'" == "" | "`ucase'" == "seeds" {
        label define col_head 0 "Total Seeds" 1 "Not Grmntd" 2 "Grmntd" 3 "Fruited"
    }
    else if "`ucase'" == "appls" {
        label define col_head 0 "Total Apps" 1 "Not Offered" 2 "Jobs Offered" 3 "Offers Accepted"
    }
    else if "`ucase'" == "stus" {
        label define col_head 0 "Total Apps" 1 "Not Admitted" 2 "Admitted" 3 "Matriculated"
    }
    label values _result col_head

    expand 2 if _result == 3, generate(_added1)
    replace _result = 2 if _added1
    expand 2 if _added1 == 0, generate(_added2)
    replace _result = 0 if _added2

    table _plantyear _result _region if `touse', scolumn `center'

    restore
end
