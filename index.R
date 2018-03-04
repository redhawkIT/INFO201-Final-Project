# DEPENDENCIES
# install.packages('shiny')
library(shiny)

# IMPORTS
relative.path <- '~info201/INFO201-Final-Project'
setwd(relative.path)

emissions.data <- read.csv(
  './data/WDI_emissions_Data.csv',
  fileEncoding = 'UTF-8-BOM',
  stringsAsFactors = FALSE
)
emissions.metadata <- read.csv(
  './data/WDI_emissions_Definition and Source.csv',
  fileEncoding = 'UTF-8-BOM',
  stringsAsFactors = FALSE
)
source('./server/index.R')
source('./client/index.R')
ui <- App()

# START APPLICATION
shinyApp(ui, server)
