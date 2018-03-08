# Builds 'the.server'
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
            & Category == input$category
          )
        )
      } else if (is.null(input$category) & !is.null(input$year)) {
        analysis %>% filter(
          Valence <= input$range
          & Year == input$year
        )
      } else {
        return(
          analysis %>% filter(
            Valence <= input$range
          )
        )
      }
    } else
      return(
        analysis %>% filter(
          Valence <= input$range
          & Year == input$year
          & Category == input$category
        )
      )
  })
<<<<<<< HEAD
  
=======

>>>>>>> 09fb14318d3fcc2356178d9c69368c3f379590e3
  output$ui <- renderUI({
    switch(
      input$tab,
      'graph' = NULL,
      'table' = NULL,
<<<<<<< HEAD
      'sum.ui' = radioButtons('tab.select', "Select a Summarization:", choices = c("1", "2", "3"),
                              selected = "1", inline = T)
    )
  })
  
  output$table <- renderDataTable({
    filtered() %>% select(Title, Organization, Asked, Received, Anticipation, Trust, Joy, Valence)
  })
  
=======
      'sum.ui' = radioButtons('tab.select', "Select a Summarization:", choices = c("1", "2", "3", "4"),
                              selected = "1", inline = T)
    )
  })

  output$table <- renderDataTable({
    filtered() %>% select(Title, Organization, Asked, Received, Anticipation, Trust, Joy, Valence)
  })

>>>>>>> 09fb14318d3fcc2356178d9c69368c3f379590e3
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
<<<<<<< HEAD
=======
  })
  
  output$scatter <- renderPlot({
    ggplot(data = filtered()) +
      geom_point(mapping = aes(x = Valence, y = Received), color = "red") +
      labs(title = "Valence versus Money Received",
           x = "Valence",
           y = "Money Received in Dollars")
>>>>>>> 09fb14318d3fcc2356178d9c69368c3f379590e3
  })
  
  output$scatter <- renderPlot({
    ggplot(data = filtered()) +
      geom_point(mapping = aes(x = Valence, y = Received), color = "red") +
      labs(title = "Valence versus Money Received",
           x = "Valence",
           y = "Money Received in Dollars")
  })
  
  
  sum.data <- reactive({
    category.sums <- group_by(filtered(), Category) %>% 
      summarize(Avg.amount.asked = mean(Asked), Avg.amount.received = mean(Received),
                Max.received = max(Received), Median.recieved = median(Received), Standard.dev = sd(Received))
    valence.sums <- mutate(filtered(), Valence.Group = cut(filtered()$Valence,
                                                           breaks = c(0, 5, 10, 15, 20, 25, 30, 35, 40),
                                                           labels = c("0 - 5", "5 - 10", "10 - 15", "15 - 20",
                                                                      "20 - 25", "25 - 30", "30 - 35",
                                                                      "35 - 40")))
    valence.sums <- group_by(valence.sums, Valence.Group) %>% 
      summarize(Avg.amount.asked = mean(Asked), Avg.amount.received = mean(Received),
                Max.received = max(Received), Median.recieved = median(Received), Standard.dev = sd(Received))
    endorsement.sums <- filtered() %>% 
      mutate(Endorsements = unlist(filtered()$Endorsements, use.names = FALSE))
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
    return(list(cat = category.sums, val = valence.sums, endo = endorsement.sums))
  })
  
  output$summary <- renderTable({
    if(input$tab.select == '1') {
      sum.data()$cat
    } else if(input$tab.select == '2') {
      sum.data()$val
    } else {
      sum.data()$endo
    }
  })
<<<<<<< HEAD
  
=======

>>>>>>> 09fb14318d3fcc2356178d9c69368c3f379590e3
}