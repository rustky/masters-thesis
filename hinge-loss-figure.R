library(data.table)
library(tikzDevice)
library(ggplot2)

parabola <- function(h){
  input <- seq(-3,3, by= 0.25)
  y <- input^2
  x <- numeric(25)
  x[0:12] <- -sqrt(y[0:12])+h
  x[13:25] <- sqrt(y[13:25])+h
  return(x)
}

h_vals <- c(-5, 1, 5)

x.list <- list()
for(hs in h_vals){
  x.list[[paste(hs)]] <- parabola(hs)  
}
  
dt <- data.table(do.call(cbind, x.list))
dt$y <- seq(-3,3, by= 0.25)^2
dt$y[0:12] <- 0

points <- data.table(
  x = c(-5, -3, 1, 3, 5),
  y = c(0,0,0,0,0),
  h = c("$y_{s_1}=1$", "$y_{s_2}=-1$","$y_{s_3}=1$",
        "$y_{s_4}=-1$", "$y_{s_5}=1$")
)

colnames(dt) <- c('H1', 'H3','H5', 'y')
standAlone <- TRUE
suffix <- if(standAlone)"-standAlone" else ""
tikz(file = '~/Documents/masters-thesis/hinge-loss.tex', standAlone = standAlone)
plot <- ggplot(dt)+
    geom_line(aes(H1, y))+
    geom_line(aes(H3, y))+
    geom_line(aes(H5, y))+
    geom_point(data = points, aes(x, y))+
    geom_text(data = points[c(1,3,5),], aes(x,y, label = h), size = 8,
              nudge_y = -.5)+
    geom_text(data = points[c(2,4),], aes(x,y, label = h), size = 8,
              nudge_y = .5, nudge_x = .5)+
    geom_segment(aes(x = -5, xend = -3,y = -1.25, yend = -1.25), linewidth = 3, color = 'red')+
    geom_segment(aes(x = 1, xend = 3,y = -2, yend = -2), linewidth = 3, color = 'red')+
    geom_segment(aes(x = -5, xend = 3,y = -2.75, yend = -2.75), linewidth = 3, color = 'red')+
    theme(text = element_text(size = 20),
          legend.position = 'none')+
    xlab("Augmented Predictions")+
    ylab("Loss")+
    ggtitle("Sorted Predictions Acrue Loss")+
    ylim(-2.9, 9)
print(plot)
dev.off()
tinytex::pdflatex("~/Documents/masters-thesis/hinge-loss.tex")
# Error in plot.xy(xy.coords(x, y), type = type, ...) : 
  # plot.new has not been called yet

