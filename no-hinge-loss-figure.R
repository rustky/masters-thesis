library(data.table)
library(tikzDevice)
library(ggplot2)

parabola <- function(x, b){
  c <- -b/x
  parabola <- x^2 + b*x + c
}
b_vals <- c(2,-4)
x <- seq(-4, 4, by = 0.25)

x.list <- list()
for(b in b_vals){
  x.list[[paste("y",abs(b),sep = "_")]] <- parabola(x, b)
  x.list[[paste("y_color",abs(b),sep = "_")]] <- paste("y",abs(b),sep = "_")
}

dt <- data.table(data.frame(x.list))
dt$y_total <- dt$y_2 + dt$y_4
dt$y_color_total <- rep("y_total", nrow(dt))
dt$x <- x

dt.tall <- melt(dt, id.vars = c("x"), measure.vars = c("y_[2,4,t]", "y_color*"), value.name = c("value", "color"))

standAlone <- TRUE
suffix <- if(standAlone)"-standAlone" else ""
tikz(file = '~/Documents/masters-thesis/no-hinge-loss.tex', standAlone = standAlone)
plot <- ggplot(dt)
print(plot)
dev.off()
tinytex::pdflatex("~/Documents/masters-thesis/no-hinge-loss.tex")
# Error in plot.xy(xy.coords(x, y), type = type, ...) : 
# plot.new has not been called yet

