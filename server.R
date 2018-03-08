the.server <- function(input, output) {

  
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
  
  # Makes table test that returns a full proposals table of 
  # output$test <-  renderTable({
  #   filtered()
  # })

  output$ui <- renderUI({
    switch(
      input$tab,
      'graph' = NULL,
      'table' = NULL,
      'sum.ui' = radioButtons('tab.select', "Select a Summarization:", choices = c("1", "2", "3", "4"),
                              selected = "1")
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
    return(list(cat = category.sums, val = valence.sums))
  })
  
  output$summary <- renderTable({
    if(input$tab.select == '1') {
      sum.data()$cat
    } else {
      sum.data()$val
    }
  })

}