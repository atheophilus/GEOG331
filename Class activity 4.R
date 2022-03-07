#use built in iris dataset
#take a look at it
head(iris)
#load in some tidyverse packages
library(dplyr)
library(ggplot2)

#####################################
##### Part 1: for loops         #####
#####################################

#Using only data for iris versicolor
#write a for loop
#that produces a regression table
#for each of the following relationships
#1. iris  sepal length x width
#2. iris  petal length x width
#3. iris sepal length x petal length

# hint: consider using a list, and also new vectors for regression variables
iris
# build regressions
flower <- iris[iris$Species=="versicolor",]
fit1 <- lm(flower$Sepal.Length ~ flower$Sepal.Width)
fit2 <- lm(flower$Petal.Length ~ flower$Petal.Width)
fit3 <- lm(flower$Sepal.Length ~ flower$Petal.Length)
# get regressions in for loop



#####################################
##### Part 2: data in dplyr     #####
#####################################

#use dplyr to join data of maximum height
#to a new iris data frame
height <- data.frame(Species = c("virginica","setosa","versicolor"),
                     Height.cm = c(60,100,11.8))

full_join(height$Species, height$Height.cm, by=NULL, copy=FALSE,
          suffix = c(".x", ".y"), keep = FALSE, na_matches="na")
      

#####################################
##### Part 3: plots in ggplot2  #####
#####################################

#look at base R scatter plot
plot(iris$Sepal.Length,iris$Sepal.Width)

#3a. now make the same plot in ggplot


#3b. make a scatter plot with ggplot and get rid of  busy grid lines


#3c. make a scatter plot with ggplot, remove grid lines, add a title and axis labels, 
#    show species by color, and make the point size proportional to petal length

#####################################
##### Question: how did         #####
##### arguments differ between  #####
##### plot and ggplot?          #####
#####################################		
