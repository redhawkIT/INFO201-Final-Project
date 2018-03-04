# IMPORTS
# relative.path <- '~info201/INFO201-Final-Project'
# setwd(relative.path)

# emissions.data <- read.csv(
#   './data/WDI_emissions_Data.csv',
#   fileEncoding = 'UTF-8-BOM',
#   stringsAsFactors = FALSE
# )

source('./ui.R')
source('./server.R')

# START APPLICATION
shinyApp(ui = the.ui, server = the.server)
