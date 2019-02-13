library(raster)
library(sp)
library(rgeos)
library(rgdal)
library(tools)

#poly1=502388,242066
#poly2=510893,262783
polyF="C:/Users/International/Downloads/camcox_aoi/Shapefiles/Governance_Definition_Oxford_Cambridge_Corridor.shp"
#polyF="C:/Users/International/Downloads/Untitled_message/buffers_10km.shp"
bng="+proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717 +x_0=400000 +y_0=-100000 +ellps=airy +datum=OSGB36 +units=m +no_defs"

fs=Sys.glob("C:/Users/International/Documents/Hackathon/Terrain_OS50m/*.tif")

ext=extent(419446.60,571833.40,173907.00,318013.30)

buffer1_f="C:/Users/International/Downloads/hackathon_data/buffer_aoi_1.shp"
buffer2_f="C:/Users/International/Downloads/hackathon_data/buffer_aoi_2.shp"

poly=readOGR(dirname(polyF), file_path_sans_ext(basename(polyF)))
buffer1=readOGR(dirname(buffer1_f), file_path_sans_ext(basename(buffer1_f)))
buffer2=readOGR(dirname(buffer2_f), file_path_sans_ext(basename(buffer2_f)))

#b=bind(buffer1, buffer2, poly)
#plot(b)


opath_aoi="C:/Users/International/Downloads/hackathon_data/clipped/camcox/"
#~~~~~~~~~~
# AOI 1
for (f in fs){
	print(paste0("Working on ", basename(f), "..."))
	r1_1=raster(f)
	## crop and mask
	r1_2 <- crop(r1_1, extent(poly))
	r1_3 <- mask(r1_2, poly)

	## Check that it worked
	#plot(r1_3)
	#plot(buffer1, add=TRUE, lwd=2)

	## write to file
	ofile_aoi=paste0(opath_aoi, file_path_sans_ext(basename(f)), "_aoi.tif")
	writeRaster(r1_3, ofile_aoi)
}




# opath_aoi1="C:/Users/International/Downloads/hackathon_data/clipped/aoi1/"
# #~~~~~~~~~~
# # AOI 1
# for (f in fs){
# 	print(paste0("Working on ", basename(f), "..."))
# 	r1_1=raster(f)
# 	## crop and mask
# 	r1_2 <- crop(r1_1, extent(buffer1))
# 	r1_3 <- mask(r1_2, buffer1)

# 	## Check that it worked
# 	#plot(r1_3)
# 	#plot(buffer1, add=TRUE, lwd=2)

# 	## write to file
# 	ofile_aoi1=paste0(opath_aoi1, file_path_sans_ext(basename(f)), "_aoi1.tif")
# 	writeRaster(r1_3, ofile_aoi1)
# }

# #~~~~~~~~~~
# # AOI 2

# opath_aoi2="C:/Users/International/Downloads/hackathon_data/clipped/aoi2/"

# for (f in fs){
# 	print(paste0("Working on ", basename(f), "..."))
# 	r2_1=raster(f)

# 	## crop and mask
# 	r2_2 <- crop(r2_1, extent(buffer2))
# 	r2_3 <- mask(r2_2, buffer2)

# 	## Check that it worked
# 	plot(r2_3)
# 	plot(buffer2, add=TRUE, lwd=2)

# 	## write to file
# 	ofile_aoi2=paste0(opath_aoi2, file_path_sans_ext(basename(f)), "_aoi2.tif")
# 	writeRaster(r2_3, ofile_aoi2)

# }








# ###############
# from pyproj import Proj, transform

# inProj = Proj(init='epsg:4326')
# outProj = Proj(init='epsg:27700')
# x1,y1 = -11705274.6374,4826473.6922
# x2,y2 = transform(inProj,outProj,x1,y1)
# print x2,y2



