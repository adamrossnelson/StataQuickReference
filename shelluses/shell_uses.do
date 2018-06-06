// June 5th 2018 - Adam Ross Nelson - Initial draft.
//
// Demonstrate use of shell commands in a Unix/Linux environment.

log using shell_demos.log

// Prepare a dataset with information about files in current working directory.
// Exclamation point tells Stata to shell.
// wc is the command for word count.
// This line will operate on all .txt files and put information in finfo.txt
!wc *.txt > finfo.txt

// Import the data that was put into finfo.txt.
import delimited finfo.txt, delimiter(whitespace, collapse) clear 

// Use case of the above. Consider a context where there are multiple
// datasets in csv format. This procedure can quickly produce a set
// of meta data that will provide information related to the size of
// each dataset.




log close
