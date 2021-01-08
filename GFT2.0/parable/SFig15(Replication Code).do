********************************************************************************
***** Parable of Google Flu
***** Code Author: Ryan Kennedy
***** Sections: SOM Section 4 (Fig S15)
***** Last Modified: February 28, 2014
********************************************************************************

use "C:\Users\Ryan\Documents\Data\Google Flu\Replication Materials\SOM\SOM4\FigS15\SFig15.dta", clear

* Generate time variable
* Note: We have already taken this step in the Stata replication data version
* Go straight to graphing commands or drop sdate if you wish to replicate this step.
generate sdate = date(week,"MDY")
label variable sdate "Time"
format sdate %d

*Fig S15: Graph each of the five search terms from teh PLOS One article separately
twoway (line amoxicillin sdate, lcolor(cyan) lwidth(thick)) (lowess amoxicillin sdate, lcolor(yellow) lwidth(thick)), scheme(s1color) xsize(10) ysize(5) xtitle(Time) xlabel(#3, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))
twoway (line earlysignsoftheflu sdate, lcolor(cyan) lwidth(thick)) (lowess earlysignsoftheflu sdate, lcolor(yellow) lwidth(thick)), scheme(s1color) xsize(10) ysize(5) xtitle(Time) xlabel(#3, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))
twoway (line fever sdate, lcolor(cyan) lwidth(thick)) (lowess fever sdate, lcolor(yellow) lwidth(thick)), scheme(s1color) xsize(10) ysize(5) xtitle(Time) xlabel(#3, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))
twoway (line influenzaa sdate, lcolor(cyan) lwidth(thick)) (lowess influenzaa sdate, lcolor(yellow) lwidth(thick)), scheme(s1color) xsize(10) ysize(5) xtitle(Time) xlabel(#3, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))
twoway (line pnumonia sdate, lcolor(cyan) lwidth(thick)) (lowess pnumonia sdate, lcolor(yellow) lwidth(thick)), scheme(s1color) xsize(10) ysize(5) xtitle(Time) xlabel(#3, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))
twoway (line robitussin sdate, lcolor(cyan) lwidth(thick)) (lowess robitussin sdate, lcolor(yellow) lwidth(thick)), scheme(s1color) xsize(10) ysize(5) xtitle(Time) xlabel(#3, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))
twoway (line strepthroat sdate, lcolor(cyan) lwidth(thick)) (lowess strepthroat sdate, lcolor(yellow) lwidth(thick)), scheme(s1color) xsize(10) ysize(5) xtitle(Time) xlabel(#3, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))
twoway (line symptomsofbronchitis sdate, lcolor(cyan) lwidth(thick)) (lowess symptomsofbronchitis sdate, lcolor(yellow) lwidth(thick)), scheme(s1color) xsize(10) ysize(5) xtitle(Time) xlabel(#3, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))
