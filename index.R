## WEB SERVER
source('./ui.R')
source('./server.R')

## START APPLICATION
shinyApp(ui = the.ui, server = the.server)