/*
 *
 * Correlation of of one var (col)
 *  against several (rows) using Pearon coefficient
 *
 */

ods noproctitle;
ods graphics / imagemap=on;

proc corr data=SASHELP.CARS pearson nosimple noprob plots=none;
	var Invoice;
	with Weight MPG_Highway Length;
run;