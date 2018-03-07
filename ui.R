minVal <-
  group_by(analysis, Year) %>% summarize(mins = min(Valence)) %>% select(mins)

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
        min = ceiling(max(minVal))[1],
        # TODO: Can someone please check out the following lines and see what the issue is with non-binary arguments?
        max = floor(analysis$Valence[analysis$Valence == max(analysis$Valence)])[1],
        # value = as.numeric(floor((min + max) / 2)),
        value = 5,
        # NOTE: Placeholder value
        step = 1,
        width = '200%',
        round = FALSE
      ),
      
      checkboxGroupInput(
        'category',
        label = h3('Categories of Request to Include in Analysis'),
        choices = unique(proposals$Category),
        selected = 'Portable'
      ),
      
      checkboxGroupInput(
        'year',
        label = h3('Which years to include?'),
        choices = list(
          '2014' = 2014,
          '2015' = 2015,
          '2016' = 2016,
          '2017' = 2017
        ),
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
        #tabPanel('Test', tableOutput('test')),
        tabPanel(
          'Overview',
          tags$h2('About Campus Technology Projects'),
          tags$strong('How student fees are used by the University'),
          tags$p(
            paste(
              'Every student at the university pays a mandatory $38 quarterly fee to fund student technology projects.',
              'This funding is managed by a student organization chartered by the State of Washington Legislature and the UW Board of Regents known as the Student Technology Committee.',
              'The Committee issues a request for proposals (RFP) annually for departments to come and pitch technology projects that directly benefit the student body.',
              'This process is entirely transparent, as the Committee is bound by the Open Public Meetings Act (RCW 42.30) to disclose data on all proposals, including exact minutes from all Committee meetings and deliberations.',
              sep = ''
            )
          ),
          tags$p(
            paste(
              'This project leverages information provided by the UW Student Technology Committee API about campus technology projects to determine the following:',
              sep = ''
            )
          ),
          tags$ul(
            tags$li(
              tags$em('For students,'),
              'where are their funds going? Is there bias in the way their funds are used to support projects?'
            ),
            tags$li(
              tags$em('For departments,'),
              'what elements of a proposal contribute to its success? Could you build rapport with the commitee and ask for more money year-to-year? Is seeking endorsements worthwhile?'
            ),
            tags$li(
              tags$em('For researchers,'),
              
              'what are the modulating factors that determine the success of a proposal? Could the degree to which emotions are woven into a project\'s narrative be a determining factor in committee decisions?'
            )
          ),
          tags$p(
            'We are able to provide data to answer these questions by drawing raw proposal data directly from the Student Technology Committee API, quantifying the financial aspects and endorsements for proposals, and performing linguistic analysis of the raw proposal text.'
          ),
          tags$hr(),
          tags$h3('Sources'),
          
          tags$ol(
            tags$li(
              'Linguistic Analysis: ',
              tags$a('NRC Dataset (provided with the R package "syuzhet")',
                     href = 'https://cran.r-project.org/web/packages/syuzhet/syuzhet.pdf')
            ),
            tags$li(
              'Open Public Meetings Act: ',
              tags$a('RCW 42.30', href = 'http://apps.leg.wa.gov/RCW/default.aspx?cite=42.30')
            ),
            tags$li(
              'Data Source (Student Fees): ',
              tags$a('UW Office of Planning and Budgeting',
                     href = 'http://opb.washington.edu/sites/default/files/opb/Tuition/2016-17 Tuition & Fee History.pdf')
            ),
            tags$li(
              'Data Source (Projects and Expenditures): ',
              tags$a('UW Student Technology Fee API',
                     href = 'https://uwstf.org/api')
            )
          )
        ),
        tabPanel(
          'Instructions',
          tags$p(
            paste('Add instructions here when the summary is completed.',
                  sep = '')
          ),
          tags$div(tags$h3('Valence Filter'),
                   tags$p(paste('...',
                                sep = ''))),
          tags$div(tags$h3('Categories'),
                   tags$p(paste('...',
                                sep = ''))),
          tags$div(tags$h3('Departments'),
                   tags$p(paste('...',
                                sep = ''))),
          tags$div(tags$h3('Year Selection'),
                   tags$p(paste('...',
                                sep = '')))
        ),
        tabPanel('Graphical Analyis', plotOutput('graph')),
        tabPanel('Tabular Analysis', tableOutput('table')),
        tabPanel('Summary Table', value = 'summary')
      )
    )
  )
)
