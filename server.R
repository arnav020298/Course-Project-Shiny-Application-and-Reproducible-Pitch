library(shiny)
shinyServer(function(input, output) {
  
#Load libraries   
library(leaflet)
library(tidyr)
library(dplyr)
  
 
# Read 2017 Car crash data in Allegheny County.
#  Data is loaded from :
#    https://data.wprdc.org/datastore/dump/bf8b3c7e-8d60-40df-9134-21606a451c1a
 
DF<-read.csv("CarCrash2017.csv")

#Subset the location of the car crash (Latitude and longtiutiate)
#In order to show the information on  a Leaflet MAP 

#Keep the data about the month of the accident.
#Create a new column with the month's names instead of a number. 
#Since there is a large number of the crash 
#There will be an option to show car crash per specific month
#For information to present in a popup :
#AUTOMOBILE_COUNT -  the number of cars involved 
#FATAL_COUNT - Total number of death 
#ILLEGAL_DRUG_RELATED - Ilegal drug involvement 
#DRINKING_DRIVER Number of Drunk People involved in the car accident 
#INJURY_COUNT - Number of injuries 

dfCrash<-select(DF,DEC_LAT,DEC_LONG,CRASH_MONTH,AUTOMOBILE_COUNT,DRINKING_DRIVER,
                FATAL_COUNT,ILLEGAL_DRUG_RELATED,INJURY_COUNT)
colnames(dfCrash)<-c("latitude","longitude","Month Crash","No.Cars.Involved","Drinking.Driver","Death.Count","Drug.Involved","Injury.Count")
# Drop all NA columns
dfCrash<-dfCrash %>% drop_na()
#Create a column with the accident month name (instaed of a number)
dfCrash<-mutate(dfCrash,Month.Crash.Name=month.name[dfCrash$`Month Crash`])

#Calculate the Maximuim amd Minumuim number of cars involved 
#Send it as output to the UI 
Max_No_Car <- max(dfCrash$No.Cars.Involved)
Min_No_Car <- min(dfCrash$No.Cars.Involved)

#Create the slider for selecting the number of car involved 
#The slider is a semi dinamic , as the maximuim and minuim values 
# are based on the data 
output$slider <- renderUI({
  sliderInput("slider", "Select Number of Cars involve", min = Min_No_Car,
              max = Max_No_Car, value = 1,step= 1)
})


#Create the MAP 
output$map <- renderLeaflet({
leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
})
 
  })
  