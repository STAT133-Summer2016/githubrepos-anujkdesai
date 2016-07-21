library(shiny)
library(readr)
library(dplyr)
library(ggplot2)
library(scales)

cleaned <- read.csv("data/cleaned_demographics.csv")

shinyServer(function(input, output) {
  output$plot <- renderPlot({
    cleaned <- filter(cleaned, year == input$slider)
    ggplot(cleaned, aes(x = gdp, y = lifeexpectancy)) +
      geom_point(aes(size = population, fill = Group), shape = 21, alpha = 0.8) + 
      scale_x_log10(limits = c(500, 100000), breaks = c(500, 5000, 50000),
                    labels = c("$500", "$5000", "$50000")) +
      scale_y_continuous(limits = c(18, 80), breaks = seq(25, 75, 25),
                         labels = c("25\n years", "50\n years", "75\n years")) + 
      scale_size(range = c(1, 20)) +
      scale_fill_manual(values = c("#97FF23", "#FF0066", "#F4FF42",
                                   "#9900CC", "#555555", "#0066FF")) +
      labs(x = "GDP Per Capita (Inflation-Adjusted)",
           y = "Life Expectancy at Birth", 
           title = input$slider,
           fill = "Region") +
      guides(size = FALSE) +
      theme(plot.title = element_text(size = 20),
            axis.title = element_text(size = 15),
            axis.text = element_text(size = 12),
            axis.title.x = element_text(margin = margin(10, 0, 0, 0)))
  })
})