library("shiny")

library("ggplot2")

library("dplyr")

library("tidyr")

#source("")

#data <- 

the.server <- function(input, output) {

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

  output$hist <- renderPlot({

    dist <- input$dist

    n <- input$n

    hist(placeholder2(),

         main = "Title of Histogram",

         col = "#75AADB", border = "white")

  })

}