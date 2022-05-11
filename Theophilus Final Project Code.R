# Alex Theophilus GEOG331
# Spring 2022



# reading in ACTUAL project csv files
FoodGHG <- read.csv("T:\\students\\atheophilus\\Data\\Edgar_Food_Data\\EdgarFoodv6.csv", skip = 3)
AmmoniaPollution <- read.csv("T:\\students\\atheophilus\\Data\\Edgar_Food_Data\\AmmoniaEdgar.csv")

# get sums of each year from 1990-2015 for GHG
GlobalFoodGHG <- c(sum(FoodGHG$Y_1990), sum(FoodGHG$Y_1991), sum(FoodGHG$Y_1992), sum(FoodGHG$Y_1993), sum(FoodGHG$Y_1994),
                   sum(FoodGHG$Y_1995), sum(FoodGHG$Y_1996), sum(FoodGHG$Y_1997), sum(FoodGHG$Y_1998), sum(FoodGHG$Y_1999),
                   sum(FoodGHG$Y_2000), sum(FoodGHG$Y_2001), sum(FoodGHG$Y_2002), sum(FoodGHG$Y_2003),
                   sum(FoodGHG$Y_2004), sum(FoodGHG$Y_2005), sum(FoodGHG$Y_2006), sum(FoodGHG$Y_2007),
                   sum(FoodGHG$Y_2008), sum(FoodGHG$Y_2009), sum(FoodGHG$Y_2010), sum(FoodGHG$Y_2011), sum(FoodGHG$Y_2012),
                   sum(FoodGHG$Y_2013), sum(FoodGHG$Y_2014), sum(FoodGHG$Y_2015))

plot(GlobalFoodGHG, AmmoniaPollution$Agriculture, xlab = "Total Worldwide GHG Emissions from Food", ylab = "Worldwide Ammonia Pollution from Agriculture")

GlobalFoodGHG$TotalGHG <- GlobalFoodGHG
GlobalFoodGHG$Year <- c(1990:2015)
GlobalFoodGHG$Ammonia <- AmmoniaPollution$Agriculture

plot(GlobalFoodGHG$TotalGHG, AmmoniaPollution$Agriculture, 
     main = "Global Food GHG Emissions with Ammonia Pollution from Y1990-Y2015",
     xlab = "Total Worldwide GHG Emissions from Food", ylab = "Worldwide Ammonia Pollution",
     ylim = c(75000,50000000), col = "red")
points(GlobalFoodGHG$TotalGHG, AmmoniaPollution$Transport, col = "blue")
points(GlobalFoodGHG$TotalGHG, AmmoniaPollution$Waste, col = "grey")
points(GlobalFoodGHG$TotalGHG, AmmoniaPollution$Buildings, col = "black")
legend(15500000, 2e+07, legend = c("Agriculture", "Buildings", "Transportation", "Waste"),
       fill = c("red", "black", "blue", "grey"))

