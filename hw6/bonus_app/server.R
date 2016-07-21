library(shiny)
library(readr)
library(dplyr)
library(ggvis)
library(scales)

cleaned <- read.csv("data/cleaned_demographics.csv") %>% 
  filter(gdp >= 500 & gdp <= 100000) %>% 
  filter(lifeexpectancy >= 18 & lifeexpectancy <= 80)

shinyServer(function(input, output) {
  clean <- reactive({
    cleaned <- filter(cleaned, year == input$slider)
    cleaned
  })
  
  all_values <- function(x) {
    paste0(x$country)
  }
  
  clean %>% 
    ggvis(~gdp, ~lifeexpectancy, size = ~population, opacity := 0.8,
          key := ~country, stroke := 2) %>%
    layer_points(fill = ~Group) %>% 
    add_axis("x", title = "GDP Per Capita (Inflation-Adjusted)",
             value = c(500, 5000, 50000), 
             format = "d",
             properties = axis_props(
               title = list(fontSize = 18)
             )) %>% 
    scale_numeric("x", domain = c(400, 100000), trans = "log", expand = 0) %>% 
    scale_numeric("y", domain = c(18, 80)) %>% 
    scale_numeric("size", range = c(25, 2000)) %>% 
    add_axis("y", title = "Life Expectancy at Birth",
             value = c(25, 50, 75), 
             properties = axis_props(
               title = list(fontSize = 18)
             )) %>% 
    add_legend("fill", title = "Region") %>% 
    hide_legend("size") %>% 
    set_options(width = "auto", height = "400", resizable = FALSE) %>% 
    add_tooltip(all_values, on = c("hover")) %>% 
    bind_shiny("plot", "plot_ui")
})