********************************************************************************
***** Parable of Google Flu
***** Code Author: Ryan Kennedy
***** Section: SOM Section 1 -- Regional comparison of models from main text
*****		divided by CDC region.
***** Last Modified: February 26, 2014
********************************************************************************

/*
Sources of data:
gflu -- Google Flu Trends official website (Accessed September 2013)
http://www.google.org/flutrends/us/

cflu -- Centers for Disease Control and Prevention Flu Activity and Surveillance
http://www.cdc.gov/flu/weekly/fluactivitysurv.htm

Key variables:
gflur[i] -- Google Flu Trends estimate for region i
cflur[i] -- CDC % influenza-like-illness for region i
*/

use "C:\Users\Ryan\Documents\Data\Google Flu\Replication Materials\SOM\SOM1\ParableOfGFT(SOM1Replication).dta", clear

sort date

/*
Note: All data has already been created in replication data file so results can be
easily recovered. To start from scratch, run the command:
keep date-gflur10
*/

* Convert date variable into Stata date format
generate sdate = date(date,"MDY")
label variable sdate "Stata date format"
format sdate %d
*Convert daily dates into week of year
gen sweek = wofd(sdate)
format sweek %tw
label variable sweek "Week of year"
tsset sweek, weekly

* Format GFT to match CDC data
forvalues 1/10 {
replace gflur`i' = gflur`i'/1000
}

* Generate lags for CDC data
forvalues i = 1/10 {
	gen lcdcr`i'_2 = cdcr`i'[_n-2]
	gen lcdcr`i'_3 = cdcr`i'[_n-3]
	gen lcdcr`i'_4 = cdcr`i'[_n-4]
}

* Generate lags for difference b/t CDC and GFT data
forvalues i = 1/10 {
	gen dif`i' = gflur`i' - cdcr`i'
	gen dif`i'2 = dif`i'*dif`i'
	gen adif`i' = abs(dif`i')
}
forvalues i = 1/10 {
	gen ldif`i'_2 = dif`i'[_n-2]
	gen ldif`i'_3 = dif`i'[_n-3]
}

* Calculate RMSE and MAE for GFT (STab 1, Col 1)
forvalues i = 1/10 {
	sum dif`i'2
	display sqrt(r(mean))
	sum adif`i'
}
* Calculate RMSE and MAE for GFT post-9/6/09 (STab 2, Col 1)
forvalues i = 1/10 {
	sum dif`i'2 if _n >= 311
	display sqrt(r(mean))
	sum adif`i' if _n >= 311
}
* Calculate RMSE and MAE for GFT post-7/3/11 (STab 3, Col 1)
forvalues i = 1/10 {
	sum dif`i'2 if _n >= 406
	display sqrt(r(mean))
	sum adif`i' if _n >= 406
}

* Create week of year variable for seasonality analysis
generate week=week(dofw(sweek))
label variable week "Week of year, 1-52"

**** Run alternative models, post-July 2011 out-of-sample
* Replicate lag and seasonality analysis by Region
forvalues j = 1/10 {
	reg cdcr`j' lcdcr`j'_2 lcdcr`j'_3 lcdcr`j'_4 b52.week if _n < 406
	predict dlscdchat`j'
	forvalues i = 407/519 {
		reg cdcr`j' lcdcr`j'_2 lcdcr`j'_3 lcdcr`j'_4 b52.week if _n < `i'
		predict tdlscdchat
		replace dlscdchat`j' = tdlscdchat if _n == `i'
		drop tdlscdchat
	}
	gen dlscdcdif`j' = dlscdchat`j' - cdcr`j'
	gen dlscdcdif`j'2 = dlscdcdif`j'*dlscdcdif`j'
	gen adlscdcdif`j' = abs(dlscdcdif`j')
}

* Calculate RMSE and MAE for Lags and Seasonality (STab 1, Col 2)
forvalues i = 1/10 {
	sum dlscdcdif`i'2
	display sqrt(r(mean))
	sum adlscdcdif`i'
}
* Calculate RMSE and MAE for Lags and Seasonality (post-July 2011) (STab 3, Col 2)
forvalues i = 1/10 {
	sum dlscdcdif`i'2 if _n >= 406
	display sqrt(r(mean))
	sum adlscdcdif`i' if _n >= 406
}

