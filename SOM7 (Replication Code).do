********************************************************************************
***** Parable of Google Flu
***** Code Author: Ryan Kennedy
***** Sections: SOM Section 7
***** Last Modified: February 26, 2014
********************************************************************************

/*
Note: This section uses the data already created in the main replication file (see main
document section of replication materials). Values of RMSE and MAE are calculated in the
main document. Below are the significance tests reported in Section 7 of the SM.
*/
use "C:\Users\Ryan\Documents\Data\Google Flu\Replication Materials\Manuscript\ParableOfGFT(Replication).dta", clear

*** Sign test for out-of-sample absolute forecasting error (Fig 2 and SOM section 7)
* equation 1 -- absdif -- presented in manuscript
* equation 2 -- s3adifdcflu09
* equation 3 -- s3adifdeflu09
* equation 4 -- s2adifdcflu09
* equation 5 -- s1adifdcflu09
* equation 6 -- adifdcflu09 -- presented in manuscript
* equation 7 -- s2adifdeflu09
* equation 8 -- s1adifdeflu09
* equation 9 -- adifdeflu09 -- presented in manuscript

signtest absdif = s3adifdcflu09 if _n >= 311
signtest absdif = s3adifdeflu09 if _n >= 311
signtest absdif = s2adifdcflu09 if _n >= 311
signtest absdif = s1adifdcflu09 if _n >= 311
signtest absdif = adifdcflu09 if _n >= 311
signtest absdif = s2adifdeflu09 if _n >= 311
signtest absdif = s1adifdeflu09 if _n >= 311
signtest absdif = adifdeflu09 if _n >= 311

signtest s3adifdcflu09 = s3adifdeflu09 if _n >= 311
signtest s3adifdcflu09 = s2adifdcflu09 if _n >= 311
signtest s3adifdcflu09 = s1adifdcflu09 if _n >= 311
signtest s3adifdcflu09 = adifdcflu09 if _n >= 311
signtest s3adifdcflu09 = s2adifdeflu09 if _n >= 311
signtest s3adifdcflu09 = s1adifdeflu09 if _n >= 311
signtest s3adifdcflu09 = adifdeflu09 if _n >= 311

signtest s3adifdeflu09 = s2adifdcflu09 if _n >= 311
signtest s3adifdeflu09 = s1adifdcflu09 if _n >= 311
signtest s3adifdeflu09 = adifdcflu09 if _n >= 311
signtest s3adifdeflu09 = s2adifdeflu09 if _n >= 311
signtest s3adifdeflu09 = s1adifdeflu09 if _n >= 311
signtest s3adifdeflu09 = adifdeflu09 if _n >= 311

signtest s2adifdcflu09 = s1adifdcflu09 if _n >= 311
signtest s2adifdcflu09 = adifdcflu09 if _n >= 311
signtest s2adifdcflu09 = s2adifdeflu09 if _n >= 311
signtest s2adifdcflu09 = s1adifdeflu09 if _n >= 311
signtest s2adifdcflu09 = adifdeflu09 if _n >= 311

signtest s1adifdcflu09 = adifdcflu09 if _n >= 311
signtest s1adifdcflu09 = s2adifdeflu09 if _n >= 311
signtest s1adifdcflu09 = s1adifdeflu09 if _n >= 311
signtest s1adifdcflu09 = adifdeflu09 if _n >= 311

signtest adifdcflu09 = s2adifdeflu09 if _n >= 311
signtest adifdcflu09 = s1adifdeflu09 if _n >= 311
signtest adifdcflu09 = adifdeflu09 if _n >= 311

signtest s2adifdeflu09 = s1adifdeflu09 if _n >= 311
signtest s2adifdeflu09 = adifdeflu09 if _n >= 311

signtest s1adifdeflu09 = adifdeflu09 if _n >= 311

*** F-test for significance in differences between Mean Squared Forecasting Error
* equation 1 -- dif -- prsented in manuscript
* equation 2 -- s3difdcflu09
* equation 3 -- s3difdeflu09
* equation 4 -- s2difdcflu09
* equation 5 -- s1difdcflu09
* equation 6 -- difdcflu09 -- presented in manuscript
* equation 7 -- s2difdeflu09
* equation 8 -- s1difdeflu09
* equation 9 -- difdeflu09 -- presented in manuscript

gen r1c1neg = dif - s3difdcflu09
gen r1c1pos = dif + s3difdcflu09
reg r1c1neg r1c1pos if _n >= 311
gen r1c2neg = dif - s3difdeflu09
gen r1c2pos = dif + s3difdeflu09
reg r1c2neg r1c2pos if _n >= 311
gen r1c3neg = dif - s2difdcflu09
gen r1c3pos = dif + s2difdcflu09
reg r1c3neg r1c3pos if _n >= 311
gen r1c4neg = dif - s1difdcflu09
gen r1c4pos = dif + s1difdcflu09
reg r1c4neg r1c4pos if _n >= 311
gen r1c5neg = dif - difdcflu09
gen r1c5pos = dif + difdcflu09
reg r1c5neg r1c5pos if _n >= 311
gen r1c6neg = dif - s2difdeflu09
gen r1c6pos = dif + s2difdeflu09
reg r1c6neg r1c6pos if _n >= 311
gen r1c7neg = dif - s1difdeflu09
gen r1c7pos = dif + s1difdeflu09
reg r1c7neg r1c7pos if _n >= 311
gen r1c8neg = dif - difdeflu09
gen r1c8pos = dif + difdeflu09
reg r1c8neg r1c8pos if _n >= 311

