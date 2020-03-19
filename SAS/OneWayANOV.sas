/*
 *
 * OneWayAnova
 * For a dependent, continuous variable
 * calculates the variation attributable to a single categorical variable
 * Results include F stat, variation, mean squared error and P(>alpha)
 * Here the SAS training set is used with
 *     MSRP = price
 *     Type = (truck,suv,hybrid, etc)
 */

Title;
ods noproctitle;
ods graphics / imagemap=on;
**************************;
*** ANOVA ***;
**************************;

proc glm data=SASHELP.CARS;
	class Type;
	model MSRP=Type;
	means Type / hovtest=levene welch plots=none;
	lsmeans Type / adjust=tukey pdiff alpha=.05;
	run;
quit;