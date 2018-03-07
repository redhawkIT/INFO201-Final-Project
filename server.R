the.server <- function(input, output) {

  
  filtered <- reactive({
    filt <- analysis %>% filter(
      Valence <= input$range
      & Year == input$year
      & Category == input$category
    )
    return(filt)
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
      'summary' =  sliderInput(
        'range',
        label = h3('Which Years to Compare?'),
        min = 2014,
        max = 2017,
        value = c(2014, 2017),
        sep = ''
      )
    )
  })

  output$table <- renderTable({
    filtered() %>% select(Title, Organization, Asked, Received, Negative, Positive, Valence)
  })


  output$graph <- renderPlot({
    dist <- input$dist
    n <- input$n

    hist(placeholder2(),
         main = 'Title of Histogram',
         col = '#75AADB',
         border = 'white')
  })

  output$summary <- renderTable({
    placeholder3
  })

}
