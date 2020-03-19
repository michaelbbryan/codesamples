/*
 *
 * See OneWayANOVA example
 * This alternative uses wilcoxon scores for a "nonparametric" solution
 *
 */

ods noproctitle;

proc npar1way data=SASHELP.CARS wilcoxon plots(only)=(wilcoxonboxplot);
	class Type;
	var MSRP;
run;