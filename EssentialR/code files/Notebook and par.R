# Showing how to use some graphics commands with knitr

op<-par(mfrow=c(1,2)) # split plotting window and save old settings
plot(1:10,rnorm(10))
# first of 2 plots is done, but this plot will not be printed until both are done
plot(1:10,rnorm(10))
# plot only included after 2nd part is done

# plot without restoring par
plot(1:10,rnorm(10))
# note that the plot is still split and the second plot is missing here
# this plot won't be plotted into the file until either:
# a) plot is called again and the second plot in the window is complete *or*
# b) graphics parameters are reset

par(op) # restore original graphics parameters

# plot after restoring par
plot(1:10,rnorm(10))
# adding a graphical command after the plot command will delay insertion of the plot
abline(v=3,h=1,col="red")
# as seen here.

