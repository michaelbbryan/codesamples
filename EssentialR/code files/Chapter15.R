##  Chapter 15: Visualizing Data I

## Scatterplot
DT<-read.delim("../Data/DataVizEx1.txt") 
summary(DT) 

par(mar=c(3,3,0.5,0.5),mfrow=c(1,2))
with(DT, plot(SeedDen,Den1)) # make the plot
plot(Den1~ SeedDen,data=DT,col=Manag)

## Adding lines
par(mar=c(3,3,0.5,0.5),mfrow=c(1,2))
with(DT, plot(SeedDen,Den1,col=Manag))
with(DT,lines(SeedDen,Den1))
with(DT, plot(SeedDen,Den1,col=Manag)) # second plot
lines(x=c(1000,2000,500),y=c(30,45,27)) # not same as
lines(x=c(500,1000,2000),y=c(27,30,45)-1,col="red") # -1 offset


## Polished scatterplot
op<-par(mar=c(4,4.5,0.5,0.5))
sym<-c(21,24) # define vector of symbols
with(DT, plot(SeedDen,Den1,pch=sym[Manag],ylab=expression(paste("Weed density (plants ",m^-2,")")),xlab=expression(paste("Weed seedbank (seeds " ,m^-2, ")")))) # plot with nice axis labels
lines(DT$SeedDen[DT$Manag=="C"],DT$Den1[DT$Manag=="C"],lty=1) # add line for trt C
lines(DT$SeedDen[DT$Manag=="O"],DT$Den1[DT$Manag=="O" ],lty=2) # add line for trt O
legend("bottomright",inset=0.025,pch=sym,lty=1:2,c("Conventional","Hebicide Free")) # add legend

## Introducing layout()
layout(matrix(c(1,2,3,3,0,4),nrow=3,byrow=TRUE),heights=c(1,1.5,1),widths=c(1,1.5))
layout.show(4) # show the first 4 plots in the layout

## Multipanel Scatterplot
layout(matrix(c(1,2,3),nrow=3),heights=c(1,1,1.3))
sym<-c(21,24) # plotting characters to use
par(mar=c(0.1,4.3,0.1,1),bty="l") # set margins and plot frame type
   ## plot 1
with(DT,plot(SeedDen,DT[,7],pch=sym[Manag],xaxt="n",xlab="",ylab=""))
lines(DT$SeedDen[DT$Manag=="C"],DT[DT$Manag=="C",7],lty=1)  
lines(DT$SeedDen[DT$Manag=="O"],DT[DT$Manag=="O",7],lty=2) 
text(300,max(DT[,7])*0.97,"Mid season density",pos=4,cex=1.2)
mtext(side=2,line=2.5,at=-1,text=expression(paste("Weed density (plants ",m^-2,")")),cex=0.9)
legend("bottomright",inset=0.025,pch=sym,lty=1:2,c("Conventional","Herbicide free"))
   ## plot 2
with(DT,plot(SeedDen,DT[,8],pch=sym[Manag],xaxt="n",xlab="",ylab=""))
lines(DT$SeedDen[DT$Manag=="C"],DT[DT$Manag=="C",8],lty=1)  
lines(DT$SeedDen[DT$Manag=="O"],DT[DT$Manag=="O",8],lty=2) 
text(300,max(DT[,8])*0.97,"Final density",pos=4,cex=1.2)
   ## plot 3
par(mar=c(4.1,4.3,0.1,1)) # change margins
with(DT,plot(SeedDen,DT[,4],pch=sym[Manag],xaxt="n",xlab="",ylab=""))
lines(DT$SeedDen[DT$Manag=="C"],DT[DT$Manag=="C",4],lty=1)  
lines(DT$SeedDen[DT$Manag=="O"],DT[DT$Manag=="O",4],lty=2) 
text(300,max(DT[,4])*0.97,"Final biomass",pos=4,cex=1.2)
  axis(side=1,at=seq(500,3000,500))
  mtext(side=1,line=2.5,text=expression(paste("Weed seedbank (seeds ",m^-2,")")),cex=0.9)
  mtext(side=2,line=2.5,text=expression(paste("Biomass (g ",m^-2,")")),cex=0.9)

## Loops for multipanel plots
par(mfrow=c(3,1),oma=c(4.1,0,3,0),mar=c(0.1,4.3,0.1,1),bty="l")
vars<-c(7,8,4) # the column numbers for each panel's response variable
sym<-c(21,24) # plotting characters to use
labs<-c("","","","Final biomass","Rye","Rye termination","Mid season density","Final density") # plot labels
for (i in vars){ # begin loop for panels
   with(DT,plot(SeedDen,DT[,i],pch=sym[Manag],xaxt="n",xlab="",ylab="")) # plot the ith column
   lines(DT$SeedDen[DT$Manag=="C"],DT[DT$Manag=="C",i],lty=1) # add lines
   lines(DT$SeedDen[DT$Manag=="O"],DT[DT$Manag=="O",i],lty=2) 
   text(300,max(DT[,i])*0.97,labs[i],pos=4,cex=1.2)
   if(i==4){ # add x axis for the last plot only (i==4)
      axis(side=1,at=seq(500,3000,500))
      mtext(side=1,line=2.5,text=expression(paste("Weed seedbank (seeds ",m^-2,")")),cex=0.9)
      mtext(side=2,line=2.5,text=expression(paste("Biomass (g ",m^-2,")")),cex=0.9)
   }
   if(i==7) {
    mtext(side=2,line=2.5,at=-1,text=expression(paste("Weed density (plants ",m^-2,")")),cex=0.9) # y axis label for first 4 plots
    legend(1100,22,legend=c("Conventional","Herbicide free"),pch=sym,lty=c(1,2),ncol=2,xpd=NA)
    } # y axis for last plot
} # end loop for panels

## Secondary axis
op<-par(mar=c(4.1,4.1,2,4.1))
beans<-read.csv("../Data/BeansData.csv",comm="#") # load data
with(beans,plot(ShtDM,RtDM,xlab="Shoot biomass (g)",ylab="Root biomass (g)"))
par(new=TRUE)
with(beans,plot(ShtDM,rt.len,xaxt="n",yaxt="n",ylab="", xlab="", pch=24,bg="grey"))
axis(side=4)
mtext(side=4,line=3,"Root length (m)")
par(op)
legend("topleft",inset=0.01,pch=c(21,24),pt.bg=c("white","grey"),legend=c("Biomass","Density"),xpd=NA)

##  Exercises
##1)## We'll revisit the electric bill data once more. In the Chapter 13 exercises we fit an ANCOVA to this data. Plot this model, showing the two curves and two parts of the data with distinct symbols, and with properly formatted axes and labels (i.e., Kilwatt hours per day should be shown as "KWHd^-1^".)

##2)## Using the electric bill data, plot daily energy use (`kWhd.1`) as a function of average temperature (`avgT`). Add a second *y* axis to show cost. Include a legend.