EUAmmonia <- read.csv("T:\\students\\atheophilus\\Data\\Edgar_Food_Data\\EUAmmoniaPoll.csv", skip = 9, header = TRUE)
# remove commas from values
EUAmmonia$X1990 <- as.numeric(gsub(",","", EUAmmonia$X1990))
EUAmmonia$X1991 <- as.numeric(gsub(",","", EUAmmonia$X1991))
EUAmmonia$X1992 <- as.numeric(gsub(",","", EUAmmonia$X1992))
EUAmmonia$X1993 <- as.numeric(gsub(",","", EUAmmonia$X1993))
EUAmmonia$X1994 <- as.numeric(gsub(",","", EUAmmonia$X1994))
EUAmmonia$X1995 <- as.numeric(gsub(",","", EUAmmonia$X1995))
EUAmmonia$X1996 <- as.numeric(gsub(",","", EUAmmonia$X1996))
EUAmmonia$X1997 <- as.numeric(gsub(",","", EUAmmonia$X1997))
EUAmmonia$X1998 <- as.numeric(gsub(",","", EUAmmonia$X1998))
EUAmmonia$X1999 <- as.numeric(gsub(",","", EUAmmonia$X1999))
EUAmmonia$X2000 <- as.numeric(gsub(",","", EUAmmonia$X2000))
EUAmmonia$X2001 <- as.numeric(gsub(",","", EUAmmonia$X2001))
EUAmmonia$X2002 <- as.numeric(gsub(",","", EUAmmonia$X2002))
EUAmmonia$X2003 <- as.numeric(gsub(",","", EUAmmonia$X2003))
EUAmmonia$X2004 <- as.numeric(gsub(",","", EUAmmonia$X2004))
EUAmmonia$X2005 <- as.numeric(gsub(",","", EUAmmonia$X2005))
EUAmmonia$X2006 <- as.numeric(gsub(",","", EUAmmonia$X2006))
EUAmmonia$X2007 <- as.numeric(gsub(",","", EUAmmonia$X2007))
EUAmmonia$X2008 <- as.numeric(gsub(",","", EUAmmonia$X2008))
EUAmmonia$X2009 <- as.numeric(gsub(",","", EUAmmonia$X2009))
EUAmmonia$X2010 <- as.numeric(gsub(",","", EUAmmonia$X2010))
EUAmmonia$X2011 <- as.numeric(gsub(",","", EUAmmonia$X2011))
EUAmmonia$X2012 <- as.numeric(gsub(",","", EUAmmonia$X2012))
EUAmmonia$X2013 <- as.numeric(gsub(",","", EUAmmonia$X2013))
EUAmmonia$X2014 <- as.numeric(gsub(",","", EUAmmonia$X2014))
EUAmmonia$X2015 <- as.numeric(gsub(",","", EUAmmonia$X2015))
EUAmmonia$X2016 <- as.numeric(gsub(",","", EUAmmonia$X2016))
EUAmmonia$X2017 <- as.numeric(gsub(",","", EUAmmonia$X2017))
EUAmmonia$X2018 <- as.numeric(gsub(",","", EUAmmonia$X2018))
EUAmmonia$X2019 <- as.numeric(gsub(",","", EUAmmonia$X2019))

# create dataset of European Union ammonia pollution
# match time frame to previous data sets
TOTALEUAmmon <- c(sum(EUAmmonia$X1990, na.rm = TRUE), sum(EUAmmonia$X1991, na.rm = TRUE), sum(EUAmmonia$X1992, na.rm = TRUE), sum(EUAmmonia$X1993, na.rm = TRUE), 
                    sum(EUAmmonia$X1994, na.rm = TRUE), sum(EUAmmonia$X1995, na.rm = TRUE), sum(EUAmmonia$X1996, na.rm = TRUE), sum(EUAmmonia$X1997, na.rm = TRUE),
                    sum(EUAmmonia$X1998, na.rm = TRUE), sum(EUAmmonia$X1999, na.rm = TRUE), sum(EUAmmonia$X2000, na.rm = TRUE), sum(EUAmmonia$X2001, na.rm = TRUE),
                    sum(EUAmmonia$X2002, na.rm = TRUE), sum(EUAmmonia$X2003, na.rm = TRUE), sum(EUAmmonia$X2004, na.rm = TRUE), sum(EUAmmonia$X2005, na.rm = TRUE),
                    sum(EUAmmonia$X2006, na.rm = TRUE), sum(EUAmmonia$X2007, na.rm = TRUE), sum(EUAmmonia$X2008, na.rm = TRUE), sum(EUAmmonia$X2009, na.rm = TRUE),
                    sum(EUAmmonia$X2010, na.rm = TRUE), sum(EUAmmonia$X2011, na.rm = TRUE), sum(EUAmmonia$X2012, na.rm = TRUE), sum(EUAmmonia$X2013, na.rm = TRUE),
                    sum(EUAmmonia$X2014, na.rm = TRUE), sum(EUAmmonia$X2015, na.rm = TRUE))

# graph european union ammonia pollution over time
plot(GlobalFoodGHG$Year, TOTALEUAmmon, main = "Comparing European and Global Ammonia Pollution",
    xlab = "Year", ylab = "Ammonia Pollution (tonnes)", ylim = c(75000,50000000))
# plot global ammonia pollution for contrast
points(GlobalFoodGHG$Year,GlobalFoodGHG$Ammonia, col = "red")
legend(2000, 2e+07, legend = c("European Union", "Global"),
       fill = c("Black", "Red"))
