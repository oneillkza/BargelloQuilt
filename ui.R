library(shiny)
library(ggplot2)
library(RColorBrewer)

dataset <- diamonds

fluidPage(

  titlePanel("Bargello Quilt Designer"),

  sidebarPanel(

    sliderInput('n.fabrics', 'Number of Fabrics', min=4, max=48,
                value=24, step=1, round=0),

    selectInput('pal', 'Palette', rownames(brewer.pal.info)[which(brewer.pal.info$category=='seq')])
    # selectInput('y', 'Y', names(dataset), names(dataset)[[2]]),
    # selectInput('color', 'Color', c('None', names(dataset))),
    # 
    # checkboxInput('jitter', 'Jitter'),
    # checkboxInput('smooth', 'Smooth'),
    # 
    # selectInput('facet_row', 'Facet Row', c(None='.', names(dataset))),
    # selectInput('facet_col', 'Facet Column', c(None='.', names(dataset)))
  ),

  mainPanel(
    plotOutput('plot')
  )
)