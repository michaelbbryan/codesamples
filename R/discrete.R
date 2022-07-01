#######################################################################
##### Penn State student drinking example for Binomial likelihood and loglikelihood functions
##### Estimate of the MLE
##### Test for 1-sample proportion based on the normal approximation
##### Test for 1-sample proportion based on Likelihood Ratio Test
##### R code that corresponds to the SAS code
######################################################################

#Likelihood and LogLikelihood
########## Likelihood & Loglikelihood ######################################
##### Define the likelihood function for binomial sample with N=1315 and X=630:

likelhd = function(p) dbinom(630,1315,p)
loglik = function(p) dbinom(630,1315,p, log=TRUE)

##### Plot the likelihood function and save it into a file:
##### If you do not want it to be saved into a file directly, comment out the
##### postscript() and dev.off() lines

postscript("drinkingLik.ps")
plot(likelhd,0,1,xlab="pi",ylab="l(p)",main="Binomial likelihood, N=1315, X=630")
dev.off()

postscript("drinkingLogLik.ps")
plot(loglik,0,1,xlab="pi",ylab="l(p)",main="Binomial loglikelihood, N=1315, X=630")
dev.off()

############# MLE ######################################
##### Find the MLE (for multiparameter problems, we would use the nlm() function)
##### $maximum is the value of the MLE

mle=optimize(likelhd,c(0,1),maximum=TRUE)
mle
mle=mle$maximum

######### 1-proportion Hypothesis test, Approximate 95% confidence interval, and MLE #####
##### H0: p=0.5 vs. Ha: p is not equal 0.5

prop.test(630, 1315, 0.5)

### when the sample size is small, we can do an exact test via:

binom.test(630,1315,0.5)

##### Now the 1-proportion Hypothesis test and the 95% CI based on the LR test (statistic, and 95% CI)
##### calculating Likelihood Ratio Statistics and testing for it's significance
#Likelihood Ratio Test

LRstats=2*(loglik(0.48)-loglik(0.5))
LRstats

##### p-value from chisq distribution with degrees of freedom=1

pvalue<-1-pchisq(LRstats, 1)
pvalue

###### Likelihood ratio based 95% CI #####
### First compute the horizontal cutoff, and plot it on the loglikelhood

cutoff=loglik(0.48)-1.92
cutoff

postscript("drinkingCI.ps")
plot(loglik,0,1,xlab="pi",ylab="l(p)",main="Binomial loglikelihood, N=1315, X=630", ylim=c(-60,-3), xlim=c(0.3,0.65))
abline(h=cutoff)

### compute where the cutoff line intersects the loglikelihood
### and plot the vertical lines at those points

loglik.optim=function(p){abs(cutoff-loglik(p))}

min1=optimize(loglik.optim, c(0,mle))
min2=optimize(loglik.optim, c(mle,1))

min1
min2

abline(v=min1$minimum)
abline(v=min2$minimum)

#abline(v=0.453)
#abline(v=0.506)
dev.off()

##################################################
##### Here is R code version of this problem
####  that corresponds to the SAS code and its output
#################################################

drinking=c(rep("high risk",630),rep("low risk",685))

##### Freq Procedure

Percentage=100*as.vector(table(drinking))/sum(table(drinking))
CumulativeFrequency=cumsum(c(630,685))
CumulativePercentage=cumsum(Percentage)
Freq=data.frame(table(drinking),Percentage,CumulativeFrequency,CumulativePercentage,row.names=NULL)
row.names(Freq)=NULL
Freq
#Asymptotic Standard Error

##### asymptotic standard error

phat=630/(630+685)
p0=0.5
n=630+685
ASE=sqrt(phat*(1-phat)/n)
ASE

##### The asymptotic test statistic Z

Z=(phat-0.5)/sqrt(p0*(1-p0)/n)
Z

##### One-sided Pr <  Z

pnorm(Z)

##### Two-sided Pr > |Z|

2*pnorm(Z)

##### Using the normal approximation, calculate the asymptotic confidence interval

CI_upper=phat+qnorm(0.025,lower.tail=F)*ASE
CI_lower=phat-qnorm(0.025,lower.tail=F)*ASE
CI=cbind(CI_lower,CI_upper)
CI

##### The approximate confidence interval can also be calculated by prop.test()

prop.test(630,630+685,p=630/(630+685))

##### Apply the exact binomial test to test H0:p=0.5 for high-risk drinkers

binom.test(c(630,685),p=0.5)


#Goodness of Fit
###### Dice Rolls from Lesson 2: one-way tables & GOF
##### Line by line calculations in R
##### Nice R code that corresponds to SAS code and output
##########################################################

### if you want all output into a file use: sink("dice_roll.out")
sink("dice_roll.out")

### run a goodness of fit test
dice<- chisq.test(c(3,7,5,10,2,3))
dice

########OUTPUT gives Pearson chi-squared
#	Chi-squared test for given probabilities
#
#  data:  c(3, 7, 5, 10, 2, 3)
#  X-squared = 9.2, df = 5, p-value = 0.1013
########

### to get observed values
dice$observed


### to get expected values
dice$expected

### to get Pearson residuals
dice$residuals


#####Make the output print into a nice table ######
#### creating a table and giving labels to the columns
out<-round(cbind(1:6, dice$observed, dice$expected, dice$residuals),3)
out<-as.data.frame(out)
names(out)<-c("cell_j", "O_j", "E_j", "res_j")

