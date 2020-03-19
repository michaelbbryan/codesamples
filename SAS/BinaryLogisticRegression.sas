/*
 *
 * Binary aka Logistic Regression
 * This example uses a binary dependent of "MPG=26"
 * and applies logit method  
 *
 */

ods noproctitle;
ods graphics / imagemap=on;

proc logistic data=SASHELP.CARS;
	model MPG_Highway(event='26')=Weight MSRP / link=logit technique=fisher;
run;