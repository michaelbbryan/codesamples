/*
 *
 * This model predicts MPG using Price and Weight
 *
 */

ods noproctitle;
ods graphics / imagemap=on;

proc glmselect data=SASHELP.CARS plots=(criterionpanel);
	model MPG_Highway=MSRP Weight / selection=stepwise
(select=sbc) hierarchy=single;
run;