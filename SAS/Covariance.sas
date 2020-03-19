/*
 *
 * This demonstrates covariance with
 *   a continuous dependent variable - MSRP
 *   one categorical (Make) and one continuous (weight) indep vars
 *
 */

title;
ods noproctitle;
ods graphics / imagemap=on;

proc glm data=SASHELP.CARS;
	class Make;
	model MSRP=Make Weight Weight * Make;
	lsmeans Make / adjust=tukey pdiff alpha=.05;
quit;