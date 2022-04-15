# Alex Theophilus GEOG331
# April 2022



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


ggplot(GlobalFoodGHG, aes(x = TotalGHG, y = Ammonia, color = Year)) +
  geom_point()
