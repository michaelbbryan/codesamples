/*
 *
 * Bar chart with fequency uses classif vars or discrete, repeated numerics
 *
 */

proc freq data=SASHELP.CARS;
	tables MPG_Highway / plots=(freqplot cumfreqplot);
run;