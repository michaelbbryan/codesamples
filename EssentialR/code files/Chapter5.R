#############################
## Chapter 5. Help in R
### What to do when you need help.

# If I have a matrix x as follows:
  x <- matrix(1:8, nrow=4, ncol=2,
                dimnames=list(c("A","B","C","D"), c("x","y"))
#  x
#    x y
#  A 1 5
#  B 2 6
#  C 3 7
#  D 4 8

# how can I turn it into a dataframe with 8 rows, and three columns named `row', `col', and `value', which have the dimension names as the values of `row' and `col', like this:
#    x.df
#     row col value
#  1    A   x      1

###### VI. Exercises ######
# To reinforce what you learned in Chapter 4, write up your answers and code in an R script file and compile it to html using `knitr`. 

## 1)## Practice running help examples with `?hist`, and `?plot` (in {graphics}): What can you learn about these functions?

## 2)## Follow some links from `?hist`, and `?plot` and run some examples - what did you learn from any of these linked files?

## 3)## Use www.RSeek.org to find a method to calculate the "outer product" of 2,4,6,8 and -2,-1,0,1,2,3.

