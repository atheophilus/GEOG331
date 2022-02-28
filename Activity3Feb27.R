# Activity 3 GEOG331 Alex Theophilus
# Code for Questions 5-9 begins in line 129

#create a function. The names of the arguments for your function will be in parentheses. Everything in curly brackets will be run each time the function is run.
assert <- function(statement,err.message){
  #if evaluates if a statement is true or false for a single item
  if(statement == FALSE){
    print(err.message)
  }
  
}

#check how the statement works
#evaluate a false statement
assert(1 == 2, "error: unequal values")

#evaluate a true statement
assert(2 == 2, "error: unequal values")

#set up assert to check if two vectors are the same length
a <- c(1,2,3,4)
b <- c(8,4,5)
assert(length(a) == length(b), "error: unequal length")

setwd(("T:/students/atheophilus/Data/bewkes"))
#read in the data file
#skip the first 3 rows since there is additional column info
#specify the the NA is designated differently
datW <- read.csv("T:\\students\\atheophilus\\Data\\bewkes\\bewkes_weather.csv",
                 na.strings=c("#N/A"), skip=3, header=FALSE)
#preview data
print(datW[1,])

#get sensor info from file
# this data table will contain all relevant units
sensorInfo <-   read.csv("T:\\students\\atheophilus\\Data\\bewkes\\bewkes_weather.csv",
                         na.strings=c("#N/A"), nrows=2)

print(sensorInfo)

#get column names from sensorInfo table
# and set weather station colnames  to be the same
colnames(datW) <-   colnames(sensorInfo)
#preview data
print(datW[1,])

#use install.packages to install lubridate
install.packages(c("lubridate"))
#it is helpful to comment this line after you run this line of code on the computer
#and the package installs. You really don't want to do this over and over again.

library(lubridate)

#convert to standardized format
#date format is m/d/y
dates <- mdy_hm(datW$timestamp, tz= "America/New_York")

#calculate day of year
datW$doy <- yday(dates)
#calculate hour in the day
datW$hour <- hour(dates) + (minute(dates)/60)
#calculate decimal day of year
datW$DD <- datW$doy + (datW$hour/24)
#quick preview of new date calcualtions
datW[1,]

#see how many values have missing data for each sensor observation
#air temperature
length(which(is.na(datW$air.temperature)))

#wind speed
length(which(is.na(datW$wind.speed)))

#precipitation
length(which(is.na(datW$precipitation)))

#soil temperature
length(which(is.na(datW$soil.moisture)))

#soil moisture
length(which(is.na(datW$soil.temp)))

#make a plot with filled in points (using pch)
#line lines
plot(datW$DD, datW$soil.moisture, pch=19, type="b", xlab = "Day of Year",
     ylab="Soil moisture (cm3 water per cm3 soil)")

#make a plot with filled in points (using pch)
#line lines
plot(datW$DD, datW$air.temperature, pch=19, type="b", xlab = "Day of Year",
     ylab="Air temperature (degrees C)")

#I'm going to make a new column to work with that indicates that I am conducting QAQC
#because overwriting values should be done cautiously and can lead to confusing issues.
#It can be particularly confusing when you are just learning R.
#Here I'm using the ifelse function
#the first argument is a logical statement to be evaluated as true or false on a vector
#the second argument is the value that my air.tempQ1 column will be given if the statement
#is true. The last value is the value that will be given to air.tempQ1 if the statement is false.
#In this case it is just given the air temperature value
datW$air.tempQ1 <- ifelse(datW$air.temperature < 0, NA, datW$air.temperature)

#check the values at the extreme range of the data
#and throughout the percentiles
quantile(datW$air.tempQ1)

#look at days with really low air temperature
datW[datW$air.tempQ1 < 8,]  

#look at days with really high air temperature
datW[datW$air.tempQ1 > 33,]  

