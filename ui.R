source('./client/Overview.R')
source('./client/Instructions.R')

# BUG: Error in group_by(analysis, Year) : object 'analysis' not found
minVal <- group_by(analysis, Year) %>% summarize(mins = min(Valence)) %>% select(mins)

the.ui <- fluidPage(
  # App title ----
  titlePanel('UW Student Technology - Funding Statistics'),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    # Sidebar panel for inputs
    sidebarPanel(
      # This slider will allow user to filter ouptuded data based on range of sentiments.
      sliderInput(
        'range',
        label = h3('Valence Filter'),
        min = as.numeric(ceiling(max(minVal))),
        max = as.numeric(floor(analysis$Valence[analysis$Valence == max(analysis$Valence)]))[1],
        step = 1,
        value = as.numeric(ceiling(max(minVal))), 
        width = '200%',
        round = FALSE
      ),
      
      checkboxGroupInput(
        'category',
        label = h3('Categories of Request to Include in Analysis'),
        choices = unique(analysis$Category),
        selected = 'Portable'
      ),
      
      checkboxGroupInput(
        'year',
        label = h3('Which years to include?'),
        choices = list(
          '2014' = 2014,
          '2015' = 2015,
          '2016' = 2016,
          '2017' = 2017),
        selected = '2017'
      ),
      
      uiOutput('ui')
      
    ),
    
    # Main panel for displaying outputs
    mainPanel(
      tabsetPanel(
        type = 'tabs',
        id = 'tab',
        # Displays a table of 'test', which calls 'filtered()', a reactive filter that
        # creates a table based on the static UI filters.
        tabPanel('Overview', Overview()),
        tabPanel('Instructions', Instructions()),
        tabPanel('Graphical Analyis', plotOutput('graph')),
        tabPanel('Scatterplot Analysis', plotOutput('scatter')),
        tabPanel('Tabular Analysis', dataTableOutput('table')),
        tabPanel('Summary Table', tableOutput('summary'), value = "sum.ui")
      )
    )
  )
)