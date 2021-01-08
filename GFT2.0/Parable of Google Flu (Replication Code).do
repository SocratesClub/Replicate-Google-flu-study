********************************************************************************
***** Parable of Google Flu
***** Code Author: Ryan Kennedy
***** Sections: Main Article Text & SOM section 7 RMSE and MAE estimates
***** Last Modified: February 26, 2014
********************************************************************************

/*
Sources of data:
gflu -- Google Flu Trends official website (Accessed September 2013)
http://www.google.org/flutrends/us/

cflu -- Centers for Disease Control and Prevention Flu Activity and Surveillance
http://www.cdc.gov/flu/weekly/fluactivitysurv.htm
*/

* Open file
/* 
Note: Replication file has already created all necessary variables, so you can skip directly to
creating the charts and viewing the results. If you would like to begin from scratch, you can run:
keep date gflu source1 cflu source2
As noted below, we also recommend keeping the time variables: sweek, swweekly, and week.
*/
use "C:\Users\Ryan\Documents\Data\Google Flu\Replication Materials\Manuscript\ParableOfGFT(Replication).dta", clear

sort date

* Create difference between GFT estimate and CDC estimate
gen dif = gflu-cflu
label variable dif "Difference Between Google Flu and CDC"
* Create proportional difference between GFT and CDC estimate
gen pdif = (gflu-cflu)/cflu
label variable pdif "Proportional Difference Between Google Flu and CDC"

* Set up dates in Stata date format -- weekly data
gen sweek = date(date, "YMD")
format sweek %d
label variable sweek "Date in Stata format"
* Convert date format to weekly
gen swweekly = wofd(sweek)
format swweekly %tw
label variable swweekly "Date in week of year format"
* Pull out number of week for seasonality analysis
gen week = week(sweek)
label variable week "Number of the week in the year"
/* 
Note: week variable has to be manually corrected to deal with 52 week base year in Stata.
Two years in this data had 53 weeks. This is done to allow for autocorrelation diagnostics 
and does not affect our results beyond marginally weakening the estimated seasonal effects.
For easiest replication, if starting from scratch, we argue for keeping the week variables
as currently formatted.
*/

* Generate two and three week lag of CDC flu data as baseline for comparison
gen lcflu = cflu[_n-2]
label variable lcflu "2-week lag of CDC flu data"
gen lcflu3 = cflu[_n-3]
label variable lcflu3 "3-week lag of CDC flu data"
gen lcflu4 = cflu[_n-4]
label variable lcflu4 "4-week lag of CDC flu data"
gen lcflu5 = cflu[_n-5]
label variable lcflu5 "5-week lag of CDC flu data"

* Generate two and three week lag of difference between GFT and CDC data
gen dif_2 = dif[_n-2]
label variable dif_2 "2-week lag of difference between GFT and CDC data"
gen dif_3 = dif[_n-3]
label variable dif_3 "3-week lag of difference between GFT and CDC data"

