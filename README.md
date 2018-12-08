# Data Science-Shiny-Application-and-Reproducible-Pitch
This peer assessed assignment has two parts. First, you will create a Shiny application and deploy it on Rstudio's servers. Second, you will use Slidify or Rstudio Presenter to prepare a reproducible pitch presentation about your application.

Your Shiny Application

Write a shiny application with associated supporting documentation. The documentation should be thought of as whatever a user will need to get started using your application.
Deploy the application on Rstudio's shiny server
Share the application link by pasting it into the provided text box
Share your server.R and ui.R code on github
The application must include the following:

Some form of input (widget: textbox, radio button, checkbox, ...)
Some operation on the ui input in sever.R
Some reactive output displayed as a result of server calculations
You must also include enough documentation so that a novice user could use your application.
The documentation should be at the Shiny website itself. Do not post to an external link.
The Shiny application in question is entirely up to you. However, if you're having trouble coming up with ideas, you could start from the simple prediction algorithm done in class and build a new algorithm on one of the R datasets packages. Please make the package simple for the end user, so that they don't need a lot of your prerequisite knowledge to evaluate your application. You should emphasize a simple project given the short time frame.

Your Reproducible Pitch Presentation

OK, you've made your shiny app, now it's time to make your pitch. You get 5 slides (inclusive of the title slide) to pitch a your app. You're going to create a web page using Slidify or Rstudio Presenter with an html5 slide deck.

Here's what you need

5 slides to pitch our idea done in Slidify or Rstudio Presenter
Your presentation pushed to github or Rpubs
A link to your github or Rpubs presentation pasted into the provided text box
Your presentation must satisfy the following

It must be done in Slidify or Rstudio Presenter
It must be 5 pages
It must be hosted on github or Rpubs
It must contained some embedded R code that gets run when slidifying the document
NOTE: Slidify is no longer compatible with with Rpubs. If you choose to use Slidify you must share your presentation using GitHub Pages.

Notice to publish your slidify presentation to github or Rpubs, there's the publish command. This link outlines how to do it (it's one line).

# About the Project 

This Application uses data about car's accidents in Allegheny County in the US, To demonstrate various capabilities from the Developing Data Products Course.
The Application provides visualization about car accidents in Allegheny County in 2017.


- Using Shiny UI Server Application. 
- Using Leaflet interactive MAP application. 
- Adding customized markers, and Popup. 
- Two Input Widget (Drop down list and Slide Bar).
- Using Reactive function. 
- Server Business logic (Subsetting data frame based on input).
- Full help page (Documentation)</font>.

<font size = "6">Shiny Applicatio Link : https://omersect.shinyapps.io/project/ 
<font size = "6">Github Repository Link :
https://github.com/omershect/Course-Project-Shiny-Application-and-Reproducible-Pitch 


The Data 
========================================================
transition: rotate
<font size = "5">
- Data link: https://data.wprdc.org/datastore/dump/bf8b3c7e-8d60-40df-9134-21606a451c1a
- Data contains information on all accidents in Allegheny County in 2017.
- Data used: </font>
<font size = "4">
- Geo Location data. 
- Months of the Accident. 
- AUTOMOBILE_COUNT -  the number of cars involved. 
- FATAL_COUNT - Total number of death. 
- ILLEGAL_DRUG_RELATED - Ilegal drug involvement. 
- DRINKING_DRIVER Number of Drunk People involved in the car accident. 
- INJURY_COUNT - Number of injuries. 
- Fatal And INJURY - Will be used to classifying the type of the accident 
    And create different Icons. 



Data and Server calculations 
========================================================
The following calculations are done in the server :
- Load data. 
- Subset data - remove the accidents with zero cars involved. 
- Remove NA items.
- Create new columns which classify the accident (Death/Injury/None).
- Check the Min and Max cars number involved and pass it to the slider input.
- Slice the dataset dynamically based on Month selection and the number of cars selection. 


Data and Server calculation (Cont.)
========================================================

<font size = "7">
Data str
</font>
<font size = "5">

```
'data.frame':	9690 obs. of  12 variables:
 $ latitude        : num  40.5 40.4 40.4 40.4 40.5 ...
 $ longitude       : num  -79.9 -80 -80 -79.8 -79.9 ...
 $ Month Crash     : int  1 1 1 1 1 1 1 1 1 1 ...
 $ No.Cars.Involved: int  2 1 1 1 4 2 2 1 2 3 ...
 $ Drinking.Driver : int  0 0 0 0 1 0 0 0 0 0 ...
 $ Death.Count     : int  0 0 0 0 0 0 0 0 0 0 ...
 $ Drug.Involved   : int  0 0 0 0 0 0 0 0 0 0 ...
 $ Injury.Count    : int  0 0 2 0 0 0 1 0 1 1 ...
 $ Fatality.ind    : int  0 0 0 0 0 0 0 0 0 0 ...
 $ Injury.ind      : int  0 0 1 0 0 0 1 0 1 1 ...
 $ Month.Crash.Name: chr  "January" "January" "January" "January" ...
 $ Death_Injuries  : Factor w/ 3 levels "Death","Injury",..: 3 3 2 3 3 3 2 3 2 2 ...
```
</font>
<font size = "7">
Summary of accidents per classification 

</font>

```

 Death Injury   None 
    32   3997   5661 
```

</font>
