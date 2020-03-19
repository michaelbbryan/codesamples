#############################
## Chapter 3. Quantitative Variables
### Creating and using continuous variables in R  

mp3<-scan(text="5.3 3.6 5.5 4.7 6.7 4.3 4.3 8.9 5.1 5.8 4.4")
mean(mp3)
var(mp3)
sd(mp3)
median(mp3)
summary(mp3)

quantile(mp3,c(.25,.75))
quantile(mp3,c(.18,.36,.54,.72,.90))

t=(mean(mp3)-4.5)/(sd(mp3)/sqrt(length(mp3)))
pt(t,df=length(mp3)-1,lower.tail=FALSE)*2 # *2 for 2 sided test

t.test(mp3,mu=4.5)

mp3[8]<-10.8
mean(mp3)
median(mp3)
mean(mp3,trim=0.1)

IQR(mp3)
median(abs(mp3-median(mp3)))*1.4826
mad(mp3)

mp3[8]<-8.9
mp3<-c(mp3,scan(text="4.9 5 4.9 5.4 6.2 5.6 5.1 5.8 5.5 6.7 7"))

par(mar=c(3,3,1.5,0.5))
par(mfrow=c(1,2)) # split the plot
hist(mp3)
hist(mp3,prob=TRUE,col="grey")

par(mar=c(3,3,1.5,0.5))
par(mfrow=c(1,2)) # split the plot
hist(mp3)
lines(density(mp3),col="red")
hist(mp3,probability=TRUE,col="grey")
lines(density(mp3),col="red")

par(mar=c(3,3,0.5,0.5))
hist(mp3,probability=TRUE,col="grey",ylim=c(0,0.6))
lines(density(mp3),col="red")

par(mar=c(3,3,1.5,0.5))
par(mfrow=c(1,2)) # split the plot
a<-rnorm(n=40,mean=7,sd=2)
hist(a,prob=T,col="grey")
hist(a,prob=T,col="grey",breaks=seq(0.5,14.0,1.5))

par(mar=c(3,3,0.5,0.5))
par(mfrow=c(1,2))
boxplot(mp3)
boxplot(mp3, notch=TRUE,col="cornsilk")

plot(mp3)

par(mar=c(2.1,1,1,1))
par(mfrow=c(3,1))
stripchart(mp3)
stripchart(mp3,method="jitter")
stripchart(mp3,method="stack")

stem(mp3)
stem(mp3,scale=2)

par(mar=c(3,3,0.5,0.5))
m.r = cut(mp3,breaks=c(3:9)) # specify the breaks
m.r
m.r[which(mp3==5.0)] # values of 5.0 coded as (4,5]

table(m.r)
levels(m.r)
levels(m.r) <- c("tiny","small","medium","med-large","large","huge")
table(m.r)
plot(m.r)

###### VI. Exercises. ######

## 1)## The R function `rnorm(n,mean,sd)` generates random numbers from a normal distribution. Use `rnorm(100)` to generate 100 values and make a histogram. Repeat two or three times. Are the histograms the same?

## 2)## Make a histogram from the following data, and add a density estimate line to it. (use `scan()` to enter the data:) Try changing the bandwith parameter for the density estimate (see `?density`)
26 30 54 25 70 52 51 26 67 18 21 29 17 12 18 35 30 36 36 21 24 18 10 43 28 15 26 27

## 3)## Using the data above compare the mean and median and the standard deviation, IQR and the MAD.

## 4)## Use the function `boxplot()` to find possible outliers in `t` (outliers shown as individual points). Compare the mean and median of the data with the outliers removed. Compare the standard deviation and MAD for the data with the outliers removed.

