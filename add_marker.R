
library(leaflet)

####################################
# Add_Marker --- Helper function   #
#Paramters : 
#my_map - leaflet object - markeers will be added to this object 
#content - Data frame with the lat and long (of the required markers 
#IconMarker - The icon of the marker

Add_Marker <- function(my_map,content,iconMarker=CarsIcon) {
  #Add markers which allow creating multiple markers, with ICON and with popup
  #The cluster option is selected 
  addMarkers(my_map,data=content,
             clusterOptions = markerClusterOptions(),
             icon = iconMarker,popup = paste("Car involved:", content$No.Cars.Involved ,"<br>",
            "Fatality:",content$Death.Count,"<br>",
            "Injuries:",content$Injury.Count,"<br>",
            "Drugs Involved :", content$Drug.Involved,"<br>",
          " Alcohol involved:",content$Drinking.Driver))
 
}