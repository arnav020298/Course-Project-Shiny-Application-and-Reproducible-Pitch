library(shiny)
shinyUI(fluidPage(
  titlePanel("2017 Car crash data in Allegheny County"),
  sidebarLayout(
    sidebarPanel(
#Slider to slice based on a month (or select all)
      selectInput(
        inputId =  "Month", 
        label = "Select Month:", 
        choices = c("All",month.name),
        selected = "All"
      ),
#Slider from the server to slice based on number of cars involved
      uiOutput("slider"),
      
      submitButton("Submit")
    ),
    mainPanel(
      leafletOutput("map", width = "90%", height = "700px")
    )
  )
))