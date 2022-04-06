# Alex Theophilus 4/6 in class code

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
