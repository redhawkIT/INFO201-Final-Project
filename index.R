## WEB SERVER
source('./server.R')
source('./ui.R')

## START APPLICATION
shinyApp(ui = the.ui, server = the.server)