#plot precipitation and lightning strikes on the same plot
#normalize lighting strikes to match precipitation
lightscale <- (max(datW$precipitation)/max(datW$lightning.acvitivy)) * datW$lightning.acvitivy
#make the plot with precipitation and lightning activity marked
#make it empty to start and add in features
plot(datW$DD , datW$precipitation, xlab = "Day of Year", ylab = "Precipitation & lightning",
     type="n")
#plot precipitation points only when there is precipitation 
#make the points semi-transparent
points(datW$DD[datW$precipitation > 0], datW$precipitation[datW$precipitation > 0],
       col= rgb(95/255,158/255,160/255,.5), pch=15)        

#plot lightning points only when there is lightning     
points(datW$DD[lightscale > 0], lightscale[lightscale > 0],
       col= "tomato3", pch=19)

# Question 5
# Use assert to show lightscale is already represented in datW
d <- c(lightscale)
e <- c((max(datW$precipitation)/max(datW$lightning.acvitivy)) * datW$lightning.acvitivy)
assert(sum(d) == sum(e), "error: unequal values")

#filter out storms in wind and air temperature measurements
# filter all values with lightning that coincides with rainfall greater than 2mm or only rainfall over 5 mm.    
#create a new air temp column
datW$air.tempQ2 <- ifelse(datW$precipitation  >= 2 & datW$lightning.acvitivy >0, NA,
                          ifelse(datW$precipitation > 5, NA, datW$air.tempQ1))


# question 6 wind speed filtering
datW$wind.speedQ1 <- ifelse(datW$wind.speed < 0, NA, datW$wind.speed)
quantile(datW$wind.speedQ1)
datW[datW$wind.speedQ1 > .1,]
datW[datW$wind.speedQ1 > 1,]
datW$wind.speedQ2 <- ifelse(datW$precipitation  >= 2 & datW$lightning.acvitivy >0, NA,
                            ifelse(datW$precipitation > 5, NA, datW$wind.speedQ1))

#question 6 assert answer
f <- c(datW$wind.speedQ1)
g <- c(datW$wind.speedQ2)
assert(sum(f) == sum(g), "error: unequal values") 

#question 6 plot
plot(datW$DD, datW$wind.speedQ1, xlab = "day of year", ylab = "Wind Speed m/s",
     type = "n")
points(datW$DD, datW$wind.speedQ1,
       col = "blue2", pch=15)
points(datW$DD, datW$wind.speedQ2,
       col = "black", pch=100)


#question 7 soil temp qa qc
mean(datW$soil.moisture, trim = 0, na.rm = TRUE) - median(datW$soil.moisture, na.rm = TRUE)
mean(datW$soil.temp, trim = 0, na.rm = TRUE) - median(datW$soil.temp, na.rm = TRUE)

#question 8
install.packages("data.table")
library("data.table")
data <- data.table("Avg Air Temp" = mean(datW$air.temperature, trim = 0, na.rm = TRUE),
                   "Avg Wind Speed" = mean(datW$wind.speed, trim = 0, na.rm = TRUE),
                   "Avg Soil Moisture" = mean(datW$soil.moisture, trim = 0, na.rm = TRUE),
                   "Avg Soil Temp" = mean(datW$soil.temp, trim = 0, na.rm = TRUE),
                   "Total Precip" = sum(datW$precipitation, na.rm = TRUE))

# Question 9 Plots
plot(datW$DD, datW$soil.moisture,xlab = "day of year", ylab = "Soil Moisture",
     type = "n")
points(datW$DD, datW$soil.moisture,
       col = "blue2", pch=15)
plot(datW$DD, datW$air.temperature, xlab = "day of year", ylab = "air temperature",
     type = "n")
points(datW$DD, datW$air.temperature,
       col = "blue2", pch=15)
plot(datW$DD, datW$soil.temp, xlab = "day of year", ylab = "soil temp",
     type = "n")
points(datW$DD, datW$soil.temp,
       col = "blue2", pch=15)
plot(datW$DD, datW$precipitation, xlab = "day of year", ylab = "Precipitation",
     type = "n")
points(datW$DD, datW$precipitation,
       col = "blue2", pch=15)

#end of assignment code


