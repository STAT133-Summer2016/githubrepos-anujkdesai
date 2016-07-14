library(shiny)
library(ggplot2)
library(dplyr)
library(stringr)

shinyServer(function(input, output) {
  
  dataset <- reactive({
    diamonds %>% 
      filter_((str_c("color ==", input$color))) %>% 
      filter_((str_c("cut ==", input$cut)))
  })
  
  output$plot <- renderPlot({
    p <- ggplot(dataset(), aes_string(x = input$variable, y = diamonds$price)) +
      geom_point() +
      labs(y = "price")
    
    print(p)
  })
})