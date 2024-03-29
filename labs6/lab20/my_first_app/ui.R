shinyUI(fluidPage(
  titlePanel("Occupancy Rates in Berkeley"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Upload an XML file with the Census Data to get started"),
      
      fileInput("file", label = "File Input"),
      
      selectInput("neighborood",
                  label = "Choose the neighborhood to inspect",
                  choices = list("North Berkeley",
                                 "Rockridge",
                                 "Downtown Berkeley",
                                 "Berkeley Hills"),
                  selected = "North Berkeley"),
      
      sliderInput("people",
                  label = "Number of People in Household:",
                  min = 0,
                  max = 40, 
                  value = c(0,40))
    ),
    
    mainPanel()
  )
))