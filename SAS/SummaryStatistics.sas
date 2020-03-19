/*
 *
 * SummaryStatistics fur profiling data 
 *    Uses the SAS CARS training set
 *    Generates a table per Type (SUV, Hybrid,eyc)
 * Note temp table creation and  cleanup
 * 
 */

ods noproctitle;
ods graphics / imagemap=on;

proc sort data=SASHELP.CARS out=WORK.TempSorted2236;
	by Type;
run;

proc means data=WORK.TempSorted2236 chartype mean std min max n vardef=df;
	var Invoice MPG_City Weight;
	class Make;
	by Type;
run;

*****************;
*** Clean up. ***;
*****************;

proc datasets library=WORK noprint;
	delete TempSorted2236;
	run;