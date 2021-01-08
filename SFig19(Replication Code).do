********************************************************************************
***** Parable of Google Flu
***** Code Author: Ryan Kennedy
***** Sections: SOM Section 4 (Fig. S19)
***** Last Modified: February 26, 2014
********************************************************************************

use "C:\Users\Ryan\Documents\Data\Google Flu\Replication Materials\SOM\SOM4\FigS19\feverVsflu.dta", clear

* Formatted date value already generated in replication data.
* Skip to graphing commands or drop sdate.
generate sdate = date(week,"MDY")
label variable sdate "Time"
format sdate %d

* Graph fever relative to general searches for flu
twoway (line fever sdate) (line flu sdate), scheme(s1color) xsize(10) ysize(5)
