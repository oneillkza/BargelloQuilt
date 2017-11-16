library(RColorBrewer)
library(tidyverse)

makeBargello <- function(n.fabrics=24, 
                         type='sine', 
                         symmetrical=FALSE, 
                         strip.width=2.5, 
                         step.width=0.25,
                         col.pal='Blues')
{
    bargello.layout <- data.frame(strip.number=1:n.fabrics, length=rep(strip.width, n.fabrics))
    n.steps <- floor(strip.width/step.width) # strip.width is max
    
    bargello.layout$width <- ceiling(((sin(1:n.fabrics/n.fabrics*4) +1)/2)*n.steps)*step.width 
    bargello.layout$x <- cumsum(bargello.layout$width)
    
    colour.map <- colorRampPalette(brewer.pal(9, col.pal))( n.fabrics)
    names(colour.map) <- 1:n.fabrics
    
    
    
    makeOneStrip <- function(start.fabric, n.fabrics)
    {
        if(start.fabric ==1)
            this.strip <- start.fabric:n.fabrics
        else
            this.strip <- c(start.fabric:n.fabrics, 1:(start.fabric-1))
        return(this.strip)
    }
    bargello.mat <-  as.data.frame(sapply(1:n.fabrics, makeOneStrip, n.fabrics))
    colnames(bargello.mat) <- 1:n.fabrics
    bargello.mat$column <- 1:n.fabrics
    
    bargello.frame <- gather(as.data.frame(bargello.mat), row, fabric, -column)
    bargello.frame <- mutate(bargello.frame, y=column*strip.width)
    bargello.frame$row <- as.numeric(bargello.frame$row)
    bargello.frame <- mutate(bargello.frame, x=bargello.layout$x[row])
    bargello.frame <- mutate(bargello.frame, width=bargello.layout$width[row]) 
    bargello.frame$fabric <- as.factor(bargello.frame$fabric)
    
   
   return(list(bargello.frame = bargello.frame, 
               bargello.layout = bargello.layout,
               colour.map = colour.map)) 
}
