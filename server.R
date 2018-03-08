# Builds the server for our Project's shinyapp
the.server <- function(input, output) {
  
  #### DEPENDENCIES
  ### Utilities
  # install.packages('Hmisc')
  ### Web Packages
  # install.packages('shiny')
  # install.packages("shinythemes")
  # install.packages('httr')
  # install.packages('jsonlite')
  ### Data Manipulation:
  # install.packages('dplyr')
  # install.packages('tidyr')
  ### Text Mining:
  # install.packages('tidytext')
  # install.packages('tm')
  # install.packages('SnowballC')
  # install.packages('syuzhet')
  ### Visualization:
  # install.packages('ggplot2')
  
  # Loads the libraries that our shinyapp is dependent on. 
  library(shiny)
  library(shinythemes)
  library(Hmisc)
  library(httr)
  library(jsonlite)
  library(dplyr)
  library(tidyr)
  library(tidytext)
  library(tm)
  library(syuzhet)
  library(SnowballC)
  library(ggplot2)
  
  ## IMPORTS
  source('./src/GetProposals.R')
  source('./src/AnalyzeProposals.R')
  
  ## DATA COLLECTION & ANALYSIS
  proposals <- GetProposals()
  analysis <- AnalyzeProposals(proposals)
  
  filtered <- reactive({
    if (is.null(input$year) | is.null(input$category)) {
      if (is.null(input$year) & !is.null(input$category)) {
        return(
          analysis %>% filter(
            Valence <= input$range
            & Category %in% input$category
          )
        )
      } else if (is.null(input$category) & !is.null(input$year)) {
        analysis %>% filter(
          Valence <= input$range
          & Year %in% input$year
        )
      } else {
        return(
          analysis %>% filter(
            Valence <= input$range
          )
        )
      }
    } else {
      return(
        analysis %>% filter(
          Valence <= input$range, 
          Year %in% input$year, 
          Category %in% input$category
        )
      )
    }
  })
  
  output$valence.slider <- renderUI({
    minVal <- group_by(analysis, Year) %>% summarize(mins = min(Valence)) %>% select(mins)
    sliderInput(
      'range',
      label = h3('Valence Filter'),
      min = ceiling(max(minVal))[1],
      max = max(floor(analysis$Valence)),
      step = 0.5,
      value = round(max(analysis$Valence)/2), #TODOround((min(analysis$Valence)+max(analysis$Valence))/2), 
      width = '150%',
      round = FALSE
    )
  })
  
  output$categories <- renderUI({
    checkboxGroupInput(
      'category',
      label = h4('Categories of Request to Include in Analysis'),
      choices = unique(analysis$Category),
      selected = 'Portable'
    )
  })
  
  output$dynamic.ui <- renderUI({
    switch(
      input$tab,
      'graph' = NULL,
      'table' = NULL,
      'sum.ui' = NULL
    )
  })
  
  output$table <- renderDataTable({
    filtered() %>% select(Title, Organization, Asked, Received, Anticipation, Trust, Joy, Valence)
  })
  
  output$graph <- renderPlot({
    filtered.table <- filtered()
    emotions <- select(filtered.table, Anger, Anticipation, Disgust, Fear, Sadness, Surprise, Trust)
    emotions.means <- c(mean(emotions$Anger), mean(emotions$Anticipation), mean(emotions$Disgust),
                        mean(emotions$Fear), mean(emotions$Sadness), mean(emotions$Surprise),
                        mean(emotions$Trust))
    barplot(emotions.means, main = "Average Emotion for Given Categories",
            xlab = "Emotions",
            names.arg = colnames(emotions),
            col = c("red", "orange", "yellow", "green",
                    "blue", "purple", "black"))
  })
  
  output$scatter <- renderPlot({
    ggplot(data = filtered()) +
      geom_point(mapping = aes(x = Valence, y = Received), color = "red") +
      labs(title = "Valence versus Money Received",
           x = "Valence",
           y = "Money Received in Dollars")
  })
  
  # Creates a reactive function called 'sum.data' that returns a list. List contains all data required in the
  # summary visualizations. 
  sum.data <- reactive({
    
    # Groups data from reactive function filtered() by their category, and then uses this, along with summary
    # tools, to create data frame containing methods of central tendency and variability. 
    category.sums <- group_by(filtered(), Category) %>% 
      summarize(Avg.amount.asked = mean(Asked), Avg.amount.received = mean(Received),
                Max.received = max(Received), Median.recieved = median(Received), Standard.dev = sd(Received))
    
    # Groups data from filtered() by Valence, grouping Valence into several buckets. Assigns each bucket 
    # a label and then uses summary functions to create data frame containing methods of central tendency
    # and variability.
    valence.sums <- mutate(filtered(), Valence.Group = cut(filtered()$Valence,
                                                           breaks = c(0, 5, 10, 15, 20, 25, 30, 35, 40),
                                                           labels = c("0 - 5", "5 - 10", "10 - 15", "15 - 20",
                                                                      "20 - 25", "25 - 30", "30 - 35",
                                                                      "35 - 40")))
    valence.sums <- group_by(valence.sums, Valence.Group) %>% 
      summarize(Avg.amount.asked = mean(Asked), Avg.amount.received = mean(Received),
                Max.received = max(Received), Median.recieved = median(Received), Standard.dev = sd(Received))
    
    # Determines if filtered is empty or not. If so, returns empty data frame. Otherwise, unlists Endorsements 
    # into a vector of numbers and groups data from filtered() Endorsement numbers. Uses this to create a
    # data frame with methods of central tendency and variability.
    endorsement.sums <- filtered()
    if (nrow(filtered()) >= 1) {
      endorsement.sums <- mutate(endorsement.sums, Endorsements = unlist(filtered()$Endorsements,
                                                                         use.names = FALSE))
      endorsement.sums <- mutate(endorsement.sums, Endorsement.group = cut(endorsement.sums$Endorsements,
                                                                           breaks = c(-1, 5, 10, 20,
                                                                                      30, 45, 80, 100, 200),
                                                                           labels = c("-1 - 5", "5 - 10",
                                                                                      "10 - 20", "20 - 30",
                                                                                      "30 - 45", "45 - 80",
                                                                                      "80 - 100", "100 - 200")))
      endorsement.sums <- group_by(endorsement.sums, Endorsement.group) %>%
        summarize(Avg.amount.asked = mean(Asked), Avg.amount.received = mean(Received),
                  Max.received = max(Received), Median.recieved = median(Received), Standard.dev = sd(Received))
    } 
    return(list(cat = category.sums, val = valence.sums, endo = endorsement.sums))
  })
  
  # Outputs a table containing summary information for requests based on the category that the request falls
  # into
  output$cat <- renderTable({
    sum.data()$cat
  })
  
  # Outputs a table containing summary information for requests based on the valence of the request
  output$val <- renderTable({
    sum.data()$val
  })
  
  # Outputs a table containing summary information for requests based on the endorsements that the request had
  output$endo <- renderTable({
    sum.data()$endo
  })
  
}