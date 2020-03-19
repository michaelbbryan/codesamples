/*
 *
 * NWayANOVA takes multiple categorical vars (NWay)
 * It needs the order (nested) of the categories - so
 * this model shows DriveTrain within Type within Make
 *
 */

ods noproctitle;
ods graphics / imagemap=on;

proc glm data=SASHELP.CARS;
	class Make Type DriveTrain;
	model MSRP=Make(Type) / ss1 ss3;
	lsmeans / adjust=tukey pdiff=all alpha=0.05 cl;
quit;