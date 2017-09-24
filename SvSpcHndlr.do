qui {

// Creation date: September 2017
// Author/Creator: Adam Ross Nelson
// Questions: Via GitHub or Twitter @adamrossnelson
// Maintained at: https://github.com/adamrossnelson/StataQuickReference

// This do prompts the user to specify a log file location. From log file 
// location this do file also infers the same location for saving dta 
// files. Lastly, this do also infers a sub dir which can be used to save
// and store temporary, working, or meta files.

// Intended use is to call this do file from another do file. This do file
// will establish three globals for later use: lobal dtagbl = $dtagbl AND
// Global loggbl = $loggbl AND Global wkdgbl = $wkdgbl

// Set preferences
set more off
clear all
set logtype text

// Redefine "$loggbl"
global loggbl = "empty___space"

// Gathers input from user. Error checks user correctly specified .log filename.
while substr("$loggbl",-4,.) != ".log" {
	if "$loggbl" == "empty___space" {
			// Declare a global with a default project name.
		global loggbl = "LogFileName.log"
			// Ask user to define project name and location.
		capture window fsave loggbl "Specify a log file name and location." "*.log"
			// Close stray SvSpcHndlr log file.
		capture log close SvSpcHndlr
		log using "$loggbl", replace name(SvSpcHndlr)
		// Define location and file name for resulting data file.
		global dtagbl = subinstr("$loggbl",".log",".dta",.)
			// Define location path for workspace.
		global wkdgbl = subinstr("$loggbl",".log","wksp",.)
	} 
	else {
		capture window stopbox stop "Try again: File name must end in -.log-"
		global loggbl = "empty___space"
	}
}

		// Provide user with information & option to cancel.

		noi di "#############################################################################"
		noi di ""
		noi di "     This do file will create (replace):"
		noi di "          Datafile:  $dtagbl"
		noi di "          Logfile:   $loggbl"
		noi di ""
		noi di "     This do file will create (use):"
		noi di "          Workspace: $wkdgbl"
		noi di ""
		noi di "     Dialogue window asks, Are you sure you wish to proceed?"
		noi di ""
		noi di "#############################################################################"


	window stopbox rusure "This do file create files on your computer. ?`=char(13)'" ///
	"Read Stata output and indicate if you wish to continue?"
	window stopbox note "Okay, will now proceed."

	// Make directory at workspace location.
	// -mkdir- for existing location does not delete existing data.
capture mkdir "$wkdgbl"
	// Change working directory to new location.
cd "$wkdgbl"
	// Double check working directory location.
noi di ""
noi di ""
noi di "Changed working directory; current working directory:"
noi di c(pwd)
noi di ""
noi di "Global dtagbl = $dtagbl"
noi di "Global loggbl = $loggbl"
noi di "Global wkdgbl = $wkdgbl"

log close SvSpcHndlr
}
