## Chapter 11: Linear Models I. 


## Violation of Assumptions and Transformation of Data
library(MASS) # required for dataset "mammals"
data(mammals)
model1<-lm(brain~body,data=mammals)
summary(model1)


op<-par(mfrow=c(2,2),mar=c(2,3,1.5,0.5))
plot(model1)
par(op)


par(mar=c(3,3,0.5,0.5),mfrow=c(1,2))
with(mammals,plot(body,brain))
with(mammals,plot(body,brain,log="xy"))


model2<-lm(log(brain)~log(body),data=mammals)
summary(model2)


op<-par(mfrow=c(2,2),mar=c(2,3,1.5,0.5))
plot(model2)
par(op)


op<-par(mfrow=c(1,2),mar=c(2,3,2,1))
plot(density(model1$resid), main="model1")
plot(density(model2$resid),main="model2")
par(op)


par(mar=c(3,3,0.5,0.5),mfrow=c(1,2))
Weights = read.csv("../Data/WeightData.csv",comm="#")
hist(Weights$age,main="")
plot(weight~age,data=Weights)


op<-par(mfrow=c(1,2),mar=c(2,3,1.5,0.5))
plot(log(weight)~age,data=Weights)
abline(v=7,lty=2)
plot(log(weight)~age,data=subset(Weights,age>7))


m1<-lm(weight~age, data=Weights)
m2<-lm(log(weight)~age, data=subset(Weights,age>7))


op<-par(mfrow=c(2,2),mar=c(2,3,1.5,0.5))
plot(m1$fitted.values,m1$resid)
plot(density(m1$resid))
plot(m2$fitted.values,m2$resid)
plot(density(m2$resid))
par(op)


## Hypothesis Testingpar(mar=c(3,3,0.5,0.5))
beans<-read.csv("../Data/BeansData.csv",comm="#")
plot(RtDM~ShtDM,data=beans,col=P.lev)


par(mar=c(3,3,0.5,0.5))
m1<-lm(RtDM~ShtDM,data=beans);summary(m1)
plot(m1$resid~m1$fitted.values)


B1<-summary(m1)$coeff[2,1:2]
t=(B1[1]-1)/B1[2]
t


pt(t,df=22,lower.tail=TRUE)


summary(lm(RtDM~ShtDM+offset(1*ShtDM),data=beans))


par(mar=c(3,3,0.5,0.5))
plot(RtDM~ShtDM,data=beans)
abline(m1,lty=2)


## Predictions and Confidence Intervals from Regression Modelspar(mar=c(3,3,0.5,0.5))
plot(RtDM~ShtDM,data=beans,xlim=c(0.5,4),ylim=c(0.4,2.4))
abline(m1,lty=2)
new.vals<-c(2.0,2.1,2.2,3.5)
preds=predict(m1,newdata=data.frame(ShtDM= new.vals))
points(new.vals,preds,col="red",pch=24)


ci=predict(m1,data.frame(ShtDM=sort(beans$ShtDM)),level=.95, interval="confidence")
head(ci)


par(mar=c(3,3,0.5,0.5))
plot(RtDM~ShtDM,data=beans)
abline(m1,lty=1)
lines(sort(beans$ShtDM),ci[,2],col="red")
lines(sort(beans$ShtDM),ci[,3],col="red")


par(mar=c(3,3,0.5,0.5))
plot(RtDM~ShtDM,data=beans)
abline(m1,lty=1)
lines(sort(beans$ShtDM),ci[,2],col="red")
lines(sort(beans$ShtDM),ci[,3],col="red")
pri=predict(m1,data.frame(ShtDM=sort(beans$ShtDM)),level=.95, interval="prediction")
lines(sort(beans$ShtDM),pri[,2],lty=2)
lines(sort(beans$ShtDM),pri[,3],lty=2)

## Exercises

##1)## For the `beans` data test how effective root biomass (`RtDM`) is as a predictor of root length (`rt.len`).

##2)## For the `beans` data, test the hypothesis that the slope of the relationship of root biomass ~ shoot biomass ($B1$) is 0.5. 

##3)## We worked with the dataset `mammals` earlier in this chapter, and concluded that it needed to be log-transformed to meet regression assumptions. Use `predict()` to calculate the confidence interval and regression line for this regression and plot it on both the log/log plot and on the un-transformed data (this will require that you back-transform the coordinates for the line and confidence intervals).
