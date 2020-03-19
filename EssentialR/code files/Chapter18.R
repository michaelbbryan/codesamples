## Chapter 18: Mixed Effects Models


## A basic example

require(nlme)
data(Machines) # 6 randomly selected workers tested on 3 types of machine
summary(Machines)


fm1<-lm(score~Machine,data=Machines)
anova(fm1)
summary(fm1)


op<-par(mfrow=c(1,2),mar=c(4.1,4.1,2.7,1))
plot(fm1, which=1:2)# but residuals look a bit strange
par(op)


oneway.test(score~Worker,data=Machines)


fm2<-lm(score~Machine*Worker,data=Machines)
anova(fm2) 
# summary(fm2)# Could use TukeyHSD to test specific comparisons of interest, but results would vary with different workers.
op<-par(mfrow=c(1,2))
plot(fm2,which=1:2)
par(op)


fm3<-lme(score~Machine,random= ~ 1 | Worker,data=Machines)


anova(fm3)#  larger F-value than with lm()
plot(fm3) # residuals still odd


op<-par(mfrow=c(1,2))
fm4<-lme(score~Machine,random= ~ 1 + Machine | Worker,data=Machines)
plot(fm4)
qqnorm(fm4,abline=c(0,1))
par(op)


anova(fm4) # F value lower, but still signif. 
summary(fm4) # we get estimates for variability associated with workers and with machine in worker, and these are rather small compared to the consistant differences between machines.


## Split-plots

Rye <- read.csv("../Data/RyeSplitPlot.csv", comm="#")
summary(Rye)
summary(aov(RyeDM~Rep+Plant+Tdate + Error(Rep/Plant),data=Rye))


fm1<-lme(RyeDM~Plant+Tdate, random= ~1|Rep/Plant,data=Rye)
anova(fm1)


summary(fm1)
plot(fm1)


fm2<-lme(RyeDM~Plant*Tdate, random= ~1|Rep/Plant,data=Rye)
anova(fm2)


fm1.ML<-lme(RyeDM~Plant+Tdate, random= ~1|Rep/Plant,data=Rye,method = "ML")
fm2.ML<-lme(RyeDM~Plant*Tdate, random= ~1|Rep/Plant,data=Rye,method = "ML")
anova(fm1.ML,fm2.ML)

## Exercises

##1)## Refit the split-plot model for the Rye data from above without the outlier. Do the residuals suggest that the model is valid? How did removing the outlier affect the estimation of the fixed and random effects?

##2)## Another example of a nested model that may be similar to a repeated measures or a split plot can be seen in the dataset `RatPupWeight` that is included in `nlme`. Here are weights for 322 rat pups exposed to one of three experimental treatments. We'd expect that weight might be influenced by sex, size of litter and the experimental treatments, but there is likely to be an effect of the mother (`litter`) also that could mask these others. Fit a mixed effects model of weight as a funtion of treatment, litter size, and sex with litter as a random effect. How well does this appear to fit the data based on the residuals? Are there significant interactions between the fixed effects?

