********************************************************************************
***** Parable of Google Flu
***** Code Author: Ryan Kennedy
***** Sections: SOM Section 8
***** Last Modified: February 26, 2014
********************************************************************************

/*
Note: This section uses the data already created in the main replication file (see main
document section of replication materials). This section does the "sanity checks" for
linearity discussed in SOM section 8. Neural networks results were produced in the R
Statistical Language and the code for this is included separately.
*/

use "C:\Users\Ryan\Documents\Data\Google Flu\Replication Materials\Manuscript\ParableOfGFT(Replication).dta", clear

*** Sanity tests of linearity for SOM section 8
*Plot cumulative distribution of errors (SFig 26)
sort difdeflu09
* Calculate cumulative distribution across errors from GFT, Lag and Seasonality Model
cumul difdeflu09, generate(cdifdeflu09)
sort date
gen oos = 1 if _n >= 311
sort cdifdeflu09
twoway (line cdifdeflu09 difdeflu09) if oos == 1, ytitle(Fraction) ylabel(, grid) xtitle(Error) xline(0, lpattern(dash)) xlabel(-3(1)4) scheme(s1mono)
sort date

* Plot errors against raw values and predictions
* SFig 27
twoway (scatter difdeflu09 cflu, sort) if oos == 1, ytitle(Error) ylabel(, grid) xtitle(CDC ILI) scheme(s1mono)
* SFig 28
twoway (scatter difdeflu09 degflu09, sort) if oos == 1, ytitle(Error) ylabel(, grid) xtitle(Estimates) scheme(s1mono)
