library(ggplot2)
library(MASS)
library(dplyr)

z<-read.csv("Li_Soil_Dataset_DP.csv", sep=',', comment.char = '#')

str(z)
z<-na.omit(z)
z$myVar<-z$organic_matter
summary(z)


p1<-ggplot(z, aes(x=myVar, y=after_stat(density))) +
  geom_histogram(color="green", fill="cornsilk", size=0.2)
p1

#sum(z$myVar<0)
#z<-z%>%
  #filter(pathogen_load>0)%>%
  #mutate(myVar=log(pathogen_load))

#p1<-ggplot(z, aes(x=myVar, y=after_stat(density))) +
#geom_histogram(color="green", fill="cornsilk", size=0.2)
#p1

normPars <- fitdistr(z$myVar,"normal")
print(normPars)
str(normPars)
normPars$estimate["mean"] 


meanML <- normPars$estimate["mean"]
sdML <- normPars$estimate["sd"]

xval <- seq(0,max(z$myVar),len=length(z$myVar))

stat <- stat_function(aes(x = xval, y = ..y..), fun = dnorm, colour="red", n = length(z$myVar), args = list(mean = meanML, sd = sdML))
p1 + stat


expoPars <- fitdistr(z$myVar,"exponential")
rateML <- expoPars$estimate["rate"]

stat2 <- stat_function(aes(x = xval, y = ..y..), fun = dexp, colour="blue", n = length(z$myVar), args = list(rate=rateML))
p1 + stat + stat2


stat3 <- stat_function(aes(x = xval, y = ..y..), fun = dunif, colour="darkgreen", n = length(z$myVar), args = list(min=min(z$myVar), max=max(z$myVar)))
p1 + stat + stat2 + stat3


gammaPars <- fitdistr(z$myVar,"gamma")
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]

stat4 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="brown", n = length(z$myVa), args = list(shape=shapeML, rate=rateML))
p1 + stat + stat2 + stat3 + stat4


pSpecial <- ggplot(data=z, aes(x=myVar/(max(myVar + 0.1)), y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) + 
  xlim(c(0,1)) +
  geom_density(size=0.75,linetype="dotted")

betaPars <- fitdistr(x=z$myVar/max(z$myVar + 0.1),start=list(shape1=1,shape2=2),"beta")
shape1ML <- betaPars$estimate["shape1"]
shape2ML <- betaPars$estimate["shape2"]

statSpecial <- stat_function(aes(x = xval, y = ..y..), fun = dbeta, colour="orchid", n = length(z$myVar), args = list(shape1=shape1ML,shape2=shape2ML))
pSpecial + statSpecial



