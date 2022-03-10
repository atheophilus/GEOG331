# Alex Theophilus GEOG331
# Activity 4
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

#####################################
##### Part 2: data in dplyr     #####
#####################################

height <- data.frame(Species = c("virginica","setosa","versicolor"),
                     Height.cm = c(60,100,11.8))

iris %>%
    inner_join(y=height, by=c("Species"))

#####################################
##### Part 3: plots in ggplot2  #####
#####################################

#look at base R scatter plot
plot(iris$Sepal.Length,iris$Sepal.Width)

#3a. now make the same plot in ggplot
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

# final question answered in google doc
# end of code	