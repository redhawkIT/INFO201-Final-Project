the.ui <- fluidPage(
  # App title ----
  titlePanel('Best AC Group's Final Project'),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    # Sidebar panel for inputs
    sidebarPanel(
      # This slider will allow user to filter ouptuded data based on range of sentiments.
      sliderInput(
        'range',
        label = h3('How Positive Will the Proposal Be?'),
        min = -5,
        max = 5,
        value = c(-1, 2),
        width = '200%',
        round = FALSE
      ),

      checkboxGroupInput(
        'category',
        label = h3('Categories of Request to Include in Analysis'),
        choices = unique(body$category)
      ),

      uiOutput('ui')

    ),

    # Main panel for displaying outputs
    mainPanel(
      tabsetPanel(
        type = 'tabs',
        id = 'tab',
        # Would be a historgram of the
        tabPanel('Graphical Analyis', value = 'graph'),
        tabPanel('Tabular Analysis', value = 'table') ,
        tabPanel('Summary Table', value = 'summary')
      )
    )
  )
)
