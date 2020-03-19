## Chapter 17: Data Visualization III

## Boxplots
beans<-read.csv("../Data/BeansData.csv",header=TRUE,comm="#") # get data
names(beans)
par(mar=c(3.5,4.1,0.6,0.6))
with(beans,plot(trt,ShtDM)) # make plot


par(mar=c(4.1,4.1,0.6,0.6))
with(beans,plot(trt,ShtDM,col=c("white","grey60"),ylab="Shoot biomass (g)",xlab="",xaxt="n"))
abline(v=c(2.5,4.5),lty=2)
axis(side=1,at=c(1.5,3.5,5.5),labels=c(4,8,12),tick=FALSE,cex.axis=1.3)
legend("topright",legend=c("LP","HP"), fill=c("white","grey60"),bg="white")
mtext("Pot volume",side=1,line=2.5,cex=1.2)


par(mar=c(3.5,4.1,0.6,0.6))
with(beans,plot(trt,ShtDM,col=c("white","grey60"),ylab="Shoot biomass (g)",xlab="",xaxt="n",at=c(1.15,2.0,4.15,5,7.15,8)))


## Adding means to boxplots
beans2<-aggregate(beans[,6:8],by=list(beans$phos,beans$pot.size), mean,na.rm=TRUE) # get means
beans2<-cbind(beans2,aggregate(beans[,6:8],by=list(beans$phos, beans$pot.size) ,function(x)(sd(x,na.rm=TRUE)/((length(x)-sum(is.na(x)))^0.5)))[,3:5]) 
names(beans2)<-c("phos","pot.size","rt.len","ShtDM", "RtDM","rt.lense", "ShtDMse", "RtDMse")
beans2$type<-letters[1:6] # create the trt type variable
beans2 # check


par(mar=c(4.1,4.1,0.6,0.6))
with(beans,plot(trt,ShtDM,col=c("white","grey60"),ylab="Shoot biomass (g)",xlab="",xaxt="n"))
arrows(1:6,beans2$ShtDM-beans2$ShtDMse,1:6,beans2$ShtDM+beans2$ShtDMse,code=3,angle=90,length=0.1,lwd=2)
points(1:6,beans2$ShtDM,pch=23,cex=1.5,lwd=2,bg=c("white","grey60"))
abline(v=c(2.5,4.5),lty=2)
axis(side=1,at=c(1.5,3.5,5.5),labels=c(4,8,12),tick=FALSE,cex.axis=1.3)
legend("topright",legend=c("LP","HP"), fill=c("white","grey60"),bg="white",ncol=2)
mtext("Pot volume",side=1,line=2.5,cex=1.2)


## A Multi-panel Boxplot
# quartz(width=5,height=7) 
layout(matrix(c(1,2,3),nrow=3),heights=c(1,1,1.3)) #; layout.show(3)
par(mar=c(0,5,1,1),cex.axis=1.3, cex.lab=1.3)
# shoot biomass
with(beans,plot(trt,ShtDM,col=c("white","grey60"),ylab="Shoot biomass (g)",xlab="",xaxt="n",cex=1.3))
abline(v=c(2.5,4.5),lty=2)
legend("topleft",inset=c(-0.05,-0.05),"A",cex=2,bty="n")
legend("topright",legend=c("LP","HP"), fill=c("white","grey60"),bg="white",ncol=2)
par(mar=c(0,5,0,1))
# root biomass
with(beans,plot(trt,RtDM,col=c("white","grey60"),ylab="Root biomass (g)",xlab="",xaxt="n",cex=1.2,ylim=c(0,1.9)))
abline(v=c(2.5,4.5),lty=2)
legend("topleft",inset=c(-0.05,-0.05),"B",cex=2,bty="n")
par(mar=c(5,5,0,1))
# root length
with(beans,plot(trt,rt.len,col=c("white","grey60"),ylab="Root length (m)",xlab="",xaxt="n",cex=1.2))
abline(v=c(2.5,4.5),lty=2)
legend("topleft",inset=c(-0.05,-0.05),"C",cex=2,bty="n")
axis(side=1,at=c(1.5,3.5,5.5),labels=c(4,8,12),tick=FALSE,cex.axis=1.3)
mtext("Pot volume (L)",side=1,line=2.65)


## Barplots
with(beans2,barplot(ShtDM,ylim=c(0,max(ShtDM+ShtDMse))))
with(beans2,arrows(0.5:5.5, ShtDM+ShtDMse, 0.5:5.5, ShtDM-ShtDMse, length = 0.05, angle = 90, code=3))


par(mar=c(4.1,4.1,0.6,0.6),mfrow=c(1,2))
with(beans2,barplot(ShtDM,ylim=c(0,max(ShtDM+ShtDMse))))
with(beans2,arrows(0.5:5.5, ShtDM+ShtDMse, 0.5:5.5, ShtDM-ShtDMse, length = 0.05, angle = 90, code=3))
mp<-with(beans2,barplot(ShtDM,width=0.8,ylim=c(0,max(ShtDM+ShtDMse)))) 
with(beans2,arrows(mp, ShtDM+ShtDMse, mp, ShtDM-ShtDMse, length = 0.05, angle = 90, code=3))


