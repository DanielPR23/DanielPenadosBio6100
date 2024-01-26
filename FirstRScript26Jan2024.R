#This is my first R script, well actually is not but nick told us to create a first line explaining what it is, so I am do in it. But not make it toooooo long.
#Adding the date is nice 25Jan20204.
#and my inicial DPR.


#Preliminaries
library(ggplot2)
set.seed(100)
library(TeachingDemos) #use this to set the random number seed from the character string.
char2seed('green tea')
char2seed ('green tea', set=FALSE)
#this last code is for generate a specific random numbers, to evaluate how my computer is running. If generates the exact same 4 numbers is becouse is running normaly. So GOOD it is! :)


# Global Variables
nRep <- 10000
#Create or read in data
ranVar1<-rnorm(nRep)

