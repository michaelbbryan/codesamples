#############################
## Chapter 7. The Data Frame
### The R equivalent of the spreadsheet.

a<-list(c(1,2,3),"Blue",factor(c("A","B","A","B","B")))
a

cyl=factor(scan(text=
    "6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4"))
am=factor(scan(text=
    "1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0 1 1 1 1 1 1 1"))
levels(am)=c("auto","manual")
disp=scan(text=
    "2.62 2.62 1.77 4.23 5.90 3.69 5.90 2.40 2.31 2.75 2.75 4.52 4.52 4.52 
    7.73 7.54 7.21 1.29 1.24 1.17 1.97 5.21 4.98 5.74 6.55 1.29 1.97 1.56 
    5.75 2.38 4.93 1.98")
hp=scan(text=
    "110 110  93 110 175 105 245 62 95 123 123 180 180 180 205 215 230 66
    52 65 97 150 150 245 175 66 91 113 264 175 335 109")

car<-data.frame(cyl,disp,hp,am)
head(car)
summary(car)

names(car)
names(car)[4]="trans"
names(car)
car$am
car$trans

car[1:3,]
car[,3]
car$hp

hp[1]==car$hp[1]
hp[1]=112
hp[1]==car$hp[1]

ls()
rm(cyl,disp,hp,am)
ls()

car[[4]]
head(car[4])

car[5]

car$hp [2,3]

data(faithful)
summary(subset(faithful,eruptions<=3))

attach(car)
mean(hp)
hp[1]<-500
hp[1]==car$hp[1]

car[,5]<-as.numeric(levels(car$cyl)[car$cyl])
names(car)
names(car)[5]<-"cyl.numeric"

car$disp.per.cyl<-car$disp/car$cyl.numeric
names(car)

data(mtcars) # load the data
names(mtcars) # cols 1,5:8,10:11 not in our data
dim(car)
car<-cbind(car,mtcars[,c(1,5:8,10:11)])
dim(car)
head(car)

comment(car)<-"A data set derived from the mtcars dataset. Displacement is in liters"

###### V. Exercises ######

## 1)## Use the `mtcars` data (`data(mtcars)`) to answer these questions:  
# a) Which rows of the data frame contain cars that weigh more than 4000 pounds (the variable is `wt`, units are 1000 pounds).
# b) Which cars are these? (*Hint:* since rows are named by car name, use `row.names()`).
# c) What is the mean displacement (in inches^3^ ) for cars with at least 200 horsepower (`hp`).
# d) Which car has the highest fuel economy (`mpg`)?
# e) What was the fuel economy for the Honda Civic?

## 2)## Using the `mtcars` data create a new variable for horespower per unit weight (`hp/wt`). Is this a better predictor of acceleration (`qsec`; seconds to complete a quarter mile) than raw horsepower? (Hint - check out correlations between these variables and acceleration, or fit regressions for both models).

## 3)## Use the function `subset()` to return the cars with 4 cyclinders and automatic transmissions (`am` = `0`). (*Hint:* see `?subset`).

