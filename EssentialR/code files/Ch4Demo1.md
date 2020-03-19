

```r
# A test of knitr
# This is a comment
# a<-1:25
b<-sort(rnorm(25))
mean(b)
```

```
## [1] -0.2701595
```

```r
sd(b)
```

```
## [1] 0.9084504
```

```r
# mean and sd match the default values of sd=1 and mean=0
plot(a,b,type="l",col="red",lwd=2)
```

```
## Error in model.frame.default(formula = y ~ x): variable lengths differ (found for 'x')
```

```r
# figures are included
```