* Generation of chart comparing GFT to CDC data
twoway (line gflu sweek, lcolor(magenta) lwidth(thick)) (line cflu sweek, lcolor(cyan) lwidth(thick)) if _n >= 306, ytitle(% Visits for ILI, size(large)) xtitle(Time) scheme(s1color) xsize(10) ysize(5) xlabel(#6, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))

* Generation of chart plotting proportional error (GFT-CDC)/CDC for GFT over period analyzed
* with LOESS smoothing line to show trend.
twoway (line pdif sweek, lcolor(magenta) lwidth(thick)) (lowess pdif sweek, bwidth(0.5) lwidth(thick) lcolor(yellow)) if _n >= 306, ytitle(Scale of Google Flu Error, size(large)) yline(0, lcolor(black)) xtitle(Time) scheme(s1color) xsize(10) ysize(5) xlabel(#6, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))


*** Alternative models, labeled according to SM part 7

* Calculate RMSE for GFT versus CDC in out-of-sample period
* Out-of-sample starts September 2009, when update was released
gen dif2 = dif*dif
sum dif2 if _n >= 311
display sqrt(r(mean))
* Calculate mean absolute error for GFT versus CDC in out-of-sample period
gen absdif = abs(dif)
sum absdif if _n >= 311

* Equation 2
* Dynamic prediction with lag-only model -- starting in September 2009
* Only using one of the lag terms and removing seasonality
reg cflu lcflu if _n < 311
predict s3dlscflu09
forvalues i = 312/519 {
	reg cflu lcflu if _n < `i'
	predict tdlscflu09
	replace s3dlscflu09 = tdlscflu09 if _n == `i'
	drop tdlscflu09
}
label variable s3dlscflu09 "Lags and Seasonality"
* Calculate error relative to CDC data
gen s3difdcflu09 = s3dlscflu09-cflu
label variable s3difdcflu09 "Lag Model Error"
* Calculate out-of-sample RMSE
gen s3difdcflu092 = s3difdcflu09 * s3difdcflu09
sum s3difdcflu092 if _n >= 311
display sqrt(r(mean))
*Calculate out-of-sample mean absolute error
gen s3adifdcflu09 = abs(s3difdcflu09)
sum s3adifdcflu09 if _n >= 311

* Equation 3
* Dynamic prediction with extended Google Flu model -- starting in Sept. 2009
* Removing one of the difference terms and the lag term and seasonality
reg cflu gflu dif_2 if _n < 311
predict s3degflu09
forvalues i = 312/519 {
	reg cflu gflu dif_2 if _n < `i'
	predict tegflu09
	replace s3degflu09 = tegflu09 if _n == `i'
	drop tegflu09
}
label variable s3degflu09 "GFT, Lags and Seasonality"
* Calculate error relative to CDC data
gen s3difdeflu09 = s3degflu09-cflu
label variable s3difdeflu09 "GFT Plus Lag Error"
* Calculate out-of-sample RMSE
gen s3difdeflu092 = s3difdeflu09*s3difdeflu09
sum s3difdeflu092 if _n >= 311
display sqrt(r(mean))
* Calculate out-of-sample mean absolute error
gen s3adifdeflu09 = abs(s3difdeflu09)
sum s3adifdeflu09 if _n >= 311

* Equation 4
* Dynamic prediction with lag-only model -- starting in September 2009
* Only using one of the lag terms and seasonality
reg cflu lcflu b52.week if _n < 311
predict s2dlscflu09
forvalues i = 312/519 {
	reg cflu lcflu b52.week if _n < `i'
	predict tdlscflu09
	replace s2dlscflu09 = tdlscflu09 if _n == `i'
	drop tdlscflu09
}
label variable s2dlscflu09 "Lags and Seasonality"
* Calculate error relative to CDC data
gen s2difdcflu09 = s2dlscflu09-cflu
label variable s2difdcflu09 "Lag and Seasonality Model Error"
* Calculate out-of-sample RMSE
gen s2difdcflu092 = s2difdcflu09 * s2difdcflu09
sum s2difdcflu092 if _n >= 311
display sqrt(r(mean))
* Calculate out-of-sample mean absolute error
gen s2adifdcflu09 = abs(s2difdcflu09)
sum s2adifdcflu09 if _n >= 311

* Equation 5
* Dynamic prediction with lag-only model -- starting in September 2009
* Only using two of the lag terms and seasonality
reg cflu lcflu lcflu3 b52.week if _n < 311
predict s1dlscflu09
forvalues i = 312/519 {
	reg cflu lcflu lcflu3 b52.week if _n < `i'
	predict tdlscflu09
	replace s1dlscflu09 = tdlscflu09 if _n == `i'
	drop tdlscflu09
}
label variable s1dlscflu09 "Lags and Seasonality"
* Calculate error relative to CDC data
gen s1difdcflu09 = s1dlscflu09-cflu
label variable s1difdcflu09 "Lag and Seasonality Model Error"
* Calculate out-of-sample RMSE
gen s1difdcflu092 = s1difdcflu09 * s1difdcflu09
sum s1difdcflu092 if _n >= 311
display sqrt(r(mean))
* Calculate out-of-sample mean absolute error
gen s1adifdcflu09 = abs(s1difdcflu09)
sum s1adifdcflu09 if _n >= 311

* Equation 6 -- Presented in main paper
* Dynamic prediction with lag-only model -- starting in September 2009
reg cflu lcflu lcflu3 lcflu4 b52.week if _n < 311
predict dlscflu09
forvalues i = 312/519 {
	reg cflu lcflu lcflu3 lcflu4 b52.week if _n < `i'
	predict tdlscflu09
	replace dlscflu09 = tdlscflu09 if _n == `i'
	drop tdlscflu09
}
label variable dlscflu09 "Lags and Seasonality"
*Calculate error relative to CDC data
gen difdcflu09 = dlscflu09-cflu
label variable difdcflu09 "Lag and Seasonality Model Error"
* Calculate out-of-sample RMSE
gen difdcflu092 = difdcflu09 * difdcflu09
sum difdcflu092 if _n >= 311
display sqrt(r(mean))
* Calculate out-of-sample mean absolute error
gen adifdcflu09 = abs(difdcflu09)
sum adifdcflu09 if _n >= 311

* Equation 7
* Dynamic prediction with extended Google Flu model -- starting in Sept. 2009
* Removing one of the difference terms and the lag term
reg cflu gflu dif_2 b52.week if _n < 311
predict s2degflu09
forvalues i = 312/519 {
	reg cflu gflu dif_2 b52.week if _n < `i'
	predict tegflu09
	replace s2degflu09 = tegflu09 if _n == `i'
	drop tegflu09
}
label variable s2degflu09 "GFT, Lags and Seasonality"
* Calculate error relative to CDC data
gen s2difdeflu09 = s2degflu09-cflu
label variable s2difdeflu09 "GFT Plus Lag and Seasonality Error"
* Calculate out-of-sample RMSE
gen s2difdeflu092 = s2difdeflu09*s2difdeflu09
sum s2difdeflu092 if _n >= 311
display sqrt(r(mean))
* Calculate out-of-sample mean absolute error
gen s2adifdeflu09 = abs(s2difdeflu09)
sum s2adifdeflu09 if _n >= 311

* Equation 8
* Dynamic prediction with extended Google Flu model -- starting in Sept. 2009
* Removing one of the difference terms
reg cflu gflu lcflu dif_2 b52.week if _n < 311
predict s1degflu09
forvalues i = 312/519 {
	reg cflu gflu lcflu dif_2 b52.week if _n < `i'
	predict tegflu09
	replace s1degflu09 = tegflu09 if _n == `i'
	drop tegflu09
}
label variable s1degflu09 "GFT, Lags and Seasonality"
* Calculate error relative to CDC data
gen s1difdeflu09 = s1degflu09-cflu
label variable s1difdeflu09 "GFT Plus Lag and Seasonality Error"
* Calculate out-of-sample RMSE
gen s1difdeflu092 = s1difdeflu09*s1difdeflu09
sum s1difdeflu092 if _n >= 311
display sqrt(r(mean))
* Calculate out-of-sample mean absolute error
gen s1adifdeflu09 = abs(s1difdeflu09)
sum s1adifdeflu09 if _n >= 311

* Equation 9 -- Presented in main paper
* Dynamic prediction with extended Google Flu model -- starting in Sept. 2009
reg cflu gflu lcflu dif_2 dif_3 b52.week if _n < 311
predict degflu09
forvalues i = 312/519 {
	reg cflu gflu lcflu dif_2 dif_3 b52.week if _n < `i'
	predict tegflu09
	replace degflu09 = tegflu09 if _n == `i'
	drop tegflu09
}
label variable degflu09 "GFT, Lags and Seasonality"
* Calculate error relative to CDC data
gen difdeflu09 = degflu09-cflu
label variable difdeflu09 "GFT Plus Lag and Seasonality Error"
* Calculate out-of-sample RMSE
gen difdeflu092 = difdeflu09*difdeflu09
sum difdeflu092 if _n >= 311
display sqrt(r(mean))
* Calculate out-of-sample mean absolute error
gen adifdeflu09 = abs(difdeflu09)
sum adifdeflu09 if _n >= 311


*Fig 1 of manuscript
* Top -- Comparison of GFT; CDC lags and seasonality model (equation 6); CDC, GFT, GFT error and seasonality
* model (equation 9); and the CDC reported %ILI.
twoway (line gflu sweek, lcolor(magenta) lwidth(thick)) (line dlscflu09 sweek, lcolor(yellow) lwidth(thick)) (line degflu09 sweek, lcolor(mint) lwidth(thick)) (line cflu sweek, lcolor(cyan) lwidth(thick)) if _n >= 311, ytitle(% Visits for ILI, size(large)) xtitle(Time) scheme(s1color) xsize(10) ysize(5) xlabel(#6, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))
* Comparison of the proportional errors - (estimate-CDC)/CDC - of all three models
twoway (line dif sweek, lcolor(magenta) lwidth(thick)) (line difdcflu09 sweek, lcolor(yellow) lwidth(thick)) (line difdeflu09 sweek, lcolor(mint) lwidth(thick))  if _n >= 311, ytitle(Predicted - Actual, size(large)) yline(0, lcolor(black)) xtitle(Time) scheme(s1mono) xsize(10) ysize(5) xlabel(#6, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))

