## Chapter 13: Linear Models III. 
### More Linear Models

```{r echo=FALSE}
knitr::opts_chunk$set(fig.width=4.5,fig.height=3,tidy=TRUE,cache=TRUE,comment="#",error=TRUE)

## Multiple regression
`{r}
data(stackloss)
summary(lm(stack.loss~Air.Flow,data=stackloss))$coef
summary(lm(stack.loss~Water.Temp,data=stackloss))$coef
summary(lm(stack.loss~Acid.Conc.,data=stackloss))$coef

`{r}
summary(lm(stack.loss~Air.Flow+Water.Temp,data=stackloss))$coef

`{r}
summary(lm(stack.loss~Air.Flow*Water.Temp,data=stackloss))$coef

`{r}
summary(lm(stack.loss~Air.Flow*Water.Temp*Acid.Conc.,data=stackloss))$coef

`{r}
summary(lm((stack.loss~(Air.Flow+Water.Temp+Acid.Conc.)^2),data=stackloss))$coef

## ANCOVA
`{r}
Rye<-read.csv("../Data/Rye-ANCOVA-2008.csv",comm="#")
head(Rye) # examine the data

`{r}
summary(lm(RyeDMg~Tdate,data=Rye))

`{r}
summary(lm(RyeDMg~Plant,data=Rye))

`{r}
summary(lm(RyeDMg~Tdate+Plant,data=Rye))

`{r}
model1<-lm(RyeDMg~Tdate+Plant+Tdate:Plant,data=Rye)
summary(model1)

`{r}
plot(RyeDMg~Tdate,data=Rye,col=Plant)
mcf<-summary(model1)$coef[,1] #coefficient estimates only
abline(a=mcf[1],b=mcf[2])
abline(a=mcf[1]+mcf[3],b=mcf[2]+mcf[4],lty=2,col="red")

## Resistant linear models
`{r}
library(MASS) # load the package "MASS"
data(mtcars) # load the data
boxplot(hp~cyl,data=mtcars)

`{r}
summary(lm(hp~factor(cyl),data=mtcars))
summary(rlm(hp~factor(cyl),data=mtcars))

## Specifying contrasts
`{r}
data(warpbreaks)
unique(warpbreaks[,2:3])

`{r}
summary(lm(breaks~wool*tension,data=warpbreaks))$coef

`{r}
aggregate(warpbreaks$breaks,by=warpbreaks[,2:3],mean)

`{r}
m1=(lm(breaks~wool*tension,data=warpbreaks))
summary(m1)$coef

`{r}
sum(summary(m1)$coef[,1]* c(0,-1,0,0,0,-1))
means=aggregate(warpbreaks$breaks,by=warpbreaks[,3:2],mean)
means[3,3]-means[6,3]

`{r}
cont.mat=matrix(c(0,-1,0,0,0,0, 0,-1,0,0,-1,0, 0,-1,0,0,0,-1),byrow=TRUE,nrow=3)
cont.mat

`{r}
library (multcomp)
tests <- glht(m1, linfct = cont.mat)
summary(tests)

## More complex designs
`{r,echo=FALSE,fig.height=3,fig.width=6}
par(mfrow=c(1,2),mar=c(1,1,3,1))
plot(1:16,1:16,type="n",xaxt="n",yaxt="n")
mtext(side=3,line = 1.1,"Completely Random",cex=1.2)
rect(xleft=rep(c(1,5,9,13),times=4),ybottom=rep(c(1,5,9,13),each=4),xright=rep(c(4,8,12,16),times=4),ytop=rep(c(4,8,12,16),each=4))
text(x=rep(c(2.5,6.5,10.5,14.5),times=4),y=rep(c(2.5,6.5,10.5,14.5),each=4),labels=sample(paste(rep(c("A","B"),each=8),rep(c("1","2"),times=8),sep=""),replace=FALSE))

plot(1:16,1:16,type="n",xaxt="n",yaxt="n")
mtext(side=3,line = 1.1,"Split Plot",cex=1.2)
rect(xleft=rep(c(1,5,9,13),times=4),ybottom=rep(c(1,5,9,13),each=4),xright=rep(c(4,8,12,16),times=4),ytop=rep(c(4,8,12,16),each=4))
rect(xleft=c(0.8,4.8,8.8,12.8,0.8,4.8,8.8,12.8), ybottom=c(0.8,0.8,0.8,0.8,8.8,8.8,8.8,8.8),xright=c(4.2,8.2,12.2,16.2,4.2,8.2,12.2,16.2),ytop=c(8.2,8.2,8.2,8.2,16.2,16.2,16.2,16.2),lty=2)
text(x=rep(c(2.5,6.5,10.5,14.5),each=2),y=rep(c(4.5,12.5),times=4),labels=sample(rep(c("A","B"),each=4),replace=FALSE))
s.p<-c("1","2")
text(x=rep(c(2.5,6.5,10.5,14.5),each=4),y=rep(c(2.5,6.5,10.5,14.5),times=4),labels=c(sample(s.p),sample(s.p),sample(s.p),sample(s.p),sample(s.p),sample(s.p),sample(s.p),sample(s.p)))


`{r echo=-1}
# Note: This is a simplified form of the data - there were actually 96 plots per year in an incomplete factorial design with 12 sub-plots per main plot.
Rye <- read.csv("../Data/RyeSplitPlot.csv", comm="#")
summary(Rye)

`{r}
summary(aov(RyeDM~Rep+Plant+Tdate,data=Rye))

`{r}
summary(aov(RyeDM~Rep+Plant+Tdate + Error(Rep/Plant),data=Rye))

## Exercises

##1)## The built in data set `trees` has data for diameter, height, and timber volume for 31 trees. How well does the volume of a cone (0.333 x height x radius^2^ x pi) predict the timber volume (fit a regression between the measured and calculated volume). Note that volume is in cubic feet, height is in feet, and diameter is in inches (divide by 12 for feet). How does this differ from a model of measured volume as a function of height and diameter squared (which is mathematically incorrect)?
*Note on units* The variable named "Girth" is actually diameter according to the help file for the data set. See `? trees`.

##2)## For the `beans` data test whether shoot biomass alters the relationship between root biomass and root length we explored in exercise 1 of Chapter 11. 

##3)## In exercise 3 and 4 of Chapter 12 we began looking at the "electric bill" data. Here is an ANCOVA problem. In April of 2008 (month 57 of occupancy) we added insulation to the roof of the house. How did this affect the relationship between daily energy use and average tempareature? Add a factor for with and without insulation, and add this factor to the quadratic model. How does this affect the fit of the model (consider residual distributions and *R*^2^)

##4)## Does the effect of adding insulation alter the coefficients of the relationship between temperature and daily electric consumption? (Do the `avgT` and `I(avgT^2)` terms interact with the insulation factor?)

##EXTRA## What is wrong with this model?