### printing your table of results into a text file with tab separation
write.table(out, "dice_rolls_Results", row.names=FALSE, col.names=TRUE, sep="\t")


#########TO GET Deviance statistic and it's p-value
G2=2*sum(dice$observed*log(dice$observed/dice$expected))
G2
1-pchisq(G2,5)


##deviance residuals
devres=sign(dice$observed-dice$expected)*sqrt(abs(2*dice$observed*log(dice$observed/dice$expected)))
devres

##to show that the G2 is a sum of deviance residuals
G2=sum(sign(dice$observed-dice$expected)*(sqrt(abs(2*dice$observed*log(dice$observed/dice$expected))))^2)
G2

########## If you want to specify explicitly the vector of probabilities
dice1<-chisq.test(c(3,7,5,10,2,3), p=c(1/6, 1/6, 1/6, 1/6, 1/6, 1/6))
dice1

#Independence
chisqr.test(xgrid)	# use correct=FALSE to stop Yates continuity correction
#Proportions
##########################################
### Example: Friench skiers
### Test of independence
### Likelihood Ratio Statistics
### Fisher's Exact Test
##########################################

### Here is one way to read the data vector of values with labels for the table
ski<-matrix(c(31, 17, 109, 122), ncol=2, dimnames=list(Treatment=c("Placebo", "VitaminC"), Cold=c("Cold", "NoCold")))
ski

### Pearson's Chi-squared test  with Yates' continuity correction
result<-chisq.test(ski)
result

###Let's look at the obseved, expected values and the residuals
result$observed
result$expected
result$residuals

###Pearson's Chi-squared test  withOUT Yates' continuity correction
result<-chisq.test(ski, correct=FALSE)
result
result$observed
result$expected
result$residuals

### Let us look at the Percentage, Row Percentage and Column Percentage
### of the total observations contained in each cell.

Contingency_Table=list(Frequency=ski,Expected=result$expected,Percentage=prop.table(ski),RowPercentage=prop.table(ski,1),ColPercentage=prop.table(ski,2))
Contingency_Table

Percentage=100*ski/sum(ski)
RowSums=rowSums(ski)
RowPercentage=100*rbind(ski[1,]/RowSums[1],ski[2,]/RowSums[2])
ColSums=colSums(ski)
ColPercentage=100*cbind(ski[,1]/ColSums[1],ski[,2]/ColSums[2])
Percentage
RowPercentage
ColPercentage


### Pearson's Chi-squared test  with Yates' continuity correction
result=chisq.test(ski)
result
result$observed
result$expected
result$residuals

### Likelihood Ratio Chi-Squared Statistic
G2=2*sum(ski*log(ski/result$expected))
G2
pvalue=1-pchisq(2*sum(ski*log(ski/result$expected)),df=1)
pvalue

### OR USE OUR function LRstats()
### You first must compile (run) this function
LRstats(ski)

#Fisher's Exact Test
Fisher_Exact_TwoSided=fisher.test(ski,alternative = "two.sided")
Fisher_Exact_Less=fisher.test(ski,alternative = "less")
Fisher_Exact_Greater=fisher.test(ski,alternative = "greater")
rbind(Fisher_Exact_TwoSided,Fisher_Exact_Less,Fisher_Exact_Greater)

### Column 1 Risk Estmates

risk1_col1=ski[1,1]/RowSums[1]
risk2_col1=ski[2,1]/RowSums[2]
rho1=risk1_col1/risk2_col1
total1=ColSums[1]/sum(RowSums)
diff1=risk2_col1-risk1_col1
rbind(risk1_col1,risk2_col1,total1,diff1)

### The confidence interval for the difference in proportions for column 1

SE_diff1=sqrt(risk1_col1*(1-risk1_col1)/RowSums[1]+risk2_col1*(1-risk2_col1)/RowSums[2])
CI_diff1=cbind(diff1-qnorm(0.975)*SE_diff1,diff1+qnorm(0.975)*SE_diff1)
SE_diff1
CI_diff1

### Column 2 Risk Estmates

risk1_col2=ski[1,2]/RowSums[1]
risk2_col2=ski[2,2]/RowSums[2]
total2=ColSums[2]/sum(RowSums)
diff2=risk2_col2-risk1_col2
rbind(risk1_col2,risk2_col2,total2,diff2)

### The confidence interval for the difference in proportions for column 2

SE_diff2=sqrt(risk1_col2*(1-risk1_col2)/RowSums[1]+risk2_col2*(1-risk2_col2)/RowSums[2])
CI_diff2=cbind(diff2-qnorm(0.975)*SE_diff2,diff2+qnorm(0.975)*SE_diff2)
SE_diff2
CI_diff2
 
#Odds & Odds Ratios

### Estimate of the Odds of the two rows

odds1=(ski[2,1]/RowSums[2])/(ski[1,1]/RowSums[1])
odds2=(ski[2,2]/RowSums[2])/(ski[1,2]/RowSums[1])


oddsratio=odds1/odds2
odds1
odds2
oddsratio

### Confidence Interval of the odds ratio
log_CI=cbind(log(oddsratio)-qnorm(0.975)*sqrt(sum(1/ski)),log(oddsratio)+qnorm(0.975)*sqrt(sum(1/ski)))
CI_oddsratio=exp(log_CI)
CI_oddsratio


