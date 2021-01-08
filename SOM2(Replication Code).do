********************************************************************************
***** Parable of Google Flu
***** Code Author: Ryan Kennedy
***** Sections: SOM Section 2
***** Last Modified: February 26, 2014
********************************************************************************

/*
Note: This section uses the data already created in the main replication file (see main
document section of replication materials).
*/

use "C:\Users\Ryan\Documents\Data\Google Flu\Replication Materials\Manuscript\ParableOfGFT(Replication).dta", clear

* Figures for SOM Section 2 -- ACF and PACF Plots
tsset swweekly, weekly
* SFig1: Correlogram of CDC Flu data
ac cflu, ytitle(Autocorrelations of CDC % ILI) scheme(s1mono)
* SFig2: Partial Correlogram of CDC flu data
pac cflu, ytitle(Partial Autocorrelations of CDC % ILI) scheme(s1mono)
* SFig3: Correlogram of Google Flu error
ac dif, ytitle(Autocorrelations of Google Flu Error) scheme(s1mono)
