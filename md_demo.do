qui {
	set more off
	clear all
	capture log close
	log using md_demo.md, replace text
	set obs 10000
	gen y = _n + rnormal(10,10)
	gen x = runiform(.5,1.25) * _n * _n
	
	noi di "# GitHub flavored markdown genderated from Stata"
	noi di "This markdown file was generated from Stata. To demonstrate and"
	noi di "test Stata's ability to automate output for display on GitHub."
	noi di "Begin by generating random numbers with a relationship. See "
	noi di "original do file `md_demo.do` for demonstrated implementation."
	noi di "Because routine generates dynamic image, must download do file "
	noi di "to demonstrate locally."
	noi di "```"
	noi di "set obs 10000"
	noi di "gen y = _n + rnormal(10.10)"
	noi di "gen x = runiform(.5,1.24) * _n * _n"
	noi di "```"
	
	noi di "## Regression Results"
	noi di "```"
	noi di " "
	noi reg y x, r
	noi di "`e(cmdline)'"
	noi di " "
	noi di "```"
	noi di "```"
	noi di " "
	noi reg y c.x#c.x, r
	noi di "`e(cmdline)'"
	noi di " "
	noi di "```"

	noi di "## Provide Graphic"
	scatter y x
	graph export md_graphic.png, replace
	noi di "![Image of Scatterplot](graphic.png)"
	noi di "## Call another do file"
	noi di "```"
	noi do https://raw.githubusercontent.com/adamrossnelson/StataQuickReference/master/asciiadam.do
	noi di "```"
	noi di "## Conclusion"
	noi di "That'll be the end of the demonstration."
	
	log close
}
