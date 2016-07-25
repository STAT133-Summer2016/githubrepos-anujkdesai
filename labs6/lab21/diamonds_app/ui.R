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
                         choices = list("D", "E", "F", "G", "H", "I", "J"),
                         selected = "D"
                         ),
      
      checkboxGroupInput("cut",
                         label = "Choose a cut to subset the data",
                         choices = list("Fair", "Good", "Very Good", "Premium", 
                                        "Ideal"),
                         selected = "Fair"
                         )
    ),
    
    mainPanel(
      plotOutput('plot')
    )
  )
))