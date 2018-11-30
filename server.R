library(shiny)
shinyServer(function(input, output,session) {
  
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

#Subset only the accidents which the number of car involves is
#higher than zero

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
                FATAL_COUNT,ILLEGAL_DRUG_RELATED,INJURY_COUNT,FATAL,INJURY)
colnames(dfCrash)<-c("latitude","longitude","Month Crash","No.Cars.Involved","Drinking.Driver",
                     "Death.Count","Drug.Involved","Injury.Count","Fatality.ind","Injury.ind")
# Drop all NA columns
dfCrash<-dfCrash %>% drop_na()

#Create a column with the accident month name (instaed of a number)
dfCrash<-mutate(dfCrash,Month.Crash.Name=month.name[dfCrash$`Month Crash`])


#Subset - remove all accident with zero cars 
dfCrash <-subset(dfCrash,dfCrash$No.Cars.Involved > 0)

DF.Crahs.subset<-dfCrash

#Calculate the Maximuim amd Minumuim number of cars involved 
#Send it as output to the UI 
Max_No_Car <- max(dfCrash$No.Cars.Involved)
Min_No_Car <- min(dfCrash$No.Cars.Involved)

#Icons 
CarsIcon <- makeIcon("CarsIconGreen.png",iconWidth = 45, iconHeight = 45)
FatalCarsIcon <- makeIcon("CarsIconRed.png",iconWidth = 45, iconHeight = 45)
InjurylCarsIcon <- makeIcon("CarsIconYellow.png",iconWidth = 45, iconHeight = 45)

#Use the Min and Max values to updates the slider input 
updateSliderInput(session, "slider", max=Max_No_Car,min=Min_No_Car)


#Reactive function to get the Slected month (or all year)
Month<- reactive({
  input$Month
})


#Reactive function to get the Slected number of involved cars
Cars<- reactive({
  input$slider
})


#Create the MAP 
output$map <- renderLeaflet({

#Get the Month and slice the Data Frame accordingly 
Sel.Month<-Month()
if (Sel.Month == "All")
    DF.Crahs.subset<-dfCrash
else
    DF.Crahs.subset <-subset(dfCrash,dfCrash$`Month.Crash.Name`==Sel.Month)

#Get No of Cars and slice the data frame accordingly 
Sel.Cars<-Cars()
DF.Crahs.subset <-subset(DF.Crahs.subset,dfCrash$No.Cars.Involved<=Sel.Cars)

#Create the slider for selecting the number of car involved 
#The slider is a semi dinamic , as the maximuim and minuim values 
# are based on the data 
output$slider <- renderUI({
  sliderInput("slider", "Select Number of Cars involve", min = Min_No_Car,
              max = Max_No_Car, value = 1,step= 1)
})

  
#Build the MAP   
leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
    # Add 3 diffrent type of Markers 
    #Fatality group 
    addMarkers(data=subset(DF.Crahs.subset,DF.Crahs.subset$Fatality.ind == 1),
               clusterOptions = markerClusterOptions(), icon = FatalCarsIcon)%>%
    #Injury Group
    addMarkers(data=subset(DF.Crahs.subset,(DF.Crahs.subset$Fatality.ind == 0 & DF.Crahs.subset$Injury.ind==1)),
           clusterOptions = markerClusterOptions(), icon = InjurylCarsIcon)%>% 
    
    #No Injury and No Fatality  Group
    addMarkers(data=subset(DF.Crahs.subset,(DF.Crahs.subset$Fatality.ind == 0 & DF.Crahs.subset$Injury.ind==0)),
               clusterOptions = markerClusterOptions(), icon = CarsIcon)  
 
  })

})
  