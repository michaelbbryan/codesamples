## Chapter 20:  Writing functions


## Defining a function

fn.demo<-function(x,y) x^2-y
fn.demo(4,5)


fn.demo<-function(x,y=5) {
  x^2-y}
fn.demo(4)
fn.demo(4,y=2)
fn.demo(y=2, x=4)


# if(exists("z")==TRUE){rm(z)}
# rm(z)
fn.demo<-function(x,y=5,verbose=FALSE) {
  z<- x^2-y
  if(verbose==TRUE) {cat(paste(x," squared minus ",y," = ",z,sep=""))} else {  return(z)}
  }
fn.demo(5)
fn.demo(3,ver=TRUE)
z


fn.demo<-function(x,y=5,verbose=FALSE) {
  z<- x^2-y
  if(verbose==TRUE) {cat(paste(x," squared minus ",y," = ",z,sep=""))} else {  return(z)}
  z ## <- added
  }
fn.demo(5)
fn.demo(5,ver=TRUE)


fn.demo<-function(x,y=5) {
  c(x,y,x^2-y)
  }
fn.demo(6)
fn.demo(6)[3]
a<-fn.demo(3.7); a


a<-5
bad.fn<-function(b=7){a<<-b}
a
bad.fn(14)
a


## Finding and preventing errors

fn.demo<-function(x,y=5) {
  z<- x+10-y
  return(z)
  }


fn.demo(x="black")


debug(fn.demo)
fn(demo,x="black")


fn.demo<-function(x,y=5) {
  if (is.numeric(x)==FALSE | is.numeric(y)==FALSE) stop ("don't be ridiculous \n x & y must be numeric")
  z<- x+10-y
  return(z)
  }
fn.demo(x="black")


mean.se<-function(x){
  m<-mean(x)
  se<-sd(x)/(sqrt(length(x)))
  cat(paste("mean = ",m,"; se = ",se,"\n"))
}
a<-c(2,3,4,5,6)
mean.se(a)
b<-a; b[3]<-NA
mean.se(b)


mean.se<-function(x){
  m<-mean(x,na.rm=TRUE)
  se<-sd(x,na.rm=TRUE)/(sqrt(length(x)))
  cat(paste("mean = ",m,"; se = ",se,"\n"))
}
mean.se(a)
mean.se(b)


mean.se<-function(x){
  m<-mean(x,na.rm=TRUE)
  se<-sd(x,na.rm=TRUE)/(sqrt(sum(is.na(x)==FALSE)))
  cat(paste("mean = ",m,"; se = ",se,"\n"))
}
mean.se(a)
mean.se(b)


## Creating a package

install.packages("devtools")
install.packages("roxygen2")
library(devtools)
library(roxygen2)


create("easy.demo")

###### Note special comment format for documentation: #'

#' Mean and Standard Error
#'
#' This function returns mean and standard error of the mean.
#' @param x An object whose mean and se will be returned.
#' @keywords summary
#' @export
#' @examples
#' a <- rnorm(n=15,mean=6,sd=4)
#' mean_se(a)


setwd("easy.demo")
document()
setwd("..")


install("easy.demo")


meanANDse<-function(x){
  m<-mean(x,na.rm=TRUE)
  se<-sd(x,na.rm=TRUE)/(sqrt(sum(is.na(x)==FALSE)))
  cat(paste("mean = ",m,"; se = ",se,"\n"))
}


meanANDse(a)


## Exercises

##1)## Write a function that does something interesting or amusing. The goal is not massive complexity, just that you play around a bit with something that is a somewhat more complex than the trivial examples we've included here.

If you're at a loss for ideas here are a few: 1) calculate the difference between row and column sums of a square matrix; 2) take a text string and extract numbers from it to generate several random polygons; 3) extract coefficients and calculate their 95% confidence intervals and plot them.