* Replicate GFT plus lag and seasonality analysis by Region
forvalues j = 1/10 {
	reg cdcr`j' gflur`j' lcdcr`j'_2 ldif`j'_2 ldif`j'_3 b52.week if _n < 406
	predict degfluhat`j'
	forvalues i = 407/519 {
		reg cdcr`j' gflur`j' lcdcr`j'_2 ldif`j'_2 ldif`j'_3 b52.week if _n < `i'
		predict tegfluhat
		replace degfluhat`j' = tegfluhat if _n == `i'
		drop tegfluhat
	}
	gen degfludif`j' = degfluhat`j' - cdcr`j'
	gen degfludif`j'2 = degfludif`j'*degfludif`j'
	gen adegfludif`j' = abs(degfludif`j')
}
* Calculate RMSE and MAE for GFT plus Lags and Seasonality (STab 1, Col 3)
forvalues i = 1/10 {
	sum degfludif`i'2
	display sqrt(r(mean))
	sum adegfludif`i'
}
* Calculate RMSE and MAE for GFT plus Lags and Seasonality (post-July 2011) (STab 3, Col 3)
forvalues i = 1/10 {
	sum degfludif`i'2 if _n >= 406
	display sqrt(r(mean))
	sum adegfludif`i' if _n >= 406
}

**** Do the same things for post-September 2009
* Replicate lag and seasonality analysis by Region
forvalues j = 1/10 {
	reg cdcr`j' lcdcr`j'_2 lcdcr`j'_3 lcdcr`j'_4 b52.week if _n < 311
	predict dlscdc09`j'
	forvalues i = 312/519 {
		reg cdcr`j' lcdcr`j'_2 lcdcr`j'_3 lcdcr`j'_4 b52.week if _n < `i'
		predict tdlscdc09
		replace dlscdc09`j' = tdlscdc09 if _n == `i'
		drop tdlscdc09
	}
	gen dlscdcd09`j' = dlscdc09`j' - cdcr`j'
	gen dlscdcd09`j'2 = dlscdcd09`j'*dlscdcd09`j'
	gen adlscdcd09`j' = abs(dlscdcd09`j')
}

* Calculate RMSE and MAE for Lags and Seasonality (STab 1, Col 4)
forvalues i = 1/10 {
	sum dlscdcd09`i'2
	display sqrt(r(mean))
	sum adlscdcd09`i'
}
* Calculate RMSE and MAE for Lags and Seasonality (post-September 2009) (STab 2, Col 2)
forvalues i = 1/10 {
	sum dlscdcd09`i'2 if _n >= 311
	display sqrt(r(mean))
	sum adlscdcd09`i' if _n >= 311
}

* Replicate GFT plus lag and seasonality analysis by Region
forvalues j = 1/10 {
	reg cdcr`j' gflur`j' lcdcr`j'_2 ldif`j'_2 ldif`j'_3 b52.week if _n < 311
	predict degflu09`j'
	forvalues i = 312/519 {
		reg cdcr`j' gflur`j' lcdcr`j'_2 ldif`j'_2 ldif`j'_3 b52.week if _n < `i'
		predict tegflu09
		replace degflu09`j' = tegflu09 if _n == `i'
		drop tegflu09
	}
	gen degflud09`j' = degflu09`j' - cdcr`j'
	gen degflud09`j'2 = degflud09`j'*degflud09`j'
	gen adegflud09`j' = abs(degflud09`j')
}
* Calculate RMSE and MAE for GFT, Lags and Seasonality (STab 1, Col 5)
forvalues i = 1/10 {
	sum degflud09`i'2
	display sqrt(r(mean))
	sum adegflud09`i'
}
* Calculate RMSE and MAE for GFT, Lags and Seasonality (post-September 2009) (STab 2, Col 3)
forvalues i = 1/10 {
	sum degflud09`i'2 if _n >= 311
	display sqrt(r(mean))
	sum adegflud09`i' if _n >= 311
}



