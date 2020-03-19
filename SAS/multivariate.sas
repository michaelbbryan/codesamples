DATA driver;
  INFILE "C:\Users\micha\Documents\STAT 505\skill.dat";
  INPUT sex $ p1 p2 p3;
  y1=p2-p1;
  y2=p3-p2;
RUN;

/* Transposing vars to cols */
DATA skill2;
  INFILE "C:\Users\micha\Documents\STAT 505\skill.dat";
  INPUT sex $ p1 p2 p3;
  cond = 1; p=p1; output;
  cond = 2; p=p2; output;
  cond = 3; p=p3; output;
  drop p1,p2,p3;
  RUN;

/* MANOVA */
proc glm;
  class sex;
  model p1 p2 p3 = sex;
  manova h=sex m=p1+p2+p3;
  manova h=sex m=p2-p1,p3-p2;
  run;

/* Bartlett's Test of homog S */
proc discrim pool=test;
  class site;
  var al fe mg ca na;
  run;

/* Hotelling's T2 */
proc iml;
 start hotel;
 mu0={0, 0};
 one=j(nrow(x),1,1);
 ident=i(nrow(x));
 ybar=x・one/nrow(x);
 s=x・(ident-one*one・nrow(x))*x/(nrow(x)-1.0);
 print mu0 ybar;
 print s;
 t2=nrow(x)*(ybar-mu0)・inv(s)*(ybar-mu0);
 f=(nrow(x)-ncol(x))*t2/ncol(x)/(nrow(x)-1);
 df1=ncol(x);
 df2=nrow(x)-ncol(x);
 p=1-probf(f,df1,df2);
 print t2 f df1 df2 p;
 finish;
 use driver;
 read all var{y1 y2} into x;
 run hotel;
/* Hotelling Revised for non-equal covariance matrices */
proc iml;
  start hotel2m;
    n1=nrow(x1);
    n2=nrow(x2);
    k=ncol(x1);
    one1=j(n1,1,1);
    one2=j(n2,1,1);
    ident1=i(n1);
    ident2=i(n2);
    ybar1=x1`*one1/n1;
    s1=x1`*(ident1-one1*one1`/n1)*x1/(n1-1.0);
    print n1 ybar1;
    print s1;
    ybar2=x2`*one2/n2;
    s2=x2`*(ident2-one2*one2`/n2)*x2/(n2-1.0);
    st=s1/n1+s2/n2;
    print n2 ybar2;
    print s2;
    t2=(ybar1-ybar2)`*inv(st)*(ybar1-ybar2);
    df1=k;
    p=1-probchi(t2,df1);
    print t2 df1 p;
    f=(n1+n2-k-1)*t2/k/(n1+n2-2);
    temp=((ybar1-ybar2)`*inv(st)*(s1/n1)*inv(st)*(ybar1-ybar2)/t2)**2/(n1-1);
    temp=temp+((ybar1-ybar2)`*inv(st)*(s2/n2)*inv(st)*(ybar1-ybar2)/t2)**2/(n2-1);
    df2=1/temp;
    p=1-probf(f,df1,df2);
    print f df1 df2 p;
  finish;
  use swiss;
    read all var{length left right bottom top diag} where (type="real") into x1;
    read all var{length left right bottom top diag} where (type="fake") into x2;
  run hotel2m;


/* Profile Plots */
proc sort;
  by gender condition;
  run;
proc means;
   by gender condition;
   var p;
   output out=a mean=mean;
   run;
proc gplot;
   axis1 length=4 in;
   axis2 length=5 in;
   plot mean*condition=gender / vaxis=axis1 haxis=axis2;
   symbol1 v=J f=special h=2 i=join color=black;
   symbol2 v=K f=special h=2 i=join color=black;
   symbol3 v=L f=special h=2 i=join color=black;
   symbol4 v=M f=special h=2 i=join color=black;
 run;

 /* QQ Plot */
ods graphics off;
proc univariate data=salmon noprint;
   qqplot marine;
run;
/* Residuals */
proc glm data=drugs; 
  class drug; 
  model t1-t4 = drug; 
  output out=resids r=rt1-rt4; run;  /* outputs a dataset called resids naming the resids for each depvar */

/* Histograms */
proc univariate data=resids; 
  histogram rt1-rt4; 
run;

/* Repeated measures */
/* ANOVA */
proc glm;
  class treatment dog time;
  model potassium = treatment dog(treatment) time treatment*time;
  test h=treatment e=dog(treatment);
  run;
/* MANOVA */
proc glm;
  class treat;
  model p1 p2 p3 p4=treat;            /* treatment over 4 time periods */
  manova h=treat / printe;            /* hyp: No treatment effects */
  manova h=treat m=p1+p2+p3+p4;       /* hyp: No treatment effects, add main effects */
  manova h=treat m=p2-p1,p3-p2,p4-p3; /* hyp: No treatment effects, add changes in time */
  run;

/* Mixed Effects */
proc mixed;
  class treat dog time;
  model k=treat|time;  /* Model the fixed effects */
  random dog(treat);   /* Declare the random effects */
  repeated / subject=dog(treat) type=ar(1);  /* type=  gives alternatives for covar structure */
  run;
  
/* Linear score function */
  data test;
  input fresh marine;
  cards;
150 400
;
  proc discrim data=salmon pool=test crossvalidate;
  priors '1'=0.6  '2'=0.4;
  class type;
  var fresh marine;
  run;

/* Factor Analysis */
/* Canonical Analysis */
proc cancorr out=canout vprefix=sales vname="Sales Variables"   /* V variables */ 
                        wprefix=scores wname="Test Scores";     /* W variables */
  var growth profit new;
  with create mech abs math;
  run;
proc gplot;  /* takes the two variables from PROC CANCORR above */
  axis1 length=3 in;
  axis2 length=4.5 in;
  plot sales1*scores1 / vaxis=axis1 haxis=axis2;
  symbol v=J f=special /* symbols are closed circles */
         h=2 i=r /* add a regression line */ color=black;
  run;


/* Cluster Analysis */
proc cluster method=complete outtree=clust1;   /* method=average method=centroid method=single method=ward */
  var w x y z;
  id ident;  /* whatever the unique key, identifer variable is */
  run;
proc fastclus maxclusters=4 radius=20 maxiter=100 out=clust;      /* K Means */
  var w x y z;
  id ident;
  run;
/* hclust dendogram */
proc tree horizontal nclusters=6 out=clust2;
  id ident;
  run;
proc glm;
  class cluster;
  model w x y z = cluster;
  means cluster;
  run;

  /* K means */
  proc fastclus maxclusters=4 replace=random;
  var carcar corflo faggra ileopa liqsty maggra nyssyl ostvir oxyarb;
  id ident;
  run;
