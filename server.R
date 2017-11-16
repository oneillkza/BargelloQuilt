library(shiny)
library(ggplot2)

source('bargello.R')

function(input, output) {

  dataset <- reactive({
      makeBargello(n.fabrics = input$n.fabrics,
                   col.pal= input$pal)
    
  })

  output$plot <- renderPlot({

      bargello.data <- dataset()
       
    p <- ggplot(bargello.data$bargello.frame) + 
            aes(x=x, y=y, fill=fabric, width=width) + 
            geom_tile() + 
            scale_fill_manual(values=bargello.data$colour.map)
      
    #p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_tile()

    # if (input$color != 'None')
    #   p <- p + aes_string(color=input$color)
    # 
    # facets <- paste(input$facet_row, '~', input$facet_col)
    # if (facets != '. ~ .')
    #   p <- p + facet_grid(facets)
    # 
    # if (input$jitter)
    #   p <- p + geom_jitter()
    # if (input$smooth)
    #   p <- p + geom_smooth()

    print(p)

  }, height=700)

}