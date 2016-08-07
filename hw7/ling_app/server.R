library(shiny)
library(readr)
library(dplyr)
library(ggplot2)
library(scales)

df <- read_csv("data/lingData_cleaned.csv")

# Wrap labels to new line if past certain len
wrap.it <- function(x, len) { 
  sapply(x, function(y) paste(strwrap(y, len), 
                              collapse = "\n"), 
         USE.NAMES = FALSE)
}
wrap.labels <- function(x, len) {
  if (is.list(x)) {
    lapply(x, wrap.it, len)
  } else {
    wrap.it(x, len)
  }
}

shinyServer(function(input, output) {
  output$plot <- renderPlot({
    data <- filter(df, quest == input$question)
    ggplot(data) +
      geom_polygon(aes(x = long, y = lat, group = group, fill = ans), 
                   color = "black") +
      theme(
        axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        panel.border = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        panel.background = element_blank()
      ) +
      labs(title = wrap.labels(input$question, 80),
           fill = "Answer") +
      scale_fill_discrete(labels = wrap_format(20)) +
      coord_fixed(1.3)
  })
})