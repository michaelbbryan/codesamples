/*
 *  Two Sided T Test and evaluating normal assumption
 *
 *  Code to assess 
 *     whether data appears normally distrib - the univariate procedure
 *     whether me is stat diff than a set h0 (here is 300)
 *  Generates tables and plots
 */

ods noproctitle;
ods graphics / imagemap=on;

**************************;
*** Test for normality ***;
**************************;

proc univariate data=SASHELP.CARS normal mu0=300;
	ods select TestsForNormality;
	var Horsepower;
run;

**************************;
*** t Test ***;
**************************;

proc ttest data=SASHELP.CARS sides=2 h0=300 plots(only showh0)=(summaryPlot 
		qqplot);
	var Horsepower;
run;