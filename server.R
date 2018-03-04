the.server <- function(input, output) {
  
  # DEPENDENCIES 
  # install.packages("shiny")
  # install.packages("dplyr")
  # install.packages("tidyr")
  # install.packages("ggplot2")
  
  # library("shiny")
  # library("dplyr")
  # library("tidyr")
  # library("ggplot2")
  
  # imports Joel Ross's provided script that takes latitude and longitude and returns a country name
  # source("spatial_utils.R")
  
  # imports WDI emissions data, removes all rows with NA values
  # my.data <- read.csv("data/WDI_emissions_Data.csv", fileEncoding = 'UTF-8-BOM', stringsAsFactors = FALSE)
  # my.data <- na.omit(my.data)
  
  # Creates a reatcive table that changes with user input
  # datum <- reactive({
  #   table <- filter(my.data, Series.Code == input$indic) %>%
  #   select_('Country.Code', 'Series.Code', paste0('YR', input$year), 'Most_Recent') %>% 
  #   mutate(Country.Name = countrycode(Country.Code, 'iso3c', 'country.name'))
  #   return(table[,c(5, 1, 2, 3, 4)])
  # })
    
  # Generate an HTML table view of the data ----
  # output$table <- renderTable({
  #   datum()
  # })
  
}