## Creating a Polished Barplot
par(mar=c(4.1,4.1,0.6,0.6))
mp<-with(beans2,barplot(ShtDM,col=c("white","grey60"),width=0.8,ylim=c(0,max(ShtDM+ShtDMse)*1.1),ylab="Shoot biomass (g)",xlab="",xaxt="n")) # make the plot
box(which="plot") # put a box around it
with(beans2,arrows(mp, ShtDM+ShtDMse, mp, ShtDM-ShtDMse, length = 0.05, angle = 90, code=3)) # add error bars
abline(v=c(mean(mp[2:3]),mean(mp[4:5])),lty=2) #add dashed separator lines
legend("topright",inset=0.02,legend=c("LP","HP"), fill=c("white","grey60"),bg="white",cex=0.9) # legend
axis(side=1,at=mp[c(1.5,3.5,5.5)],labels=c(4,8,12),tick=FALSE,cex.axis=1.3)
mtext("Pot volume (L)",side=1,line=2.65)


## Creating a Multi-panel Barplot

# quartz(width=5,height=7)
layout(matrix(c(1,2,3),nrow=3),heights=c(1,1,1.3)) # make layout
par(mar=c(0,5,1,1),cex.axis=1.3, cex.lab=1.3) # par settings
mp<-with(beans2,barplot(ShtDM,col=c("white","grey60"),ylim=c(0,max(ShtDM+ShtDMse)*1.14),ylab="Shoot biomass (g)",xlab="",xaxt="n")) #plot 1
box(which="plot")
with(beans2,arrows(mp, ShtDM+ShtDMse, mp, ShtDM-ShtDMse, length = 0.05, angle = 90, code=3)) # err bars
divs<-c(mean(mp[2:3]),mean(mp[4:5])) # calculate divider locations
abline(v=divs,lty=2)
text(mp,(beans2$ShtDM+beans2$ShtDMse),c("a","b","a","b","a","b"),pos=3,cex=1.15) # add letters
legend("topleft",inset=c(-0.05,-0.05),"A",cex=2,bty="n")

par(mar=c(0,5,0,1))
with(beans2,barplot(RtDM,col=c("white","grey60"),ylim=c(0,max(RtDM+RtDMse)*1.14),ylab="Root biomass (g)",xlab="",xaxt="n")) # plot 2
box(which="plot")
with(beans2,arrows(mp, RtDM+RtDMse, mp, RtDM-RtDMse, length = 0.05, angle = 90, code=3)) # err bars
abline(v=divs,lty=2)
text(mp,(beans2$RtDM+beans2$RtDMse),c("ab","b","a","b","ab","b"),pos=3,cex=1.15) # add letters
legend("topleft",inset=c(-0.05,-0.05),"B",cex=2,bty="n")

par(mar=c(5,5,0,1))
with(beans2,barplot(rt.len,col=c("white","grey60"),ylim=c(0,max(rt.len+rt.lense)*1.4),ylab="Root length (m)",xlab="",xaxt="n")) # plot 3
box(which="plot")
with(beans2,arrows(mp, rt.len+rt.lense, mp, rt.len-rt.lense, length = 0.05, angle = 90, code=3)) # err bars
abline(v=divs,lty=2)
text(mp,(beans2$rt.len+beans2$rt.lense),c("b","c","a","c","ab","b"),pos=3,cex=1.15) # add letters
legend("topleft",inset=c(-0.05,-0.05),"C",cex=2,bty="n")
axis(side=1,at=mp[c(1.5,3.5,5.5)],labels=c(4,8,12),tick=FALSE,cex.axis=1.3)
mtext("Pot volume (L)",side=1,line=2.65)
legend("topright",inset=0.02,legend=c("LP","HP"), fill=c("white","grey60"),bg="white",cex=0.9)


## Exercises
##1)## The "ufc" data we examined in last chapter's exercises can be loaded from ufc.csv (in the "data" directory of EssentialR). This contains data on forest trees, including `Species`, diameter (in cm, measured 4.5 feet above ground and known as "diameter at breast height" or `Dbh`), and `height` (in decimeters). Make a single barplot showing both variables (`Dbh` and `Height`) for each `Species` and include errorbars (either SE of the mean or 95% CI) and a legend. *Hint*: In Ch 15 we saw how to add a secondary *y*-axis - with a barplot you need to specify the *x*-axis limits and change the `width` and `space` arguments to make the bars narrower and to get the bars to plot side-by-side.

##2)## Using the ufc data create a single boxplot that also shows the mean and standard error for both variables for the 5 most common (greatest frequency) species. *Hint*: create a new dataframe with only the 5 most common species - and be sure to check the levels for `Species` in the new dataframe - you may need to use `droplevels()` to get rid of unused levels.

