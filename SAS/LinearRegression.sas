/*
 *
 * Linear regression with all continuous variables
 * MSRP ~ intercept Weight MPG  
 *
 */
 
ods noproctitle;
ods graphics / imagemap=on;

proc reg data=SASHELP.CARS alpha=0.05 plots(only)=(diagnostics residuals 
		observedbypredicted);
	model MSRP=Weight MPG_Highway /;
	run;
quit;