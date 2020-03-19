## Chapter 19: Fitting Other Models.


## II. Logistic regression

library(MASS)
data(menarche)
plot(Menarche/Total~Age,data=menarche,ylab="Proportion passed menarche")


lr1<-glm(cbind(Menarche, Total-Menarche)~Age,data=menarche,family="binomial")
summary(lr1)


-summary(lr1)$coef[1,1]/summary(lr1)$coef[2,1]


plot(Menarche/Total~Age,data=menarche,ylab="Proportion passed menarche")
lines(menarche$Age, lr1$fitted, type="l", col="red")
abline(v=13.006,h=0.5, lty=3)


with(lr1, pchisq(null.deviance - deviance, df.null - df.residual, lower.tail = FALSE))


data(faithful)
faithful$length<-cut(faithful$eruptions,breaks = c(0,3,6),labels = c("S","L"))
with(faithful,plot(waiting, jitter(as.numeric(length)-1,amount = 0.04),ylab="",yaxt="n"))
axis(side=2,at=0:1,labels=c("Short","Long"))


lr2<-glm(length~waiting,family="binomial",data=faithful)
summary(lr2)


-summary(lr2)$coef[1,1]/summary(lr2)$coef[2,1]


with(faithful,plot(waiting, jitter(as.numeric(length)-1,amount = 0.04),ylab="",yaxt="n"))
axis(side=2,at=0:1,labels=c("Short","Long"))
lines(cbind(faithful$waiting,lr2$fitted)[order(faithful$waiting),],col="red")
abline(h=0.5,v=66.113,lty=3)


plot(lr2,which=1)


## Fitting other non-linear models

ppg<-read.csv("../Data/PP-Glutamate.csv",comm="#")
head(ppg)


ek1<-nls(Glutam ~ Vm * PP/(K+PP), data = ppg, start=list(K=0.5,Vm=1))


plot(Glutam~PP,data=ppg,ylim=c(0,1.0),ylab="Glutamate (mg/min)", xlab="Pyridoxal phosphate (uM)")
paras<-summary(ek1)$coeff[,1]
curve((paras[2]*x)/(paras[1]+x),from = 0,to=10,add=TRUE)
summary(nls(Glutam ~ Vm * PP/(K+PP), data = ppg))$coeff
summary(ek1)


require(nlme)
plot(ek1)


ek2<-nls(Glutam~a+b*PP,data=ppg,start=list(a=1,b=1))
ek3<-nls(Glutam~a+b*PP+c*PP^2,data=ppg,start=list(a=1,b=1,c=1))
anova(ek2,ek3)
summary(ek3)


plot(ek3)


### VI. Exercises

##1)## Using the built-in data set `mtcars` fit a logistic regression of `am` (transmission type -- a factor coded as 0 & 1) as a function of `wt` (weight in thousands of pounds). At what weight is an automatic transmission three times as likely as a manual transmission?

##2)## The dataset given below comes from a third order polynomial, and includes some random noise. Use `nls()` to fit both a 1st order ($a+bx$) and a 3rd order ($a+bx+cx^2+dx^3$) and compare the models - how does the residual error compare? Does the distribution of the residuals give any reason to prefer one over the other? 

##3)## Plot the functions given by the two models you created above over the range -3:13.


