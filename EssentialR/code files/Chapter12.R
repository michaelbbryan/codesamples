## Chapter 12: Linear Models II. 

## One-way ANOVA

par(mfrow=c(1,2),mar=c(2,3,1.5,0.5))
data(warpbreaks)
boxplot(breaks~wool,data=warpbreaks)
boxplot(breaks~tension,data=warpbreaks)


t.test(breaks~wool,data=warpbreaks)


oneway.test(breaks~tension,data=warpbreaks)


summary(lm(breaks~tension,data=warpbreaks))


anova(lm(breaks~tension,data=warpbreaks))


TukeyHSD(aov(breaks~tension,data=warpbreaks))


par(mfrow=c(2,2),mar=c(2,3,1.5,0.5))
plot(lm(breaks~tension,data=warpbreaks))

## Violations of assumptions

kruskal.test(breaks~wool,data=warpbreaks)


summary(lm(breaks~wool+tension,data=warpbreaks))


anova(lm(breaks~wool+tension,data=warpbreaks))
TukeyHSD(aov(breaks~wool+tension,data=warpbreaks))


summary(lm(breaks~wool+tension+wool:tension,data=warpbreaks))

## Multi-way ANOVA

m1<-lm(breaks~wool*tension,data=warpbreaks)
sum(summary(m1)$coeff[c(1,2,4,6),1])


unique(warpbreaks[,2:3])


m1<-lm(breaks~wool+tension+wool:tension,data=warpbreaks)
m1.pv=unique(warpbreaks[,2:3])
m1.pv$predicted=predict(m1,newdata=unique(warpbreaks[,2:3]))
m1.pv


tapply(m1$fitted, list(warpbreaks$wool, warpbreaks$tension), mean)

## Getting a handle on interactions

anova(lm(breaks~wool+tension+wool:tension,data=warpbreaks))


par(mar=c(3,3,0.5,0.5))
with(warpbreaks,interaction.plot(x.factor=tension,wool,response=breaks))


par(mfrow=c(2,2),mar=c(2,3,1.5,0.5))
plot(lm(breaks~tension*wool,data=warpbreaks))

## Tukey HSD and family-wise error rates

TukeyHSD(aov(breaks~wool+tension+wool:tension,data=warpbreaks))

## Demo of {agricolae}

library(agricolae)
data(sweetpotato)


model<-aov(yield~virus, data=sweetpotato)
out <- HSD.test(model,"virus", group=TRUE,main="Yield of sweetpotato\nDealt with different virus")
out$means
out$groups


par(mfrow=c(1,2),mar=c(3,3,1,1))
bar.group(out$groups,ylim=c(0,45),density=4,border="blue")
bar.group(out$groups,ylim=c(0,45),col=c("grey30","grey70"),names.arg=c("Vir.1","Vir.2","Vir.3","Vir.4"),ylab="some units")


model2<-(lm(breaks~wool+tension+wool:tension,data=warpbreaks))
HSD.test(model2, trt="tension", group=TRUE,main="Wool x Tension")$groups

## Exercises

##1)## For the `beans` data we used in Lesson 6 model shoot biomass as a function of phosphorus (phos). Make sure `phos` is coded *as a factor*. What does the output of `summary` suggest?

##2)## Use Tukey to compare the different levels of `phos` for the model in Problem 1. Does this same pattern hold for Root biomass?

##3)## I kept track of my electric bill every month for over 7 years. The data set ("electric bill.txt") is located in the "Data" directory in essential R, and includes variable for `month`, `year`, the amount of electricity used in kilowatt hours (`kwh`), the number of days in the billing cycle (`days`), and the average temperature during the billing cycle (`avgT`). There are also variables that describe whether the bill was based on an estimated reading or actual reading  (`est`, with levels `e` and `a` for estimated or actual), `cost` (in dollars), and energy use per day (`kWhd.1`).

Fit a model of `kwhd.1` as a function of `avgT`. What is the *R*^2^? Test the hypothesis that the slope is -0.25 kwh per day per degree F increase in average monthly temperature. What is the *p*-value for this test?

##4)## My old house did not have AC, but we ran several fans in the summer, and the refrigerator and freezer certainly workd harder during the warmer months, so there could be a minimum in energy use at moderate temperatures. Include a quadratic (squared) term for average temperature. How does this change the *R*^2^ value of the model? What is the *p*-value for the quadratic term? Do the residuals suggest that one model should be favored?


##EXTRA)## Plot the linear and quadratic models. *Hint* you can use the function `curve()` to add curves to plots. 