#################################
###using the 'vcd' package
install.packages("vcd")
library(vcd)
## To get the deviance statistics, pearson X^2, and a few others
assocstats(ski)

oddsratio(ski, log=FALSE)
lor=oddsratio(ski) ## OR on the log scale
lor
confint(lor) ## CI on the log scale
exp(confint(lor)) ## CI on the basic scale
 
### Example: Smoking Behaviors Lesson 3 ##
### Simple line by line R code
### Needs LRStats.R and Gamma.f.R functions too
### Uses {VCD} package to plot the expected counts and residuals
### Nice R code that corresponds to SAS code and output
#######################################################

smoke=matrix(c(400,416,188,1380,1823,1168), ncol=2, dimnames=list(parent=c("both", "one","neither"), child=c("yes", "no")))
smoke

#### Chi-Square Independence Test

result=chisq.test(smoke)
result

#### Let us look at the Percentage, Row Percentage and Column Percentage
#### of the total observations contained in each cell.

Contingency_Table=list(Frequency=smoke,Expected=result$expected,Percentage=prop.table(smoke),RowPercentage=prop.table(smoke,1),ColPercentage=prop.table(smoke,2))
Contingency_Table

#### Likelihood Ratio Test
LRstats(smoke)

#### a function assocstats in package vcd that computes these association measures
#### along with the Pearson and LR chi-square tests. If this doesn't run then you
#### need to install package 'colorspace' too.
library(vcd)

## produces independence statistics
assocstats(smoke)

#Module 3 Heart Disease
### Example: Heart Disease Example Lesson 3 ##
### Simple line by line R code
### Nice R code that corresponds to SAS code and output
#######################################################

## enter data
heart <-c(12,8,31,41,307,246,439,245)
heart<-matrix(heart,4,2)
heart=t(heart)

## run the chi-squared test of independence & save it into a new object
result<-chisq.test(heart)
result

## Let's look at the obseved, expected values and the residuals
result$observed
result$expected
result$residuals

### Likelihood Ratio Test
LR=2*sum(heart*log(heart/result$expected))
LR
LRchisq=1-pchisq(LR,df=(4-1)*(2-1))
LRchisq


 ##make sure you have function LRstats()
 LRstats(heart)


 ## Let's calculate the conditional probabilities
 ## the following function gives the desired marginal, in this case, the counts for the serum groups
serum<-margin.table(heart,2)
serum

## let's look at the counts for the four groups with CHD
heart[1,]

## then counts for the four groups with NOCHD, which is the second column of data in the dataframe we created above
heart[2,]

### conditional probabilities are:
heart[2,]/serum
heart[1,]/serum

########################################
### Nice R code that corresponds to SAS code and output
#######################################################
heart=matrix(c(12,307,8,246,31,439,41,245), ncol=4, dimnames=list(CHD=c("chd", "nochd"), serum=c("0-199", "200-199","220-259","260+")))
heart
count=heart

### Chi-Square Independence Test
result=chisq.test(count)
result$expected

### Let us look at the Percentage, Row Percentage and Column Percentage
### of the total observations contained in each cell.

Contingency_Table=list(Frequency=count,Expected=result$expected,Deviation=count-result$expected,Percentage=prop.table(count),RowPercentage=prop.table(count,1),ColPercentage=prop.table(count,2))
Contingency_Table

###### Computing various measures of association
library(vcd)
assocstats(heart)

### For the Pearson correlation coefficent
### and Mantel-Haenszel,
### for IxJ tables, you can also use
### pears.cor() function.
### Mak sure you run this function first!
### c(1,2) and c(1,2,3,4), are the vectors of score values
pears.cor(heart, c(1,2),c(1,2,3,4))
### and this should give you, r=-0.14, M2=26.1475

##Gamma
Gamma.f(heart)
#Module 3 Vitamin C
##########################################
### Example: Friench skiers
### Test of independence
### Likelihood Ratio Statistics
### Fisher's Exact Test
##########################################

### Here is one way to read the data vector of values with labels for the table
ski<-matrix(c(31, 17, 109, 122), ncol=2, dimnames=list(Treatment=c("Placebo", "VitaminC"), Cold=c("Cold", "NoCold")))
ski

### Pearson's Chi-squared test  with Yates' continuity correction
result<-chisq.test(ski)
result

###Let's look at the obseved, expected values and the residuals
result$observed
result$expected
result$residuals

###Pearson's Chi-squared test  withOUT Yates' continuity correction
result<-chisq.test(ski, correct=FALSE)
result
result$observed
result$expected
result$residuals

### Let us look at the Percentage, Row Percentage and Column Percentage
### of the total observations contained in each cell.

Contingency_Table=list(Frequency=ski,Expected=result$expected,Percentage=prop.table(ski),RowPercentage=prop.table(ski,1),ColPercentage=prop.table(ski,2))
Contingency_Table

Percentage=100*ski/sum(ski)
RowSums=rowSums(ski)
RowPercentage=100*rbind(ski[1,]/RowSums[1],ski[2,]/RowSums[2])
ColSums=colSums(ski)
ColPercentage=100*cbind(ski[,1]/ColSums[1],ski[,2]/ColSums[2])
Percentage
RowPercentage
ColPercentage


