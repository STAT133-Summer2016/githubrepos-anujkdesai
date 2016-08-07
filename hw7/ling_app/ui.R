library(shiny)
load("data/question_data.RData")

shinyUI(fluidPage(
  titlePanel("Dialect Survey Map"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("question", 
                  label = "Choose the survey question to display:",
                  choices = quest.use[[2]],
                  selected = quest.use[[2]][1])
    ),
    
    mainPanel(
      plotOutput('plot')
    )
  )
  
))