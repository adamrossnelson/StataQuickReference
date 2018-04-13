// Demonstration of scatter plots between two ordinal variables.
// Inspired by: 
// https://www.reddit.com/r/stata/comments/8bpwrl/help_with_scatter_plot_why_does_it_look_like_this/


	// Clear the workspace
	set more off
	clear all

	// Set the workspace
	set obs 10000
	set seed 1234

	// Create fictional data.
	gen yvar = round(runiform(1,10))
	gen xvar = round(yvar + rnormal(0,3))
	drop if xvar > 10 | xvar < 0 | yvar > 10 | yvar < 0

	// Demonstrate problem
	scatter yvar xvar, name(first)

	// Option that involves use of jitter lots of jitter
	twoway (scatter yvar xvar, msize(vsmall) jitter(12) jitterseed(1234)), name(second)

	// Option that involves use of jitter less jitter
	twoway (scatter yvar xvar, msize(vsmall) jitter(8) jitterseed(1234)), name(third)

	// Option that involves use of jitter minimal jitter
	twoway (scatter yvar xvar, msize(vsmall) jitter(4) jitterseed(1234)), name(fourth)
