#############################
## Chapter 6. Bivariate Data
### Basic apporaches to dealing with two variables.  

cyl<-factor(scan(text= 
    "6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4"))
am<-factor(scan(text=
    "1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0 1 1 1 1 1 1 1"))
levels(am)<-c("auto","manual")
table(cyl,am)
table(am, cyl)

tab<-table(cyl,am)
prop.table(tab,margin=1)

prop.table(tab,margin=2)
prop.table(tab)

signif(prop.table(tab),2)

chisq.test(tab)

par(mar=c(3,3,0.5,0.5))
op=par(mfrow=c(1,2))
barplot(table(cyl,am)) 
barplot(table(am,cyl)) 

par(mfrow=c(1,2),mar=c(3,3,3,0.5))
barplot(table(cyl,am),legend.text=TRUE,main="Transmission and cylinders") 
barplot(table(cyl,am),beside=TRUE,legend.text=TRUE,
        main="Transmission and cylinders")
par(op)

par(mar=c(2.5,2.5,1.5,0.5))
mosaicplot(table(cyl,am), color=T, main="Cylinders vs. transmission",ylab="Transmission",xlab="Cylinders")

disp=scan(text=
    "2.62 2.62 1.77 4.23 5.90 3.69 5.90 2.40 2.31 2.75 2.75 4.52 4.52 4.52 
    7.73 7.54 7.21 1.29 1.24 1.17 1.97 5.21 4.98 5.74 6.55 1.29 1.97 1.56 
    5.75 2.38 4.93 1.98")
hp=scan(text=
    "110 110 93 110 175 105 245 62 95 123 123 180 180 180 205 215 230
    66 52 65 97 150 150 245 175 66 91 113 264 175 335 109")

par(mar=c(3,3,0.5,0.5))
op=par(mfrow=c(1,2))
boxplot(disp)
boxplot(hp)
par(op)

data(mtcars) # load the whole data set
mtcars[which(mtcars$hp>250),]

par(mar=c(3,3,0.5,0.5))
plot(x=disp,y=hp)
cor(disp,hp)

model=lm(hp~disp)
model
summary(model)

par(mar=c(2.1,3,2.1,0.5))
plot(density(model$residuals))

par(mar=c(2,3,1.5,0.5))
op=par(mfrow=c(2,2))
plot(model)

par(mar=c(2,3,1.5,0.5))
op=par(mfrow=c(2,2))
model2<-lm(hp[-31]~disp[-31])
summary(model2)
plot(model2)
par(op)

par(mar=c(3,3,0.5,0.5))
plot(am, hp)

t.test(hp~am)

oneway.test(hp~am)
oneway.test(hp~cyl)
summary (lm(hp~cyl))

###### VI. Exercises ######
## 1)## Using the data `cyl` and `am` (transmission type) from Part II, group vehicles based into 8 cylinder and less than 8 cyl. Test whether there is evidence of association between many cylinders and automatic transmissions. (_Hint:_ use `levels()` to re-level `cyl` and then use `chisq.test()`).

## 2)## The built in dataset `faithful` records the time between eruptions and the length of the prior eruption for 272 inter-eruption intervals (load the data with `data(faithful)`). Examine the distribution of each of these variables with `stem()` or `hist()`. Plot these variables against each other with the length of each eruption (`eruptions`) on the x axis. How would you describe the relationship? 

## 3)## Fit a regression of `waiting` as a function of `eruptions`. What can we say about this regression? Compare the distribution of the residuals (`model$resid` where `model` is your lm object) to the distribution of the variables.

## 4)## Is this data well suited to regression? Create a categorical variable from `eruptions` to separate long eruptions from short eruptions (2 groups) and fit a model (ANOVA) of `waiting` based on this. (_Hint:_ use `cut()` to make the categorical variable, and `lm()` to fit the model). How did you choose the point at which to cut the data? How might changing the cutpoint change the results?

