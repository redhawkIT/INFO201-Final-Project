the.server <- function(input, output) {
  
  # TODO
  # to be changed to 'reactive' because end user will not see this value
  # filtered <- reactive({ 
  #   filtered <- analysis %>% filter(
  #     Valence <= input$range 
  #     & Year == input$year
  #     & Catrgory == input$category
  #   )
  # })
  # 
  # output$test <- verbatimTextOutput({
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

  placeholder1 <- reactive({
    positivity <- input$range
    year.filter <- input$years
    categories <- input$category
    filtered.data <- data
    return()
  })

  output$table <- renderTable({
    placeholder1()
  })

  placeholder2 <- reactive({
    return()
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
