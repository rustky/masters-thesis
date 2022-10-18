library(ggplot2)
library(plotly)
library(data.table)

x <- -5:5
y <- -5:5

space <- function(x,y){
  x^2 - y^2
}

z <- outer(x,y,space)
dt <- data.table(x,y,z)
dt <- melt(dt,id.vars = c('x','y'), value.name = 'z', measure.vars = c("V1",  "V2",  "V3",  "V4" , "V5",  "V6",  "V7" , "V8" , "V9"  ,"V10", "V11"))

ggplot(dt)+
  geom_contour_filled(aes(x,y,z=z))
