/*
 *
 *  Distribution analysis 
 *  To assess "Normal assumption" or visually identify a better pdf
 *
 */

ods noproctitle;
ods graphics / imagemap=on;

proc univariate data=SASHELP.CARS;
	ods select Histogram;
	***;
	*** Exploring Data ***;
	***;
	var MPG_Highway MSRP Weight Horsepower;
	histogram MPG_Highway MSRP Weight Horsepower;
	inset n / position=ne;
run;