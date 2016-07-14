library(ggplot2)
library(shiny)

shinyUI(fluidPage(
  titlePanel("Diamonds"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("variable",
                  label = "Choose a variable to inspect",
                  choices = list("depth",
                                 "table",
                                 "carat"),
                  selected = "depth"),
    
      checkboxGroupInput("color",
                         label = "Choose a color to subset the data",
                         choices = sort(unique(as.character(diamonds$color))),
                         selected = choices[1]
                         ),
      
      checkboxGroupInput("cut",
                         label = "Choose a cut to subset the data",
                         choices = sort(unique(as.character(diamonds$cut))),
                         selected = choices[1]
                         )
    ),
    
    mainPanel(
      plotOutput('plot')
    )
  )
))