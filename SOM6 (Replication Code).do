********************************************************************************
***** Parable of Google Flu
***** Code Author: Ryan Kennedy
***** Sections: SOM Section 6
***** Last Modified: February 26, 2014
********************************************************************************


*** Model using only 3 and 4 week lags of CDC data to account for data vintaging
* SOM section 6
use "C:\Users\Ryan\Documents\Data\Google Flu\Replication Materials\Manuscript\ParableOfGFT(Replication).dta", clear

/*
All the necessary variable have already been created in the included data file. To create
all variables from scratch, see replication code for main paper.
*/

* Dynamic prediction with lag-only model -- starting in September 2009
* Using only 3-week and beyond lags
reg cflu lcflu3 lcflu4 lcflu5 b52.week if _n < 311
predict dlscflul3
forvalues i = 312/519 {
	reg cflu lcflu3 lcflu4 lcflu5 b52.week if _n < `i'
	predict tdlscflul3
	replace dlscflul3 = tdlscflul3 if _n == `i'
	drop tdlscflul3
}
label variable dlscflul3 "Lags and Seasonality"
* Calculate error relative to CDC data
gen difdcflul3 = dlscflul3-cflu
label variable difdcflul3 "Lag and Seasonality Model Error"
* Calculate out-of-sample RMSE
gen difdcflul32 = difdcflul3 * difdcflul3
sum difdcflul32 if _n >= 311
display sqrt(r(mean))
* Calculate out-of-sample mean absolute error
gen adifdcflul3 = abs(difdcflul3)
sum adifdcflul3 if _n >= 311
* Dynamic prediction with extended Google Flu model -- starting in Sept. 2009
reg cflu gflu lcflu3 lcflu4 dif_3 b52.week if _n < 311
predict degflul3
forvalues i = 312/519 {
	reg cflu gflu lcflu3 lcflu4 dif_3 b52.week if _n < `i'
	predict tegflul3
	replace degflul3 = tegflul3 if _n == `i'
	drop tegflul3
}
label variable degflul3 "GFT, Lags and Seasonality"
* Compare the above with the Google Flu performance
gen difdeflul3 = degflul3-cflu
label variable difdeflul3 "GFT Plus Lag and Seasonality Error"
* Calculate out-of-sample RMSE
gen difdeflul32 = difdeflul3*difdeflul3
sum difdeflul32 if _n >= 311
display sqrt(r(mean))
* Calculate out-of-sample mean absolute error
gen adifdeflul3 = abs(difdeflul3)
sum adifdeflul3 if _n >= 311

