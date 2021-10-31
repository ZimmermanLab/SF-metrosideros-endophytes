# R script to perform some preparattion on GIS coordinates and download
# a map baselayer from Google Maps

# Originally written by Naupaka Zimmerman
# nzimmerman@usfca.edu
# October 31, 2021

# set to TRUE to reproject
# this may cause knitting to fail if key is not present locally
# because Google API key needed for download
reproject <- FALSE

if (reproject) {
  
  # load tree metadata as spatial object with coord system
  df_sp <- st_as_sf(trees_aug,
                    coords = c("Lat_m", "Long_m"),
                    crs = 32610) # UTM 10N
  
  # convert from UTM to WGS84 and add back to data frame
  # see here for projection codes http://spatialreference.org/ref/epsg/32610/
  df_sp <- st_transform(x = df_sp, crs = 4326) # WGS84 lat long projection
  df_sp$lon <- st_coordinates(df_sp)[, 1] # get coordinates
  df_sp$lat <- st_coordinates(df_sp)[, 2] # get coordinates
  
  # write out csv with decimal degree coordinates
  write.csv(df_sp,
            paste0("output/metadata_tables/",
                   "m_excel_tree_metadata_with_isolationfreq_wgs_lat_long.csv"))
  
  # get the satellite imagery for San Francisco
  # note that this will need a local Google maps API key to run
  sf_map <- get_map(location = "San Francisco",
                    maptype = "satellite",
                    source = "google",
                    zoom = 12)
  
  # save the base map to a file so it doesn't need to be downloaded every time
  save(sf_map, file = "output/sf_basemap.Rdata")
}

# load tree metadata with decimal degree coordinates
tree_coords <- read.csv(paste0("output/metadata_tables/",
                               "m_excel_tree_metadata_with_",
                               "isolationfreq_wgs_lat_long.csv"))

# fix downtown spurious coordinates
tree_coords[tree_coords$Site_ID ==
              "Montgomery and Washington", ][, c("lon")] <- -122.402300
tree_coords[tree_coords$Site_ID ==
              "Montgomery and Washington", ][, c("lat")] <- 37.7948

# fix Ocean spurious coordinates
tree_coords[tree_coords$X == "S6T1-B", "lat"] <- NA
tree_coords[tree_coords$X == "S6T1-B", "lon"] <- NA

# group tree coordinates by site and take the mean
tree_coords <- tree_coords %>%
  group_by(Site_ID) %>%
  summarize(mean_lat = mean(lat, na.rm = TRUE),
            mean_lon = mean(lon, na.rm = TRUE))

# load base map
load("output/sf_basemap.Rdata")