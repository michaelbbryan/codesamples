/*
 *
 * Gen Linear Models allow for distribution assumptions beyond
 * normal(gaussian) to Binomial, Poisson, etc.
 *
 */

ods noproctitle;
ods graphics / imagemap=on;

proc genmod data=SASHELP.CARS plots=(predicted resraw(index) stdreschi(index) );
	class Make Type / param=glm;
	model MSRP= / dist=poisson;
run;