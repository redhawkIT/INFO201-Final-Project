source('./client/Overview.R')
source('./client/Instructions.R')

# BUG: Error in group_by(analysis, Year) : object 'analysis' not found
minVal <- group_by(analysis, Year) %>% summarize(mins = min(Valence)) %>% select(mins)

the.ui <- fluidPage(

# Sets theme using 'shinythemes'
theme = shinytheme('sandstone'),

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
        step = 0.5,
        value = as.numeric(ceiling(max(minVal))), 
        width = '150%',
        round = FALSE
      ),
      
      hr(),
      
      uiOutput('ui'),
  
      tags$i("If all checkboxes in below controls are unselected, results behave as if all are selected for that metric!"),
  
      checkboxGroupInput(
        'category',
        label = h4('Categories of Request to Include in Analysis'),
        choices = unique(analysis$Category),
        selected = 'Portable'
      ),
  
      checkboxGroupInput(
        'year',
        label = h4('Which years to include?'),
        choices = list(
          '2014' = 2014,
          '2015' = 2015,
          '2016' = 2016,
          '2017' = 2017
        ),
          selected = '2017'
      )
    ),

    # Main panel for displaying outputs
    mainPanel(
      tabsetPanel(
        type = 'tabs',
        id = 'tab',
        
        tabPanel('Overview', Overview()),
        # TODO
        #tabPanel('Instructions', Instructions()),
        tabPanel('Graphical Analyis',  tabsetPanel(
          tabPanel('Bar Graph',  plotOutput('graph')),
          tabPanel('Scatterplot', plotOutput('scatter'))
        )),
        tabPanel('Tabular Analysis', dataTableOutput('table')),
        tabPanel('Summary Table' ,tableOutput('summary'), value = "sum.ui")
      )
    )
  )
)