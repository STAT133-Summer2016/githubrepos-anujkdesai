library(shiny)
library(ggvis)

shinyUI(fluidPage(
  titlePanel("Life Expectancy and Income"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("slider",
                  label = "Year:",
                  min = 1800,
                  max = 2015,
                  value = 1800,
                  animate = TRUE),
      uiOutput("plot_ui")
    ),
    
    mainPanel(
      ggvisOutput("plot")
    )
  )

))