#############################
## Chapter 2. Qualitative Variables
### Creating and using categorical variables in R  

cols<-c("Blue","Blue","Red","Red","Blue","Yellow","Green")
summary(cols);cols[2]
cols<-factor(cols); cols[2]

str(cols); summary(cols)
levels(cols)

table(cols)
b<-table(cols)
b[3]
b[3]*4

par(mar=c(3,4.0,1,0.1),mfrow=c(1,2))
barplot(table(cols))
plot(cols)
barplot(b/length(cols), col=c("blue", "green", "red", "yellow"),ylab="Proportion")

par(mar=c(3,4.0,1,0.1),mfrow=c(1,2))
barplot(b/length(cols), col=c("blue", "green", "red", "yellow"),ylab="Proportion")
barplot(table(cols)/length(cols), col=levels(cols),ylab="Proportion")

cols=="Red"

par(mfrow=c(1,2),mar=c(3,3,0.5,0.5))
pie(table(cols))
pie(b, col=c("blue", "green", "red", "yellow"))

par(mar=c(3,3,0.5,0.5))
a<-factor(scan(text="2 4 3 3 2 1 1 2 3 4 2 3 3 4 1 3 2 1 4 3 2 4"))
# scan(text="some text string with spaces separating value")
table(a)
levels(a)<-c("<14","15-24","25-34",">35")
table(a)
barplot(table(a))

a<-c(1,1,4,5)
str(a)
(a<-as.factor(a))
str(a)
levels(a)

as.numeric(a)

as.numeric(as.character(a))

(b<-c("-.1"," 2.7 ","B"))
str(b)
as.numeric(b)

cols<-factor(c("Blue","Blue","Red","Red","Bleu","Yellow","Green"))
levels(cols)

levels(cols)<-c("B","B","G","R","Y")
levels(cols)

cols<-factor(c("Blue","Blue","Red","Red","Bleu","Yellow","Green"))
levels(cols)<-c("Blue","Blue","Green","Red","Yellow")
levels(cols)

cols<-factor(c("Blue","Blue","Red","Red","Blue","Yellow","Green"))
levels(cols)
levels(cols)<-c("Yellow","Blue","Green","Red")
levels(cols)

x<-factor(c("L","M","H"))
y=factor(x,levels=c("L","M","H"))
x;y

z=factor(x,levels=c("L","M","H"),ordered=TRUE)
z

str(y)
str(z)

y>"L"
z>"L"

prop.test(x=12,n=50,p=1/6,alt="greater")

sample(x=1:6,size=50,replace=TRUE) # rolling a die 50 times
sum(sample(1:6,50,TRUE)==6) # how many times is it 6?

die=rep(NA, 100)# vector to store results
for(i in 1:100){die[i]=sum(sample(1:6,50,TRUE)==6)}
table(die); sum(die>=12)

###### VII. Exercises. ######

## 1)## The function `rep()` makes repeated series - for example try `rep(4,times=5)` and `rep(c(1,2),each=3)`. Use `rep()` to enter the sequence `1 1 1 1 2 2 2 2 3 3 3 3` repeated 3 times. Now convert it to a factor with the levels "Low","Medium", and "High". Can you change the levels to "Never","Rarely","Sometimes"?

## 2)## Convert the factor from Problem 1 into a character vector. Can you convert the character vector to a numeric vector?

##3)## Earlier we used the factor variable `a` (created by `a<-factor(scan(text="2 4 3 3 2 1 1 2 3 4 2 3 3 4 1 3 2 1 4 3 2 4"))`). Convert `a` into an ordered factor with levels `"Sm","Med","Lg","X-Lg"` (with `1` for "Sm"). How many values are equal to or larger than "Lg"?

## 4)## We can use the output of `table()` with `barplot()` to view the frequency of levels in a factor. Extending our discussion of rolling die, we can use this to view the liklihood of rolling any particular value on one die using `barplot(table(sample(x=1:6,size=1000,replace=TRUE)))`. How does this change if we add the rolls of 2 dice together? (_Hint:_ recall that vectors are added in an element-wise fasion, and that `sample()` returns a vector). 

## Extra## What happens if the dice are not the same size?