gen r2c1neg = s3difdcflu09 - s3difdeflu09
gen r2c1pos = s3difdcflu09 + s3difdeflu09
reg r2c1neg r2c1pos if _n >= 311
gen r2c2neg = s3difdcflu09 - s2difdcflu09
gen r2c2pos = s3difdcflu09 + s2difdcflu09
reg r2c2neg r2c2pos if _n >= 311
gen r2c3neg = s3difdcflu09 - s1difdcflu09
gen r2c3pos = s3difdcflu09 + s1difdcflu09
reg r2c3neg r2c3pos if _n >= 311
gen r2c4neg = s3difdcflu09 - difdcflu09
gen r2c4pos = s3difdcflu09 + difdcflu09
reg r2c4neg r2c4pos if _n >= 311
gen r2c5neg = s3difdcflu09 - s2difdeflu09
gen r2c5pos = s3difdcflu09 + s2difdeflu09
reg r2c5neg r2c5pos if _n >= 311
gen r2c6neg = s3difdcflu09 - s1difdeflu09
gen r2c6pos = s3difdcflu09 + s1difdeflu09
reg r2c6neg r2c6pos if _n >= 311
gen r2c7neg = s3difdcflu09 - difdeflu09
gen r2c7pos = s3difdcflu09 + difdeflu09
reg r2c7neg r2c7pos if _n >= 311

gen r3c1neg = s3difdeflu09 - s2difdcflu09
gen r3c1pos = s3difdeflu09 + s2difdcflu09
reg r3c1neg r3c1pos if _n >= 311
gen r3c2neg = s3difdeflu09 - s1difdcflu09
gen r3c2pos = s3difdeflu09 + s1difdcflu09
reg r3c2neg r3c2pos if _n >= 311
gen r3c3neg = s3difdeflu09 - difdcflu09
gen r3c3pos = s3difdeflu09 + difdcflu09
reg r3c3neg r3c3pos if _n >= 311
gen r3c4neg = s3difdeflu09 - s2difdeflu09
gen r3c4pos = s3difdeflu09 + s2difdeflu09
reg r3c4neg r3c4pos if _n >= 311
gen r3c5neg = s3difdeflu09 - s1difdeflu09
gen r3c5pos = s3difdeflu09 + s1difdeflu09
reg r3c5neg r3c5pos if _n >= 311
gen r3c6neg = s3difdeflu09 - difdeflu09
gen r3c6pos = s3difdeflu09 + difdeflu09
reg r3c6neg r3c6pos if _n >= 311

gen r4c1neg = s2difdcflu09 - s1difdcflu09
gen r4c1pos = s2difdcflu09 + s1difdcflu09
reg r4c1neg r4c1pos if _n >= 311
gen r4c2neg = s2difdcflu09 - difdcflu09
gen r4c2pos = s2difdcflu09 + difdcflu09
reg r4c2neg r4c2pos if _n >= 311
gen r4c3neg = s2difdcflu09 - s2difdeflu09
gen r4c3pos = s2difdcflu09 + s2difdeflu09
reg r4c3neg r4c3pos if _n >= 311
gen r4c4neg = s2difdcflu09 - s1difdeflu09
gen r4c4pos = s2difdcflu09 + s1difdeflu09
reg r4c4neg r4c4pos if _n >= 311
gen r4c5neg = s2difdcflu09 - difdeflu09
gen r4c5pos = s2difdcflu09 + difdeflu09
reg r4c5neg r4c5pos if _n >= 311

gen r5c1neg = s1difdcflu09 - difdcflu09
gen r5c1pos = s1difdcflu09 + difdcflu09
reg r5c1neg r5c1pos if _n >= 311
gen r5c2neg = s1difdcflu09 - s2difdeflu09
gen r5c2pos = s1difdcflu09 + s2difdeflu09
reg r5c2neg r5c2pos if _n >= 311
gen r5c3neg = s1difdcflu09 - s1difdeflu09
gen r5c3pos = s1difdcflu09 + s1difdeflu09
reg r5c3neg r5c3pos if _n >= 311
gen r5c4neg = s1difdcflu09 - difdeflu09
gen r5c4pos = s1difdcflu09 + difdeflu09
reg r5c4neg r5c4pos if _n >= 311

gen r6c1neg = difdcflu09 - s2difdeflu09
gen r6c1pos = difdcflu09 + s2difdeflu09
reg r6c1neg r6c1pos if _n >= 311
gen r6c2neg = difdcflu09 - s1difdeflu09
gen r6c2pos = difdcflu09 + s1difdeflu09
reg r6c2neg r6c2pos if _n >= 311
gen r6c3neg = difdcflu09 - difdeflu09
gen r6c3pos = difdcflu09 + difdeflu09
reg r6c3neg r6c3pos if _n >= 311

gen r7c1neg = s2difdeflu09 - s1difdeflu09
gen r7c1pos = s2difdeflu09 + s1difdeflu09
reg r7c1neg r7c1pos if _n >= 311
gen r7c2neg = s2difdeflu09 - difdeflu09
gen r7c2pos = s2difdeflu09 + difdeflu09
reg r7c2neg r7c2pos if _n >= 311

gen r8c1neg = s1difdeflu09 - difdeflu09
gen r8c1pos = s1difdeflu09 + difdeflu09
reg r8c1neg r8c1pos if _n >= 311

