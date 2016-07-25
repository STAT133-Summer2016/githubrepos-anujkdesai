library(shiny)
library(ggplot2)
library(dplyr)

shinyServer(function(input, output) {
  
  output$plot <- renderPlot({
    dataset <- diamonds %>% 
      filter(cut == input$cut, color %in% input$color)
    ggplot(dataset, aes_string(x = input$variable, y = "price")) +
      geom_point()
  })
})