library("shiny")

library("ggplot2")

library("dplyr")

library("tidyr")

#source("")

#data <- 

the.server <- function(input, output) {
  
  output$ui <- renderUI({
    switch(input$tab,
              "graph" = NULL,
              "table" = checkboxGroupInput("years", label = h3("Which years to include?"), 
                                           choices = list("2014" = 2014, "2015" = 2015, "2016" = 2016, 
                                                          "2017" = 2017),
                                           selected = 2014
              ),
              "summary" =  sliderInput("range", 
                                       label = h3("Which Years to Compare?"),
                                       min = 2014, max = 2017, value = c(2014, 2017), sep = ''
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
         main = "Title of Histogram",
         col = "#75AADB", border = "white")

  })
  
  placeholder3 <- reactive({
    
    return()
    
  })
  
  output$summary <- renderTable({
    
    placeholder3
    
  })

}