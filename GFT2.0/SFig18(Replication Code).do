********************************************************************************
***** Parable of Google Flu
***** Code Author: Ryan Kennedy
***** Sections: SOM Section 4 (Fig. S18)
***** Last Modified: February 26, 2014
********************************************************************************

use "C:\Users\Ryan\Documents\Data\Google Flu\Replication Materials\SOM\SOM4\FigS18\SFig18.dta", clear

* Formatted date value already generated in replication data.
* Skip to graphing commands or drop sdate.
generate sdate = date(week,"MDY")
label variable sdate "Time"
format sdate %d

* Graph relative frequency of search terms from Google's PLOS One article
twoway (line symptomsofbronchitis sdate) (connected pnumonia sdate) (line fever sdate) (line earlysignsoftheflu sdate) (line robitussin sdate) (line influenzaa sdate) (line amoxicillin sdate) (line strepthroat sdate), scheme(s1color) xsize(10) ysize(5)
