#############################
## Chapter 8. Importing Data
### Getting your data into R  

my.data<-read.csv("C:/file-path/W101-2010.csv",comm="#")
my.data <- read.table("W101-2010.csv",comm="#",header=TRUE,sep=",") 
my.data <- read.table(file.choose(),header=TRUE) 

# my.data <- read.delim("clipboard") ## Windows  
# my.data <- read.table("clipboard",header=T) ## linux  
# my.data <- read.table(pipe("pbpaste"),header=TRUE) ## Mac  

setwd("~/Dropbox/R class/EssentialR")

my.data <- read.table("../Data/Ex1.txt",header=TRUE) 
dim(my.data);summary(my.data)
my.data <- read.delim("../Data/Ex1.txt",header=TRUE) 
dim(my.data);summary(my.data)

my.data <- read.table("../Data/Ex2.txt",header=TRUE) # produces an error
my.data <- read.table("../Data/Ex2.txt",header=TRUE,sep="\t") # no error message
dim(my.data);summary(my.data) # but an NA was introduced

my.data <- read.delim("../Data/Ex2.txt",header=TRUE)
head(my.data)
my.data <- read.delim("../Data/Ex2.txt",header=TRUE, comment.char="#") 
my.data <- read.delim("../Data/Ex2.txt",header=TRUE, comm="#") 
dim(my.data);summary(my.data)

my.data <- read.table("../Data/Ex3.txt",header=TRUE)
my.data <- read.table("../Data/Ex3.txt",header=TRUE,sep="\t") # produces an error
my.data <- read.delim("../Data/Ex3.txt",header=TRUE, comment.char="#") # no error
head(my.data) # but wrong 

###### V. Exercises ######

## 1)## Find (or invent) some data (not from the "Data" directory) and import some data into R. It is good practice to be sure your .txt (or.csv) file includes a comment line with units! 
# a) what did you have to do to "clean it up" so it would read in?
# b) are you satisfied with the console output of `summary(yourdata)`?

## 2)## The spreadsheet "StatesData.xls" located in the `Data` directory in your EssentialR folder contains some (old) data about the 50 US states, and includes a plot with a regression line. Clean this data up and import it into R. You should be able to fit a regression that mimics the plot in the spreadsheet. What is the p-value for the slope in this regression?

