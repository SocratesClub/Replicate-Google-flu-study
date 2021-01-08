********************************************************************************
***** Parable of Google Flu
***** Code Author: Ryan Kennedy
***** Sections: SOM Section 4 (Fig. S17)
***** Last Modified: February 26, 2014
********************************************************************************

use "C:\Users\Ryan\Documents\Data\Google Flu\Replication Materials\SOM\SOM4\FigS17\Fig17data.dta", clear

* Formatted date value already generated in replication data.
* Skip to graphing commands or drop sdate.
generate sdate = date(week,"MDY")
label variable sdate "Time"
format sdate %d

* Graph top correlates to CDC data to show where went wrong
twoway (line cdcflu sdate, lcolor(cyan) lwidth(thick)) (line influenzatypea sdate, lcolor(magenta) lwidth(thick)), ytitle(% ILI/Search Prevalence, size(large)) xtitle(Time) scheme(s1color) xsize(10) ysize(5) xlabel(#3, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))
twoway (line cdcflu sdate, lcolor(cyan) lwidth(thick)) (line fluduration sdate, lcolor(magenta) lwidth(thick)), ytitle(% ILI/Search Prevalence, size(large)) xtitle(Time) scheme(s1color) xsize(10) ysize(5) xlabel(#3, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))
twoway (line cdcflu sdate, lcolor(cyan) lwidth(thick)) (line flufever sdate, lcolor(magenta) lwidth(thick)), ytitle(% ILI/Search Prevalence, size(large)) xtitle(Time) scheme(s1color) xsize(10) ysize(5) xlabel(#3, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))
twoway (line cdcflu sdate, lcolor(cyan) lwidth(thick)) (line treatingflu sdate, lcolor(magenta) lwidth(thick)), ytitle(% ILI/Search Prevalence, size(large)) xtitle(Time) scheme(s1color) xsize(10) ysize(5) xlabel(#3, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))
twoway (line cdcflu sdate, lcolor(cyan) lwidth(thick)) (line braunthermoscan sdate, lcolor(magenta) lwidth(thick)), ytitle(% ILI/Search Prevalence, size(large)) xtitle(Time) scheme(s1color) xsize(10) ysize(5) xlabel(#3, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))
twoway (line cdcflu sdate, lcolor(cyan) lwidth(thick)) (line feverflu sdate, lcolor(magenta) lwidth(thick)), ytitle(% ILI/Search Prevalence, size(large)) xtitle(Time) scheme(s1color) xsize(10) ysize(5) xlabel(#3, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))
twoway (line cdcflu sdate, lcolor(cyan) lwidth(thick)) (line flurecovery sdate, lcolor(magenta) lwidth(thick)), ytitle(% ILI/Search Prevalence, size(large)) xtitle(Time) scheme(s1color) xsize(10) ysize(5) xlabel(#3, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))
twoway (line cdcflu sdate, lcolor(cyan) lwidth(thick)) (line fluvscold sdate, lcolor(magenta) lwidth(thick)), ytitle(% ILI/Search Prevalence, size(large)) xtitle(Time) scheme(s1color) xsize(10) ysize(5) xlabel(#3, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))
twoway (line cdcflu sdate, lcolor(cyan) lwidth(thick)) (line coldorflu sdate, lcolor(magenta) lwidth(thick)), ytitle(% ILI/Search Prevalence, size(large)) xtitle(Time) scheme(s1color) xsize(10) ysize(5) xlabel(#3, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))
twoway (line cdcflu sdate, lcolor(cyan) lwidth(thick)) (line treatingtheflu sdate, lcolor(magenta) lwidth(thick)), ytitle(% ILI/Search Prevalence, size(large)) xtitle(Time) scheme(s1color) xsize(10) ysize(5) xlabel(#3, labsize(medlarge)) ylabel(,labsize(medlarge) angle(horizontal)) legend(size(vlarge))
