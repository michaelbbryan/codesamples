# A test of knitr
# This is a comment
# a<-1:25
b<-sort(rnorm(25))
mean(b)
sd(b)
# mean and sd match the default values of sd=1 and mean=0
plot(a,b,type="l",col="red",lwd=2)
# figures are included