### Pearson's Chi-squared test  with Yates' continuity correction
result=chisq.test(ski)
result
result$observed
result$expected
result$residuals

### Likelihood Ratio Chi-Squared Statistic
G2=2*sum(ski*log(ski/result$expected))
G2
pvalue=1-pchisq(2*sum(ski*log(ski/result$expected)),df=1)
pvalue

### OR USE OUR function LRstats()
### You first must compile (run) this function
LRstats(ski)

### Fisher's Exact Test
Fisher_Exact_TwoSided=fisher.test(ski,alternative = "two.sided")
Fisher_Exact_Less=fisher.test(ski,alternative = "less")
Fisher_Exact_Greater=fisher.test(ski,alternative = "greater")
rbind(Fisher_Exact_TwoSided,Fisher_Exact_Less,Fisher_Exact_Greater)

### Column 1 Risk Estmates

risk1_col1=ski[1,1]/RowSums[1]
risk2_col1=ski[2,1]/RowSums[2]
rho1=risk1_col1/risk2_col1
total1=ColSums[1]/sum(RowSums)
diff1=risk2_col1-risk1_col1
rbind(risk1_col1,risk2_col1,total1,diff1)

### The confidence interval for the difference in proportions for column 1

SE_diff1=sqrt(risk1_col1*(1-risk1_col1)/RowSums[1]+risk2_col1*(1-risk2_col1)/RowSums[2])
CI_diff1=cbind(diff1-qnorm(0.975)*SE_diff1,diff1+qnorm(0.975)*SE_diff1)
SE_diff1
CI_diff1

### Column 2 Risk Estmates

risk1_col2=ski[1,2]/RowSums[1]
risk2_col2=ski[2,2]/RowSums[2]
total2=ColSums[2]/sum(RowSums)
diff2=risk2_col2-risk1_col2
rbind(risk1_col2,risk2_col2,total2,diff2)

### The confidence interval for the difference in proportions for column 2

SE_diff2=sqrt(risk1_col2*(1-risk1_col2)/RowSums[1]+risk2_col2*(1-risk2_col2)/RowSums[2])
CI_diff2=cbind(diff2-qnorm(0.975)*SE_diff2,diff2+qnorm(0.975)*SE_diff2)
SE_diff2
CI_diff2

### Estimate of the Odds of the two rows

odds1=(ski[2,1]/RowSums[2])/(ski[1,1]/RowSums[1])
odds2=(ski[2,2]/RowSums[2])/(ski[1,2]/RowSums[1])

### Odds Ratio

oddsratio=odds1/odds2
odds1
odds2
oddsratio

### Confidence Interval of the odds ratio
log_CI=cbind(log(oddsratio)-qnorm(0.975)*sqrt(sum(1/ski)),log(oddsratio)+qnorm(0.975)*sqrt(sum(1/ski)))
CI_oddsratio=exp(log_CI)
CI_oddsratio

#################################
###using the 'vcd' package
install.packages("vcd")
library(vcd)
## To get the deviance statistics, pearson X^2, and a few others
assocstats(ski)

oddsratio(ski, log=FALSE)
lor=oddsratio(ski) ## OR on the log scale
lor
confint(lor) ## CI on the log scale
exp(confint(lor)) ## CI on the basic scale

#Pearsons Correlation on 2 Way Table
#A function for computing Pearson correlation for IxJ tables & Mantel-Haenszel, M2
#pearson correlation for IxJ tables
#table = IxJ table or a matrix
#rscore=vector of row scores
#cscore=vector of column scores
pears.cor=function(table, rscore, cscore)
{
	dim=dim(table)
	rbar=sum(margin.table(table,1)*rscore)/sum(table)
	rdif=rscore-rbar
	cbar=sum(margin.table(table,2)*cscore)/sum(table)
	cdif=cscore-cbar
	ssr=sum(margin.table(table,1)*(rdif^2))
	ssc=sum(margin.table(table,2)*(cdif^2))
	ssrc=sum(t(table*rdif)*cdif)
	pcor=ssrc/(sqrt(ssr*ssc))
	pcor
	M2=(sum(table)-1)*pcor^2
	M2
	result=c(pcor, M2)
	result
	}
#Spearman Correlation
#A function for computing Spearman correlation for IxJ tables & MH statistic
#Spearman correlation for IxJ tables
#table = IxJ table or a matrix
#rscore=vector of midrank row scores
#cscore=vector of midrank column scores
spear.cor=function(table)
{
	table=as.table(table)
	rscore=array(data=NA, dim=dim(table)[1])
	cscore=array(data=NA, dim=dim(table)[2])

		for( i in 1:dim(table)[1]){
		if (i==1) rscore[i]=(margin.table(table,1)[i]+1)/2
		else
		rscore[i]=sum(sum(margin.table(table,1)[1:(i-1)])+(margin.table(table,1)[i]+1)/2)
		}
		rscore
	    ri=rscore-sum(table)/2
	    ri=as.vector(ri)

		for (j in 1:dim(table)[2]){
			if (j==1) cscore[j]=(margin.table(table,2)[j]+1)/2
			else
			cscore[j]=sum(sum(margin.table(table,2)[1:(j-1)])+(margin.table(table,2)[j]+1)/2)
		}
		cscore
		ci=cscore-sum(table)/2
		ci=as.vector(ci)

	v=sum(t(table*ri)*ci)
	rowd=sum(table)^3-sum(margin.table(table,1)^3)
	cold=sum(table)^3-sum(margin.table(table,2)^3)
	w=(1/12)*sqrt(rowd*cold)

	scor=v/w
	scor

	M2=(sum(table)-1)*scor^2
	M2
	result=c(scor, M2)
	result
	}

