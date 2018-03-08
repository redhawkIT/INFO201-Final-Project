source('./client/Overview.R')
source('./client/Instructions.R')

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
      uiOutput('valence.slider'),
      
      hr(),
      
      uiOutput('dynamic.ui'),
      
      tags$i("If all checkboxes in below controls are unselected,
             results behave as if all are selected for that metric!"),
      
      uiOutput('categories'),
      
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
        tabPanel('Summary Table' , tabsetPanel(
          tabPanel('Category Summary', tableOutput('cat')), 
          tabPanel('Valence Summary', tableOutput('val')), 
          tabPanel('Endorsement Summary', tableOutput('endo'))
        ))
      )
    )
  )
)