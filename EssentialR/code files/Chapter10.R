#############################
## Chapter 10. Working with multiple variables
### Some basic tools for multivariate data  

data(mtcars)
summary(mtcars)

for (i in c(2,8,9,10,11)){mtcars[,i]=factor(mtcars[,i])}
names(mtcars)[9]="trans"
levels(mtcars$trans)<-c("auto","manual")
summary(mtcars)

with(mtcars,table(carb,cyl,trans))

pairs(mtcars[,-c(2,8,9,10,11)])

require(lattice)

par(mar=c(3,3,2,0.5))
histogram( ~ hp | cyl , data = mtcars)
bwplot( ~ hp | cyl , data = mtcars)

par(mar=c(3,3,2,0.5))
xyplot(mpg ~ disp | trans, data=mtcars)

par(mar=c(3,3,2,0.5))
plot.regression = function(x,y) {;
  panel.xyplot(x,y);
  panel.abline(lm(y~x));
}
xyplot(mpg ~ wt | gear, panel = plot.regression,data=mtcars)

anat<-read.table("../Data/anatomy-pilot-simple.txt",header=TRUE,sep="\t")
summary(anat)
for(i in c(1,3)) anat[,i]<-factor(anat[,i]) # cols 1,3 to factors
levels(anat$media.rep)<-c("R1","R1","R2","R2") # r1,2 to R1,2
anat$CellSize.avg<-rowMeans(anat[,11:14]) # avgCellSize
anat$m.Loc<-factor(paste(anat$media.rep,anat$Loc)) # combined levels

anat<-anat[,-(11:15)]
names(anat)
summary(anat)

pairs(anat[,-(1:4)])

by(data=anat[,7:10],INDICES= list(anat$media.rep,anat$Loc),FUN= colMeans)

pca1<-prcomp(mtcars,center = TRUE,scale. = TRUE)
summary(pca1)
screeplot(pca1)
biplot(pca1)
pca1$rotation

wrong.pca<-prcomp(mtcars)
summary(wrong.pca)
screeplot(wrong.pca)
biplot(wrong.pca)


anat.means<-aggregate(anat[,5:11],by=anat[c(1,4)],mean,na.rm=TRUE)
rownames(anat.means)<-with(anat.means,paste(Gtype,Loc))

plot(hclust(dist(scale(mtcars))))

hc<-hclust(dist(scale(mtcars)))
dendro<-as.dendrogram(hc)
par(mar=c(3,0.5,0.5,5))
plot(dendro, horiz=TRUE)

data(iris)
kcl<-kmeans(iris[,-5],3,nstart=3)
table(kcl$cluster,iris$Species)

par(mfrow=c(1,2))
plot(jitter(iris$Petal.Length),jitter(iris$Sepal.Width),col=kcl$cluster,main="K-means",xlab="Petal length",ylab="Sepal width")
plot(jitter(iris$Petal.Length),jitter(iris$Sepal.Width),col=iris$Species,main="Species",xlab="Petal length",ylab="Sepal width")

###### VI. Exercises ######
## 1)## The built in dataset `iris` has data on  four floral measurements for three different species of iris. Make a pairs plot of the data. What relationships (correlations) look strongest? 

## 2)##  The grouping evident with the `Species` variable in the last plot should make you curious. Add the argument `col=iris$Species` to the last plot you made. Does this change your conclusions about correlations between any of the relationships? Can you make a lattice plot (`xyplot()`) showing `Sepal.Length` as a function of `Sepal.Width` for the different species?

## 3)## The built in data `state.x77` (which can be loaded via `data(state)`) has data for the 50 US states. Fit a principal components analysis to this data. What proportion of variation is explained by the first three principal components? What variable has the greatest (absolute) loading value on each of the first three principal components? (Note: the dataset `state` is a list of datasets one of which is a matrix named `state.x77`)

## 4)## The `state.x77` can also be appraoched using heirarchical clustering. Create a cluster dendrogram of the first 20 states (in alphabetical order, as presented in the data) using `hclust()`.  (_Hint:_ given the length of the names, it might be worth plotting the dendrogram horizontally). Do any clusters stand out as surprising?

