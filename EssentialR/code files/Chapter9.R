#############################
## Chapter 9. Manipulating Data
### An introduction to data wrangling 

beans<-read.csv("../Data/BeansData.csv",header=TRUE,comm="#")
dim(beans);summary(beans)

apply(X=beans[,6:8],MARGIN=2,FUN=mean,na.rm=TRUE)

tapply(beans$rt.len,INDEX=list(beans$trt),FUN=mean,na.rm=TRUE)

tapply(beans$rt.len,list(beans$pot.size,beans$P.lev),mean,na.rm=TRUE)

tapply(beans$rt.len,list(paste(beans$pot.size,beans$P.lev)),mean,na.rm=TRUE)

aggregate(x=beans[,6:8],by=list(beans$pot.size,beans$phos),FUN=mean,na.rm=TRUE)

aggregate(x=beans[,6:8],by=beans[c(1,2)],FUN=mean,na.rm=TRUE)
aggregate(beans[,6:8],beans[c(1,2)],sd,na.rm=TRUE)

aggregate(beans[,6:8],beans[c(1,2)],function(x)(sd(x,na.rm=TRUE)/ (length(x)-sum(is.na(x)))^0.5))

par(mar=c(3,3,.5,0.5))
beans.means<-aggregate(beans[,6:8],beans[c(1,2)],mean,na.rm=TRUE)
barplot(beans.means$ShtDM)

par(mar=c(3,3,.5,0.5))
beans.means<-beans.means[order(beans.means$pot.size,beans.means$phos),]
barplot(beans.means$ShtDM)

par(mar=c(3,3,.5,0.5))
barplot(beans.means$ShtDM,col=c("white","grey70"),names.arg=
    paste(beans.means$pot.size,beans.means$phos,sep="\n"),ylab=
    "Shoot biomass (g)")
legend("topright",fill=c("white","grey70","grey50"),legend=c("LP","HP"))

data(PlantGrowth) 
head(PlantGrowth)

par(mar=c(3,3,0.5,0.5))
unstack(PlantGrowth)
pg=unstack(PlantGrowth,weight~group)
boxplot(pg)

summary(stack(pg))
summary(stack(pg,select=c(trt1,trt2)))
summary(stack(pg,select=-ctrl))

levels(PlantGrowth$group)
PlantGrowth$group2<-factor(PlantGrowth$group)
levels(PlantGrowth$group2)<-c("Ctrl","Trt","Trt")
summary(PlantGrowth)
unstack(PlantGrowth,weight~group2)

require(reshape)
data(iris)
iris$id<-row.names(iris)
head(melt(iris,id="id"))
tail(melt(iris,id="id"))
melt.iris<-melt(iris,id=c("id","Species"))
dim(melt.iris)
head(melt.iris)
tail(melt.iris)

cast(melt.iris, Species ~ variable,mean)
cast(melt.iris, Species ~ variable,range)

head(cast(melt.iris, Species + id ~ variable))

head(strsplit(as.character(melt.iris$variable),split=".",fixed=TRUE))

head(do.call(rbind,strsplit(as.character(melt.iris$variable),split=".",fixed=TRUE)))

melt.iris<-cbind(melt.iris,do.call(rbind,strsplit(as.character(melt.iris$variable),split=".",fixed=TRUE)))
names(melt.iris)[5:6]<-c("Part","Dimension")
head(melt.iris)

cast(melt.iris,Species~Dimension|Part,mean)
cast(melt.iris,Species~Dimension+Part,mean)

cast(melt.iris,Species~Dimension,mean)

head(cast(melt.iris,Species+id~Part+Dimension))

authors <- data.frame(
    surname = c("Tukey", "Venables", "Tierney", "Ripley", "McNeil"),
    nationality = c("US", "Australia", "US", "UK", "Australia"),
    deceased = c("yes", rep("no", 4)))
books <- data.frame(
    name = c("Tukey", "Venables", "Tierney", "Ripley", "Ripley", "McNeil", "R Core"),
    title = c("Expl. Data Anal.", "Mod. Appl. Stat ...", "LISP-STAT", "Spatial Stat.", "Stoch. Simu.", "Inter. Data Anal.", "An Intro. to R"),
    other.author = c(NA, "Ripley", NA, NA, NA, NA,"Venables & Smith"))
authors
books

(m1 <- merge(authors, books, by.x = "surname", by.y = "name"))
(m2 <- merge(books, authors, by.x = "name", by.y = "surname"))

merge(authors, books, by.x = "surname", by.y = "name", all = TRUE)

for (i in 1:5) print(i)
x<-c(2,5,7,23,6)
for (i in x) {cat(paste("i^2=",i^2,"\n"))}

# df[,3]=factor(df[,3])
# df[,5]=factor(df[,5])
# df[,6]=factor(df[,6])

# for(i in c(3,5,6)) df[,i]<-factor(df[,i])

par(mfrow=c(3,1),mar=c(3,3,0.5,0.5))
for (p in c(4,5,3)){
  barplot(beans.means[,p],col=c("white","grey70"),
    names.arg=paste(beans.means$pot.size,beans.means$phos,sep="\n"))
 # plot the pth column of beans.means
  }

###### VII. Exercises ######
## 1)## Load the data set "ufc" (the file is ufc.csv). This data shows diameter at breast height (Dbh) and Height for forest trees. Can you use `unstack()` to get the diameter data for white pine (`WP`)? Start by unstacking all the diameter data. Can you also get this data by logical extraction? (_Hint:_ use the function `which()`. If you really only wanted the data for one species logical extraction would probably be better.)

## 2)## For the data set ufc find the mean Dbh and Height for each species. (_Hint:_ aggregate is your friend for more than one response variable.) 

## 3)## Make a barplot showing these mean values for each species. Use beside =TRUE (stacking two different variables wouldn't make sense...). (_Hint:_ this will be easier if you make a new variable for the means from Q2. Look at ?barplot for the data type "height" must have - `as.matrix()` can be used to make something a matrix.) 

## 4)## The barplot in Q3 suggests a fair correlation between Dbh and height. Plot Height~DBH, fit a regression, and plot the line. What is the R^2^?

