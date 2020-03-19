##### EXTRA: Simulating a hypothesis test for a qualitative variable ----
## sample() will randomly choose values, 
## sample(1:6,replace=TRUE): rolling a fair die
## sample(1:6,size=50,replace=TRUE): rolling the die 50 times.

sample(x=1:6,size=50,replace=TRUE) # rolling a die 50 times
sum(sample(1:6,50,TRUE)==6) # how many times is it 6?

## use the up arrow in the console to repeat this - the number of 6's varies. 
## repeat this 100 times to see how frequent a value of 12 or greater is. 
## use a loop (see Chapter 1).

die=rep(NA, 100)# vector to store results
for(i in 1:100){die[i]=sum(sample(1:6,50,TRUE)==6)} 
# loop 100 times
table(die)

hist(die, prob=TRUE,col="grey")
abline(v=12,col="red")
  
sum(die>=12)


# much faster than rolling a die 5000 times and recording the results!
