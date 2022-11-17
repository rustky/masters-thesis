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
  h = c("$s_{j_1}=1$", "$s_{j_2}=-1$","$s_{j_3}=1$",
        "$s_{j_4}=-1$", "$s_{j_5}=1$")
)

colnames(dt) <- c('H1', 'H3','H5', 'y')
standAlone <- TRUE
suffix <- if(standAlone)"-standAlone" else ""
no.ext <- paste0("figure-fn-not-monotonic-error", suffix)
f.tex <- paste0(no.ext, ".tex")
tikz(file = '~/Documents/masters-thesis/hinge-loss.tex', standAlone = standAlone)
plot <- ggplot(dt)+
    geom_line(aes(H1, y))+
    geom_line(aes(H3, y))+
    geom_line(aes(H5, y))+
    geom_point(data = points, aes(x, y))+
    geom_text(data = points, aes(x,y, label = h, size = 30), nudge_y = 1)+
    geom_segment(aes(x = -5, xend = -3,y = -0.75, yend = -0.75), size = 3, color = 'red')+
    geom_segment(aes(x = 1, xend = 3,y = -1.5, yend = -1.5), size = 3, color = 'red')+
    geom_segment(aes(x = -5, xend = 3,y = -2.25, yend = -2.25), size = 3, color = 'red')+
    theme(text = element_text(size = 20),
          legend.position = 'none')+
    xlab("Augmented Predictions")+
    ylab("Loss")+
    ggtitle("Sorted Predictions Acrue Loss")
print(plot)
dev.off()
tools::texi2dvi("~/Documents/masters-thesis/hinge-loss.tex",pdf=TRUE)
tools::texi2dvi("~/Documents/masters-thesis/hinge-loss.tex",pdf=TRUE)
# Error in plot.xy(xy.coords(x, y), type = type, ...) : 
  # plot.new has not been called yet

