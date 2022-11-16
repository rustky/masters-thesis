library(data.table)
library(tikzDevice)
library(ggplot2)

parabola <- function(h){
  input <- seq(-5,5, by= 0.5)
  y <- input^2
  x <- numeric(21)
  x[0:10] <- -sqrt(y[0:10])+h
  x[11:21] <- sqrt(y[11:21])+h
  return(x)
}

h_vals <- c(-5,-3, 1,3, 5)

x.list <- list()
for(hs in h_vals){
  x.list[[paste(hs)]] <- parabola(hs)  
}
  
dt <- data.table(do.call(cbind, x.list))
dt$y <- seq(-5,5, by= 0.5)^2

points <- data.table(
  x = h_vals,
  y = c(0,0,0,0,0),
  h = c(TeX(r"($s_{j_1}$)"), TeX(r"($s_{j_2}$)"),TeX(r"($s_{j_3}$)"),
        TeX(r"($s_{j_4}$)"),TeX(r"($s_{j_5}$)") )
)

colnames(dt) <- c('H1', 'H2', 'H3', 'H4','H5', 'y')
tikz(file = hinge-loss.tex)
plot <- ggplot(dt)+
    geom_line(aes(H1, y))+
    geom_line(aes(H2, y))+
    geom_line(aes(H3, y))+
    geom_line(aes(H4, y))+
    geom_line(aes(H5, y))+
    geom_point(data = points, aes(x, y))+
    geom_text(data = points, aes(x,y, label = h, size = 10), nudge_y = 1)+
    geom_segment(aes(x = -5, xend = -3,y = -0.75, yend = -0.75), size = 3, color = 'red')+
    geom_segment(aes(x = 1, xend = 3,y = -1.5, yend = -1.5), size = 3, color = 'red')+
    geom_segment(aes(x = -5, xend = 3,y = -2.25, yend = -2.25), size = 3, color = 'red')+
    theme(text = element_text(size = 20),
          legend.position = 'none')+
    xlab("Augmented Predictions")+
    ylab("Loss")+
    ggtitle("How Sorted Augmented Predictions Acrue Loss")
plot.new()
print(plot)

