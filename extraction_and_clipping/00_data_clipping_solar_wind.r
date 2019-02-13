library(raster)
library(sp)
library(rgeos)
library(rgdal)
library(tools)

#poly1=502388,242066
#poly2=510893,262783
polyF="C:/Users/International/Downloads/camcox_aoi/Shapefiles/Governance_Definition_Oxford_Cambridge_Corridor.shp"
bng="+proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717 +x_0=400000 +y_0=-100000 +ellps=airy +datum=OSGB36 +units=m +no_defs"
ext=extent(419446.60,571833.40,173907.00,318013.30)

#fs=Sys.glob("C:/Users/International/Downloads/hackathon_data/wind_energy/WindExposition.tif")
#opath_aoi="C:/Users/International/Downloads/hackathon_data/wind_energy/"
fs=Sys.glob("C:/Users/International/Downloads/hackathon_data/solar_energy/*.tif")
opath_aoi="C:/Users/International/Downloads/hackathon_data/solar_energy/"

poly=readOGR(dirname(polyF), file_path_sans_ext(basename(polyF)))

#~~~~~~~~~~
# AOI 1
for (f in fs){
	print(paste0("Working on ", basename(f), "..."))
	r1_1=raster(f)
	## crop and mask
	r1_2 <- crop(r1_1, extent(poly))
	r1_3 <- mask(r1_2, poly)

	## Check that it worked
	plot(r1_3)
	plot(poly, add=TRUE, lwd=2)

	## write to file
	ofile_aoi=paste0(opath_aoi, file_path_sans_ext(basename(f)), "_aoi.tif")
	writeRaster(r1_3, ofile_aoi)
}





