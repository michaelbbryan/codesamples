#############################
## Chapter  1. Basics 
### The console, the editor, and basic syntax in R

2 + 2
4*5
6^2
3+5*2
(3+5)*2
# 2+2

a = 5# = 

a

a*2
a
a=a*2

sms=c(0,1,2,0,0,0,1)

sms + 5
sms * 5
sms/2
sort(sms)

sms[3]
sms[2:4]
sms[-3]
sms[-(2:3)]
sms[-c(2,3,7)]

sms>0
sms[sms>0]

sum(sms>0)

which(sms>0)
sms[which(sms>0)]
mean(sms[which(sms>0)])

sms
sms[1]=1
sms

1:50

x=c("a","b","c","d","e","f","g","h","i")
y=21:30
z=c(2,4,6)

x[y]

x[z]

y[z]
z[y]

x[rev(z)]
y[x]

y*z

# Function | Description
# ---------|------------
# sd()     | standard deviation
# median() | median
# max()    | maximum
# min()    | minimum
# range()  |maximum and minimum
# length() | number of elements of a vector
# cummin() | cumulative min (or max cummax() )
# diff()   | differences between successive elements of a vector

for (i in 1:27) {cat(letters[i])}
for (i in sample(x = 1:26,size = 14)) cat(LETTERS[i])

x<-c("Most","loops","in","R","can","be","avoided")
for (i in x){cat(paste(i,"!"))}

###### VI. Exercises. ######

## 1)## Enter the following data in R and call it `P1`:  
# `23,45,67,46,57,23,83,59,12,64`  
# What is the maximum value? What is the minimum value? What is the mean value?

## 2)## Oh no! The next to last (9th) value was mistyped - it should be 42. Change it, and see how the mean has changed. How many values are greater than 40? What is the mean of values over 40?
# Hint: how do you see the 9th element of the vector `P1`?

## 3)## Using the data from problem ##2## find:  
# a) the sum of `P1`  
# b) the mean (using the sum and `length(P1)`)
# c) the log(base10) of `P1` - use `log(base=10)`  
# d) the difference between each element of `P1` and the mean of `P1`

## 4)## If we  have two vectors, `a=11:20` and `b=c(2,4,6,8)` predict (_without running the code_) the outcome of the following (After you make your predictions, you can check yourself by running the code):  
# a) `a*2`  
# b) `a[b]`  
# c) `b[a]`  
# d) `c(a,b)`  
# e) `a+b`  
