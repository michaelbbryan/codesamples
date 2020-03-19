
# to make a plot of two variables revenue & cost over time
import matplotlib.pyplot as plt

plt.axes(.05, 0.05, 0.425, 0.9)  # lower left corner x & y positions, width & height in numbers between 0 & 1
plt.plot(time, revenue, color='red', label='Revenue')  # make revenue red, call it Revenue in the legend
plt.xlabel('Months')
plt.title('Revenue')

plt.axes(.525, 0.05, 0.425, 0.9) # next plot area
plt.plot(time, cost, color='blue')   # make costs blue
plt.xlabel('Months')
plt.title('Cost')
plt.show()  # renders the plot

# alternatively you can use plt.subplot(nrows,ncols, which cell to activate)
plt.tight_layout()   # presses the two plots together

# set the axis limits explicitly
plt.xlim( (xmin,xmax) )
plt.ylim( (ymin,ymax) )
# or equivalently  axis command
plt.axis( (xmin,xmax,ymin,ymax) )
plt.axis( 'off' )  # turn off axis lines and labels
plt.axis( 'equal' )  # equal scaling on both x & y
plt.axis( 'square' ) # force square plot sahep
plt.axis( 'tight' )  # sets xlim, ylim to their min & max

plt.savefig('books_read.png')  # save the image to a file

plt.anotate('Product Announcement',(3,4))  # puts text on the image  see also

plt.style.available # to get a list of plotting styles available
plt.style.use('ggplot')  # gray with white grids

plt.legend(loc='lower center')  # activate a legend box with any labeled items

import numpy as np
u = np.linspace(-100,100,num=201)   # create a vector from -100 to +100 incrementing by 1
v = np.linspace(-50,50,num=201)     # incrementing by 0.5
X,Y = np.meshgrid(x,y)  # combine the u and v dimensions to make a grid of combinations
z = X**2/25 + Y**2/4    # cast a function over the X,Y grid

plt.pcolor(z)  # take the values of the z function and plot a surface of color
               # prints from bottom left to top