#MultiDim Fit
##Berkley Admissions
#############################
#### Berkeley admissions data
#### Uses dataset already in R
#### See also berkeley1.R for a different code
#### See also related berkeleyLoglin.R
#############################

#### Dataset already exist in R library

UCBAdmissions

#### To test the odds-ratios in the marginal table and each of the subtables

library(vcd)

#### marginal table Admit x Gender

admit.gender=margin.table(UCBAdmissions, c(1,2))
admit.gender
admit.gender/4526

exp(oddsratio(admit.gender))
chisq.test(admit.gender)

#### Tests for partial tables AdmitxGender for each level of Dept.

chisq.test(UCBAdmissions[,,1])
exp(oddsratio(UCBAdmissions[,,1]))

chisq.test(UCBAdmissions[,,2])
exp(oddsratio(UCBAdmissions[,,2]))

chisq.test(UCBAdmissions[,,3])
exp(oddsratio(UCBAdmissions[,,3]))

chisq.test(UCBAdmissions[,,4])
exp(oddsratio(UCBAdmissions[,,4]))

chisq.test(UCBAdmissions[,,5])
exp(oddsratio(UCBAdmissions[,,5])

chisq.test(UCBAdmissions[,,6])
exp(oddsratio(UCBAdmissions[,,6]))

#### To visualize graphically these association explore fourfold() function in the vcd() package!

#### CMH test

mantelhaen.test(UCBAdmissions)

#############################
#### Berkeley admissions data for log-linear models
#### See also berkeley.R for a different code
#### R code that matches SAS default setting
#### See also related berkeleyLoglin.R
#############################

#### Reading in the text files instead of using dataset from R
#### Make sure you specify the correct path on your computer
#### You can also read it directly from the internet, if you know
#### the internet address and you are connected.
#### berkeley=read.table("http://onlinecourses.science.psu.edu/stat504/sites/onlinecourses.science.psu.edu.stat504/files/lesson05/berkeley.txt")

berkeley=read.table("berkeley.txt")
colnames(berkeley)=c("D","S","A","count")
berkeley

#### Here are some different ways to create tables
#### Table  A*D*S

temp=xtabs(berkeley$count~berkeley$D+berkeley$S+berkeley$A)
temp
xtabs(berkeley$count~., data=berkeley)


#### Table 1-6 of S*A

temp=xtabs(berkeley$count~berkeley$S+berkeley$A+berkeley$D)
temp

#### Table of S*A withOUT conditioning on berkeley$D

table=addmargins(temp)[1:2,1:2,7]

#### Please repeat doing all the following steps for all tables of S*A: temp[,,1]-temp[,,6]
#### ----------------------------------------------------------------------------
table=temp[1:2,1:2,1]

#table=temp[1:2,1:2,2]
#table=temp[1:2,1:2,3]
#table=temp[1:2,1:2,4]
#table=temp[1:2,1:2,5]
#table=temp[1:2,1:2,6]

#### Chi-Square Test for Table 1 of s*A
#### temp[,,i] denotes the ith table

result=chisq.test(table,correct=FALSE)
result$expected
Table_SA6=list(Frequency=table,Expected=result$expected,Percent=prop.table(table))

#### Fisher Exact Test for Table 1 of s*A

Fisher_Exact_TwoSided=fisher.test(table,alternative = "two.sided")
Fisher_Exact_Less=fisher.test(table,alternative = "less")
Fisher_Exact_Greater=fisher.test(table,alternative = "greater")
list(Fisher_Exact_TwoSided=Fisher_Exact_TwoSided,Fisher_Exact_Less=Fisher_Exact_Less,Fisher_Exact_Greater=Fisher_Exact_Greater)

#### Relative Risk for Table 1 of s*A

RowSums=rowSums(table)
ColSums=colSums(table)

#### Estimate of the Odds of the two rows

odds1=(table[2,1]/RowSums[2])/(table[1,1]/RowSums[1])
odds2=(table[2,2]/RowSums[2])/(table[1,2]/RowSums[1])
odds1
odds2

#### Odds Ratio

oddsratio=odds2/odds1
oddsratio

#### Confidence Interval of the odds ratio

log_CI=cbind(log(oddsratio)-qnorm(0.975)*sqrt(sum(1/table)),log(oddsratio)+qnorm(0.975)*sqrt(sum(1/table)))
CI_oddsratio=exp(log_CI)
CI_oddsratio


#### Table of D*S if A=Accept

Table_ADS=list(Frequency=temp[,,1],Expected=temp[,,1]$expected,Percent=prop.table(temp[,,1]))
Table_ADS

#### Table of D*S if A=Reject

Table_ADS=list(Frequency=temp[,,2],Expected=temp[,,2]$expected,Percent=prop.table(temp[,,2]))
Table_ADS

#### Table of D*S withOUT conditioning on berkeley$A

addmargins(temp)
table=addmargins(temp)[1:6,1:2,3]
result=chisq.test(table,correct=FALSE)
Contigency_Table=list(Frequency=table,Expected=chisq.test(table)$expected,Percent=prop.table(table),RowPCt=prop.table(table,1),ColPct=prop.table(table,2))
Contigency_Table

#### /* joint independence of D and S from A*/

D=factor(berkeley$D)
S=factor(berkeley$S)
A=factor(berkeley$A)
model=glm(berkeley$count~D+S+A+D*S,family=poisson(link=log))
summary(model)


#### -----------------------------------------------------------------------
#### To set up the same coding that is in default SAS
#### First we set the type of contrast to treatment contrasts for factors

options(contrast=c("contr.treatment","contr.poly"))
D=berkeley$D
S=berkeley$S
A=berkeley$A
count=berkeley$count

#### Notice that R uses base level Department A,Female and Accept which is different from SAS.
#### Complete Independence

temp=glm(count~D+S+A,family=poisson(link=log))
temp

####/* joint independence of D and S from A*/

temp=glm(count~D+S+A+D*S,family=poisson(link=log))
temp

#### /*conditional independence of D and A given S */

temp=glm(count~D+S+A+D*S+A*S,family=poisson(link=log))
temp

#### /*homogeneous associations */

temp=glm(count~D+S+A+D*S+D*A+A*S,family=poisson(link=log))
temp

####  /*saturated model */

temp=glm(count~D+S+A+D*S+D*A+S*A+D*S*A,family=poisson(link=log))
temp

#Logistic Regression
##Using Factors
# R needs a Nx2 object with the two columns counts of binary states yes,no etc
y = c(19,29,24)  		# yes variable
n = c(497,560,269) 		# no variable
x = factor(c(’normal’,’slight’,’very’))
x = relevel(x,ref=’normal’)
fit = glm(cbind(y,n)~x,family=binomial(link=’logit’))
summary(fit)
exp(confint.default(fit))
##Using Logical Vectors
S=factor(c("low","medium","high"))
y=c(53,34,10)
n=c(265,270,265)
count=cbind(y,n-y)
Smedium=(S=="medium")
Shigh=(S=="high")
result=glm(count~Smedium+Shigh,family=binomial("logit"))
summary(result)
##Using a category weighting
snorefreq <- as.factor(c(0, 2, 4, 5))
snore<-cbind(c(24,35,21,30),c(1355,603,192,224))
snore.model <- glm(snore ~ snorefreq, family=binomial(link=logit))
summary(snore.model)
##Using Continuous
result=glm(survive~age,family=binomial("logit"))
##Confidence Intervals on coefficients
# recall this models a log odds ratio, so exponentiate coefficients and confint
coefficients(result)
exp(coefficients(result)[2])
confint(result) ## confidence interval for parameters
exp(confint(result)) ## exponentiate to get on the odds-scale

#Baseline Categorical Model using VGAM

###NEW March 13, 2014 ####
###Example that corresponds to the lecture notes
###using aggregate data from gator.txt which is a 16x5 flat table of the 2x2x4x5 table with total sample size of 219
## Gender={f=female, m=male}
## Size={<2.3=small, >2.3=large}
## Lake={george, hancock,oklawaha,trafford}
## Food is given in 5 column {Fish, Invertebrate,Reptile,Bird,Other}
install.packages("vgam")
library(VGAM)

# Baseline Categories Logit model for nominal response

gator = read.table("gator.txt",header=T)
gator$Size = factor(gator$Size,levels=levels(gator$Size)[2:1])
totaln=sum(gator[1:16,5:9]) ## total sample size
rown=c(1:16)
for (i in 1:16) {
	rown[i]=sum(gator[i,5:9])
	rown
	}

rown ## sample size by the profile

##set the ref levels so that R output matches the SAS code
##sets Hancock as the baseline level
contrasts(gator$Lake)=contr.treatment(levels(gator$Lake),base=2)
contrasts(gator$Lake)

##sets "small" as the refernce level
contrasts(gator$Size)=contr.treatment(levels(gator$Size),base=2)
contrasts(gator$Size)

##sets male as the reference level
contrasts(gator$Gender)=contr.treatment(levels(gator$Gender),base=2)
contrasts(gator$Gender)

##Fit all basline logit models with Fish as the basline level
## By default VGLM will use the last level as the baseline level for creating the logits
## to set Fish as the baseline level, specify it last in vglm call below

# intercept only
fit0=vglm(cbind(Bird,Invertebrate,Reptile,Other,Fish)~1, data=gator, family=multinomial)
fit0
summary(fit0)
deviance(fit0) ## gives only the deviance

# with Gender
fit1=vglm(cbind(Bird,Invertebrate,Reptile,Other,Fish)~Gender, data=gator, family=multinomial)
summary(fit1)

# with Size
fit2=vglm(cbind(Bird,Invertebrate,Reptile,Other,Fish)~Size, data=gator, family=multinomial)
summary(fit2)

# with Lake
fit3=vglm(cbind(Bird,Invertebrate,Reptile,Other,Fish)~Lake, data=gator, family=multinomial)
summary(fit3)

# with Lake + Size
fit4 = vglm(cbind(Bird,Invertebrate,Reptile,Other,Fish)~Lake+Size, data=gator, family=multinomial)
summary(fit4)

# with Lake + Size + Gender
fit5=vglm(cbind(Bird,Invertebrate,Reptile,Other,Fish)~Lake+Size+Gender, data=gator, family=multinomial)
summary(fit5)
exp(coefficients(fit5)) ## to get the odds and odds-ratios

# with Lake + Size + LakeXSize
fit6=vglm(cbind(Bird,Invertebrate,Reptile,Other,Fish)~Lake+Size+Lake:Size, data=gator, family=multinomial)
summary(fit6)

# saturated
fitS = vglm(cbind(Bird,Invertebrate,Reptile,Other,Fish)~Lake+Size+Gender+Lake:Size+Lake:Gender+Size:Gender+Lake:Size:Gender, data=gator, family=multinomial)
fitS

## Parts of Analysis of deviance
## To compare deviances of different models, for example
deviance(fit5)-deviance(fitS)
df.residual(fit5)-df.residual(fitS)

deviance(fit4)-deviance(fit5)
df.residual(fit4)-df.residual(fit5)


## to adderess overdispersion with model from the fit4
## we usually use the Chi-Sq. statisics devided by its dfs
## here we need to compute it via first computing pearson residuals
pears.res=(fitted.values(fitS)*rown-fitted.values(fit4)*rown)^2/(fitted.values(fit4)*rown)
X2=sum(pears.res)

scaleparm=sqrt(X2/44)  ## 1.148 for fit 4
## then adjust for dispersion
summary(fit4, dispersion=scaleparm)
##or  gives the same
summary(fit4, dispersion=1.148)

## Consider collapsing over Gender
## see notes on ANGEL

### For Sections 8.2 and 8.3 in the notes?
# Baseline Categories Logit model for nominal response
# Adjacent-Categories Logit Model for nominal response

##recall that vglm uses the last level in R is the default level for creating the logits
fit.bcl = vglm(cbind(Bird,Invertebrate,Reptile,Other,Fish)~Lake+Size,data=gator,family=multinomial) # Lake + Size

fit.acl = vglm(cbind(Invertebrate,Reptile,Bird,Other,Fish)~Lake+Size,data=gator,family=acat(rev=T)) # consult help(acat)

deviance(fit.bcl)
deviance(fit.acl) # model fits are equivalent
junk = expand.grid(Size=levels(gator$Size),Lake=levels(gator$Lake))
(pred.bcl = cbind(junk,predict(fit.bcl,type="response",newdata=junk))) # pred. same
(pred.acl = cbind(junk,predict(fit.acl,type="response",newdata=junk))) # for both models

t(coef(fit.bcl,matrix=T))
t(coef(fit.acl,matrix=T)) # coefficients are different, but related:

rev(cumsum(rev(coef(fit.acl,matrix=T)["(Intercept)",])))  #These are the alpha_j for the baseline-category logit model, derived from the adjacent-categories logit model

rev(cumsum(rev(coef(fit.acl,matrix=T)["Lakehancock",]))) # effects for Lake Hancock for bcl model, derived from acl model

rev(cumsum(rev(coef(fit.acl,matrix=T)["Lakeoklawaha",]))) # effects for Lake Oklawaha for bcl model, derived from acl model

rev(cumsum(rev(coef(fit.acl,matrix=T)["Laketrafford",]))) # effect for Lake Trafford for bcl model, derived from acl model

rev(cumsum(rev(coef(fit.acl,matrix=T)["Size<2.3",]))) # effects for small alligators for bcl model, derived from acl model


####################################################################
### To see other possible pakages in R to fit these data, see additional code on ANGEL
## alligator-working.R and alligator.dat

#Poisson Regression
##Possion Regression for Amount Data
#### R code for Crab example
####Poisson Regression Model for Count Data

crab=read.table("crab.txt")
colnames(crab)=c("Obs","C","S","W","Wt","Sa")

#### to remove the column labeled "Obs"

crab=crab[,-1]

#### the following code corresponds to crab.SAS-crab1.SAS

#### Fitting the intercept only model
#### This model implies the expected number of satellites
#### per each crab is the same
#### in this case: E(Sa)=2.919=exp(1.0713)

model=glm(crab$Sa~1, family=poisson(link=log))
summary(model)
model$fitted

#### Poisson Regression of Sa on W

model=glm(crab$Sa~1+crab$W,family=poisson(link=log))
summary(model)
anova(model)

#### to get the predicted count for each observation:
#### e.g. for the first observation E(y1)=3.810

print=data.frame(crab,pred=model$fitted)
print

#### note the linear predictor values
#### e.g., for the first observation, exp(1.3378)=3.810

model$linear.predictors
exp(model$linear.predictors)

rstandard(model)

#### Interpretation of the slope which is statistically significant here
#### e.g., exp(0.1640)=1.18
#### as the width increases by one unit, the number of satilies will
#### increase (positive sign of the coef),
#### it will be multiplied by 1.18
#### e.g., for W=26 and W=25, first for all values
#### then for specific rows

model$fitted[crab$W==26]/model$fitted[crab$W==25]

model$fitted[2]/model$fitted[6]

#### Based on the residual deviance the model does NOT fit well
#### e.g., 567.88/171 = 3.3209

1-pchisq(model$deviance, model$df.residual)

#### creating a scatter plot of Sa vs. W

plot(crab$W,crab$Sa)
identify(crab$W, crab$Sa)

#### click on the plot to identify individual values
#### identified on the screen and the plot, \#48,101,165

#### Diagnostics measures (like in logistic regression)
#### But these work for ungrouped data too,
#### as long as there is a variable with counts
#### You can do many more but here are a few indicating a lack of fit

influence(model)
plot(influence(model)$pear.res)
plot(model$linear.predictors, residuals(model, type="pearson"))

#### To predict a new value

newdt=data.frame(W=26.3)
predict.glm(model, type="response", newdata=newdt)


#### Let's assume for now that we do not have other covariates
#### and we will adjust for overdispersion
#### first look at the sample mean and variances
## e.g., tapply(crab$Sa, crab$W,function(x)c(mean=mean(x),variance=var(x)))

#### To estimate dispersion parameter
#### Do it on your own by X2/df & use summary.glm() (see log. reg notes)
#### Use DISMOD package (see log.reg notes)
#### Use quasipoisson family

model.disp=glm(crab$Sa~crab$W, family=quasipoisson(link=log), data=crab)
summary.glm(model.disp)
summary.glm(model.disp)$dispersion


#### Fit a negative binomial model
#### the dispersion parameter is THETA
#### Here are two different ways, both must use library(MASS)
#### In the first one, we fix theta to be 1.0
#### In the second one we let glm.nb() to estimate it

library(MASS)
nb.fit=glm(Sa~W, data=crab, family=negative.binomial(theta=1, link="identity"), start=model$coef)
summary(nb.fit)

nb.fit1=glm.nb(Sa~W, data=crab, init.theta=1, link=identity, start=model$coef)
summary(nb.fit1)

#### Adding a categorical predictor
#### This corresponds with crab2.SAS
#### make sure C is a factor

is.factor(crab$C)
crab$C=as.factor(crab$C)
model=glm(Sa~W+C,family=poisson(link=log), data=crab)
summary(model)
anova(model)
print=data.frame(crab,pred=model$fitted)
print

#### to get the same order as you do in SAS

contrasts(crab$C)=contr.SAS(levels(crab$C))
model=glm(Sa~W+C,family=poisson(link=log),data=crab)
summary(model)
anova(model)

#### to get back to the default level

contrasts(crab$C)=contr.treatment(levels(crab$C),base=1)

#### Or you can explicilty code the levels to correspond to SAS
#### Notice that change from C1 to C4 in a number of SA is significant
#### exp(0.447)=1.54, pvalue=0.0324
#### but if you adjust for overdispersion it's not significant

Sa=crab$Sa
W=crab$W
C1=1*(crab$C==1)
C2=1*(crab$C==2)
C3=1*(crab$C==3)
model=glm(Sa~W+C1+C2+C3,family=poisson(link=log))
summary(model)
anova(model)
print=data.frame(crab,pred=model$fitted)
print

plot(crab$W, model$fitted)

model.disp=glm(Sa~W+C1+C2+C3, family=quasipoisson(link=log))
summary.glm(model.disp)
summary.glm(model.disp)$dispersion
anova(model.disp)

#### Treat Color as a numeric predictor
#### This corresponds to crab3.SAS

Sa=crab$Sa
W=crab$W
C=as.numeric(crab$C)
model=glm(Sa~W+C,family=poisson(link=log))
summary(model)
anova(model)
print=data.frame(crab,pred=model$fitted)
print

newdt=data.frame(W=0,C=1)
predict.glm(model, type="response", newdata=newdt)

#### This corresponds to to crab5.SAS

width=c(22.69,23.84,24.77, 25.84,26.79,27.74,28.67,30.41)
cases=c(14,14,28,39,22,24,18,14)
SaTotal=c(14,20,67,105,63,93,71,72)
lcases=log(cases)
CrabGrp=data.frame(width,cases,SaTotal,lcases)
model=glm(SaTotal~width,offset=lcases,family=poisson(link=log))
residuals(model)
summary(model)
anova(model)
print=data.frame(CrabGrp,pred=model$fitted)
print

#### create a plot of the results

plot(SaTotal, pch="o", col="blue", main="Plot of Observed and Predicted Sa vs. groups",
     xlab="Width groups", ylab="Number of Satellites")
points(model$fitted, pch="p", col="red")
legend(6,30,c("obs","pred"), pch=c("o","p"), col=c("blue","red"))

model=glm(SaTotal~width,offset=lcases,family=poisson(link=identity))
residuals(model)

#### if you wanted to aggregate from the original data
#### create W as a factor variable with 8 levels

W.fac=cut(crab$W, breaks=c(0,seq(23.25, 29.25),Inf))
numcases=table(W.fac)

#### now compute sample means for Width variable by the cuts
#### and total number of Sa cases

width=aggregate(crab$W, by=list(W=W.fac),mean)$x
width
SaMean=aggregate(crab$Sa, by=list(W=W.fac),mean)$x
SaMean
plot(width,SaMean)
SaTotal=aggregate(crab$Sa, by=list(W=W.fac),sum)$x
SaTotal
lcases=log(numcases)
lcases


##Possion Regression for Rate Data
## Read the data file for the Credit Card example

data=read.table("creditcard.txt")
lcases= log(data[,2])
data=cbind(data,lcases)
colnames(data)=c("income","cases","CrCards","lcases")
data

## Fit the data with poisson linear model with offset=lcases

log.fit=glm(CrCards~income+offset(lcases),family=poisson,data=data)
summary(log.fit)

## Fitted Values under poisson linear model

fitted(log.fit)



