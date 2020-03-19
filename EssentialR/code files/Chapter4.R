#############################
## Chapter 4. Documenting Your Work
### How not to forget what you were doing  

# Open a new R script file. Copy the following into it:
#-------------------------------------
# A test of knitr
# This is a comment
a<-1:25
b<-sort(rnorm(25))
mean(b)
sd(b)
# mean and sd match the default values of sd=1 and mean=0
plot(a,b,type="l",col="red",lwd=2)
# figures are included
#-------------------------------------

library(knitr) # load the package
spin("Ch4Demo1.R") # compile your document to Rmd
spin("Ch4Demo1.R",format = "Rhtml") # compile your document to html

knit(spin("Ch4Demo1.R"),output="Ch4Demo1.html")

rm(a)

`
Error in plot(a, b, type = "l", col = "red", lwd = 2) : 
  object 'a' not found

`
Quitting from lines 3-12 (Ch4Demo1.spin.Rmd) 
Error in xy.coords(x, y, xlabel, ylabel, log) : 
  'x' and 'y' lengths differ
Calls: <Anonymous> ... withVisible -> eval -> eval -> plot -> plot.default -> xy.coords
Execution halted

spin("Ch4Demo1.R")

###### VI. Exercises. ######

## 1)## Take you code from the Ch2 and Ch3 HW and paste it into a single .R file. Test it to make sure it runs. Add comments where needed in the file to discuss/describe the results. Run the code from the console to check it (select all and ctrl+enter). Now compile the file. (_Hint:_ Before testing the code clear your workspace (Session>Clear Workspace) to be sure the code doesn't rely on anything not in your workspace.)

