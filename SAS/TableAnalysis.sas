/*
 *
 * Table analysis - like a pivot table with a strata or classif var as
 * row, col and cell.  The cell val represents a freq for each cell var value.
 *
 */

ods noproctitle;

proc freq data=SASHELP.CARS;
	tables  (Origin) *(Make) *(Type) / chisq nopercent norow nocol nocum 
		plots(only)=(freqplot mosaicplot);
run;