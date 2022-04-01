# Homework 5 Theophilus
# question 5 and my answers start on line 93

#load in lubridate
library(lubridate)

#read in streamflow data
datH <- read.csv("T:\\students\\atheophilus\\Data\\streamflow\\stream_flow_data.csv",
                 na.strings = c("Eqp"))
head(datH)

#read in precipitation data
#hourly precipitation is in mm
datP <- read.csv("T:\\students\\atheophilus\\Data\\streamflow\\2049867.csv")                            
head(datP)

#only use most reliable measurements
datD <- datH[datH$discharge.flag == "A",]

#### define time for streamflow #####
#convert date and time
datesD <- as.Date(datD$date, "%m/%d/%Y")
#get day of year
datD$doy <- yday(datesD)
#calculate year
datD$year <- year(datesD)
#define time
timesD <- hm(datD$time)

#### define time for precipitation #####    
dateP <- ymd_hm(datP$DATE)
#get day of year
datP$doy <- yday(dateP)
#get year 
datP$year <- year(dateP)

#### get decimal formats #####
#convert time from a string to a more usable format
#with a decimal hour
datD$hour <- hour(timesD ) + (minute(timesD )/60)
#get full decimal time
datD$decDay <- datD$doy + (datD$hour/24)
#calculate a decimal year, but account for leap year
datD$decYear <- ifelse(leap_year(datD$year),datD$year + (datD$decDay/366),
                       datD$year + (datD$decDay/365))
#calculate times for datP                       
datP$hour <- hour(dateP ) + (minute(dateP )/60)
#get full decimal time
datP$decDay <- datP$doy + (datP$hour/24)
#calculate a decimal year, but account for leap year
datP$decYear <- ifelse(leap_year(datP$year),datP$year + (datP$decDay/366),
                       datP$year + (datP$decDay/365))

#plot discharge
plot(datD$decYear, datD$discharge, type="l", xlab="Year", ylab=expression(paste("Discharge ft"^"3 ","sec"^"-1")))

#basic formatting
aveF <- aggregate(datD$discharge, by=list(datD$doy), FUN="mean")
colnames(aveF) <- c("doy","dailyAve")
sdF <- aggregate(datD$discharge, by=list(datD$doy), FUN="sd")
colnames(sdF) <- c("doy","dailySD")

#start new plot
dev.new(width=8,height=8)

#bigger margins
par(mai=c(1,1,1,1))
#make plot
plot(aveF$doy,aveF$dailyAve, 
     type="l", 
     xlab="Month", 
     ylab=expression(paste("Discharge ft"^"3 ","sec"^"-1")),
     lwd=2,
     ylim=c(0,180),
     xaxs="i", yaxs ="i",#remove gaps from axes
     axes=FALSE)#no axes
polygon(c(aveF$doy, rev(aveF$doy)),#x coordinates
        c(aveF$dailyAve-sdF$dailySD,rev(aveF$dailyAve+sdF$dailySD)),#ycoord
        col=rgb(0.392, 0.584, 0.929,.2), #color that is semi-transparent
        border=NA#no border
)       
axis(1, seq(0,360, by=30), #tick intervals
     labels = seq(1,12, by=1)) #tick labels
axis(2, seq(0,180, by=30),
     seq(0,180, by=30),
     las = 2)#show ticks at 90 degree angle
legend("topright", c("mean","1 standard deviation"), #legend items
       lwd=c(2,NA),#lines
       col=c("black",rgb(0.392, 0.584, 0.929,.2)),#colors
       pch=c(NA,15),#symbols
       bty="n")#no legend border

# question 5 2017 line
lines(datD$doy[datD$year=="2017"],
      datD$discharge[datD$year=="2017"], col="red")

#question 7 data frame
full_rain <- data.frame()

for(i in 1:nrow(datP)) {
    if (datP[i,5]== datP[i+23,5])
    {d<- (datP[i, ])
    full_rain=rbind(full_rain,d)}
}
#question 7 plot
plot(full_rain$year, full_rain$doy,
     xlab = "Year",
     ylab = "DOY",
     xlim = c(2007,2017),
     ylim = c(0,366))

#question 8
# start of my hydrograph
#subsest discharge and precipitation within range of interest
hydroD <- datD[datD$doy >= 265 & datD$doy < 267 & datD$year == 2008,]
hydroP <- datP[datP$doy >= 265 & datP$doy < 267 & datP$year == 2008,]
min(hydroD$discharge)
#get minimum and maximum range of discharge to plot
#go outside of the range so that it's easy to see high/low values
#floor rounds down the integer
yl <- floor(min(hydroD$discharge))-1
#ceiling rounds up to the integer
yh <- ceiling(max(hydroD$discharge))+1
#minimum and maximum range of precipitation to plot
pl <- 0
pm <-  ceiling(max(hydroP$HPCP))+.5
#scale precipitation to fit on the 
hydroP$pscale <- (((yh-yl)/(pm-pl)) * hydroP$HPCP) + yl
par(mai=c(1,1,1,1))
#make plot of discharge
plot(hydroD$decDay,
     hydroD$discharge, 
     type="l", 
     ylim=c(yl,yh), 
     lwd=2,
     xlab="Day of year", 
     ylab=expression(paste("Discharge ft"^"3 ","sec"^"-1")))
#add bars to indicate precipitation 
for(i in 1:nrow(hydroP)){
  polygon(c(hydroP$decDay[i]-0.017,hydroP$decDay[i]-0.017,
            hydroP$decDay[i]+0.017,hydroP$decDay[i]+0.017),
          c(yl,hydroP$pscale[i],hydroP$pscale[i],yl),
          col=rgb(0.392, 0.584, 0.929,.2), border=NA)
}

library(ggplot2)
#specify year as a factor
datD$yearPlot <- as.factor(datD$year)
#make a boxplot
ggplot(data= datD, aes(yearPlot,discharge)) + 
  geom_boxplot()

#make a violin plot
ggplot(data= datD, aes(yearPlot,discharge)) + 
  geom_violin()

# question 9 2016
datDsixteen <- datD[datD$year == 2016,]
datDsixteen$szn <- 0
datDsixteen$szn <- ifelse(datDsixteen$doy >= 61 & datDsixteen$doy <=153, 1, datDsixteen$szn)
datDsixteen$szn <- ifelse(datDsixteen$doy >= 154 & datDsixteen$doy <=250, 2, datDsixteen$szn)
datDsixteen$szn <- ifelse(datDsixteen$doy >= 251 & datDsixteen$doy <=310, 3, datDsixteen$szn)

#create season labels
datDsixteen$season <- cut(datDsixteen$szn, 4, labels = c('Winter', 'Spring','Summer', 'Autumn'))

ggplot(data= datDsixteen, aes(season,discharge)) + 
  geom_violin()
  


# question 9 2017
datDseventeen <- datD[datD$year == 2017,]
datDseventeen$szn <- 0
datDseventeen$szn <- ifelse(datDseventeen$doy >= 61 & datDseventeen$doy <=153, 1, datDseventeen$szn)
datDseventeen$szn <- ifelse(datDseventeen$doy >= 154 & datDseventeen$doy <=250, 2, datDseventeen$szn)
datDseventeen$szn <- ifelse(datDseventeen$doy >= 251 & datDseventeen$doy <=310, 3, datDseventeen$szn)
  
#create season labels
datDseventeen$season <- cut(datDseventeen$szn, 4, labels = c('Winter', 'Spring','Summer', 'Autumn'))
  
ggplot(data= datDseventeen, aes(season,discharge)) + 
  geom_violin()

#end of homework code
