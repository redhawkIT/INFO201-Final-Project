# BOILERPLATE SOURCE: http://shiny.rstudio.com/gallery/tabsets.html
# Using Shiny docs for core UI scaffolding

# Define UI for app that draws a histogram ----
App <- function() {
  ui <- fluidPage(
    # App title ----
    titlePanel('World Development Indicators'),
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
      # Sidebar panel for inputs ----
      sidebarPanel(
        # Input: Select the random distribution type ----
        headerPanel('Controls')
        radioButtons(
          'dist', 'Distribution type:',
           c(
             'Normal' = 'norm',
             'Uniform' = 'unif',
             'Log-normal' = 'lnorm',
             'Exponential' = 'exp'
           )
         ),
        # br() element to introduce extra vertical spacing ----
        br(),
        # Input: Slider for the number of observations to generate ----
        sliderInput(
          'n',
          'Number of observations:',
          value = 500,
          min = 1,
          max = 1000
        )
      ),

      # Main panel for displaying outputs ----
      mainPanel(
        # Output: Tabset w/ plot, summary, and table ----
        tabsetPanel(
          type = 'tabs',
          tabPanel('Table', tableOutput('table'))
          tabPanel('Map', p('ggplot2 map here'))
        )
      )

    )

  )
  # Returns UI (prevents scoping issues / side effects and better for stack traces)
  return(ui)
}
