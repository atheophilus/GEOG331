# Alex Theophilus 4/13 in class code

# load the terra package
library(terra)

#set working directory
setwd("T:\\students\\atheophilus\\")

# read a raster from the file
p <- rast("T:\\students\\atheophilus\\Data\\rs_data\\20190706_002918_101b_3B_AnalyticMS_SR.tif")

# plot the raster
plot(p)

# plot an rgb rendering of the data
plotRGB(p, r = 3, g = 2, b = 1)
# error message means colors are too intense to display

# plot an rgb rendering of the data
plotRGB(p, r = 3, g = 2, b = 1,
        scale = 65535,
        stretch = "hist")


# read in file with field observation of canopy cover
tree <- read.csv("T:\\students\\atheophilus\\Data\\rs_data\\siberia_stand_data.csv",
             header = T)

# convert to vector object using terra package
gtree <- vect(tree, geom = c("Long", "Lat"), "epsg:4326")

# project the data to match the coordinate system of the raster layer
gtree2 <- project(gtree,p)

# create a polygon from the extent of points
# note: expect the crs to be carried over, but it isn't, so must specify again
b <- as.lines(ext(gtree), "epsg:4326")

# reproject the polygons to the same projection as our raster
b2 <- project(b,crs(p))

# buffer the extent by 200m
b3 <- buffer(b2, width = 200)

# use this to crop the raster layer so we can see just our study area




