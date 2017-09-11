// This do file quickly installs additional Stata graph schemes.
// Author: Adam Ross Nelson @adamrossnelson
// Original version: September 2017

// Standard schemes available from ssc.
ssc install blindschemes, replace
ssc install scheme-burd, replace
ssc install scheme_rbn1mono, replace

// "Lean" series of schemes.
net install gr0002_3, from(http://www.stata-journal.com/software/sj4-3) replace

// Builds a "wide" version of "Lean" series from above.
	// Open Svend Juul's "Lean2" Scheme into scalar schemecontents.
	// For non-default installations or for IOS, revise path to "scheme-lean2.scheme"
	scalar schemecontents = fileread("C:\ado\plus\s\scheme-lean2.scheme")
	// Build sstr1 search string.
	scalar sstr1 = "#include s2mono"
	// Build rstr1 replacement string.
	scalar rstr1 = "// Contributor: Adam Ross Nelson; modification - Adds graphysize y, proportionally reduce graph height." + ///
	char(13) + char(10) + "// info at: https://github.com/adamrossnelson/StataQuickReference/blob/master/GetStataSchemes.do and ..." + ///
	char(13) + char(10) + "// https://github.com/adamrossnelson/StataQuickReference" + ///
	char(13) + char(10) + char(13) + char(10) + "#include s2mono"
	// Find sstr1 and replace with rstr1.
	// Document the edits / revisions to the file.
	scalar schemecontents = subinstr(schemecontents,  sstr1, rstr1, 1)

	// Build sstr2 second search string
	scalar sstr2 = "graphsize x                  6"
	// Build rstr2 second replacement string.
	scalar rstr2 = "graphsize x                  6" + char(13) + char(10) + ///
	"// To accomplish a wide aspect ratio adding y (height) specification." + char(13) + char(10) + ///
	"graphsize y                  3"
	// Find sstr2 and repalce with sstr2.
	scalar schemecontents = subinstr(schemecontents,  sstr2, rstr2, 1)

	// Save new scheme "scheme-lean2wide.scheme"
	scalar byteswritten = filewrite("C:\ado\plus\s\scheme-lean2wide.scheme", schemecontents, 1)

// Copy Lean2Wide help documentation.
copy "https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/scheme_lean2wide.hlp" ///
"c:/ado/plus/s/", replace

// Needs line to download the lean2wide scheme file.
set scheme lean2wide, perm

// Show available schemes:
graph query, schemes
