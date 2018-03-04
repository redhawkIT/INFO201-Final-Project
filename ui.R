the.ui <- fluidPage(
  
  # App title ----
  titlePanel("Best AC Group's Final Project"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs
    sidebarPanel(
      
      # This slider will allow user to filter ouptuded data based on range of sentiments.
      sliderInput("range", 
                  label = h3("How Positive Will the Proposal Be?"),
                  min = -5, max = 5, value = c(-1, 2), sep = ''
      ),
      
      # These checkboes will allow user to filter data by year
      checkboxGroupInput("years", label = h3("Which years to include?"), 
                         choices = list("2014" = 2014, "2015" = 2015, "2016" = 2016, "2017" = 2017),
                         selected = 2014
      ),
      
      # These checkboxes will allow user to 
      checkboxGroupInput("category", label = h3("Categories of Study"), 
                         choices = unique(body$category)
                         )
    ),
    
    # Main panel for displaying outputs
    mainPanel(
      tabsetPanel(type = "tabs", id = "tab", 
                  # Would be a historgram of the 
                  tabPanel("Graphical Analyis", value = "graph"),
                  tabPanel("Tabular Analysis", value = "table") ,
                  tabPanel("Summary Table", value = "summary")
      )
    )
  )
)


