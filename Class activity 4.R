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

<<<<<<< HEAD
flower <- iris[iris$Species=="versicolor",]

Q1_Regressions = list()

ordered_attributes = list(flower$Sepal.Length, flower$Sepal.Width,
                 flower$Petal.Length, flower$Petal.Width,
                 flower$Sepal.Length, flower$Petal.Length)

for (i in 1:3){
  List1 = unlist(ordered_attributes[((i*2)-1)])
  List2 = unlist(ordered_attributes[(i*2)])
  Q1_Regressions[[i]] <- lm(List1 ~ List2)
}
=======
# hint: consider using a list, and also new vectors for regression variables
iris
# build regressions
flower <- iris[iris$Species=="versicolor",]
fit1 <- lm(flower$Sepal.Length ~ flower$Sepal.Width)
fit2 <- lm(flower$Petal.Length ~ flower$Petal.Width)
fit3 <- lm(flower$Sepal.Length ~ flower$Petal.Length)
# get regressions in for loop


>>>>>>> 192077730fce964f663d5203a6f8d87cb29f64fb

#####################################
##### Part 2: data in dplyr     #####
#####################################

<<<<<<< HEAD
height <- data.frame(Species = c("virginica","setosa","versicolor"),
                     Height.cm = c(60,100,11.8))

iris %>%
    inner_join(y=height, by=c("Species"))

=======
#use dplyr to join data of maximum height
#to a new iris data frame
height <- data.frame(Species = c("virginica","setosa","versicolor"),
                     Height.cm = c(60,100,11.8))

full_join(height$Species, height$Height.cm, by=NULL, copy=FALSE,
          suffix = c(".x", ".y"), keep = FALSE, na_matches="na")
      
>>>>>>> 192077730fce964f663d5203a6f8d87cb29f64fb

#####################################
##### Part 3: plots in ggplot2  #####
#####################################

#look at base R scatter plot
plot(iris$Sepal.Length,iris$Sepal.Width)

#3a. now make the same plot in ggplot
<<<<<<< HEAD
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) + 
          geom_point(size=2, shape=1)

#3b. make a scatter plot with ggplot and get rid of  busy grid lines
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) + 
  geom_point(size=2, shape=1) +
  theme_classic()

#3c. make a scatter plot with ggplot, remove grid lines, add a title and axis labels, 
#    show species by color, and make the point size proportional to petal length
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, size=Petal.Length, color=Species)) + 
  geom_point() +
  theme_classic() +
  labs(title="Plot of Iris Dimensions",
       x="Sepal Length", y="Sepal Width")
=======


#3b. make a scatter plot with ggplot and get rid of  busy grid lines


#3c. make a scatter plot with ggplot, remove grid lines, add a title and axis labels, 
#    show species by color, and make the point size proportional to petal length
>>>>>>> 192077730fce964f663d5203a6f8d87cb29f64fb

#####################################
##### Question: how did         #####
##### arguments differ between  #####
##### plot and ggplot?          #####
#####################################		
