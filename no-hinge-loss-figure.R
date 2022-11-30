library(data.table)
library(tikzDevice)
library(ggplot2)
library(data.table)
library(tikzDevice)
library(ggplot2)

parabola <- function(x, b){
  if(b == 2){
    c <- 0.5
  }
  else if(b == -4){
    c <- 2
  }
  else{
    c <- 8
  }
  parabola <- 2*x^2 + b*x + c
}

b_vals <- c(2,-4, -8)
x <- seq(-3, 5, by = 0.25)

x.list <- list()
for(b in b_vals){
  x.list[[paste("y",abs(b),sep = "-")]] <- parabola(x, b)
  x.list[[paste("y-color",abs(b),sep = "-")]] <- paste("y",abs(b),sep = "-s")
  x.list[[paste("y-set",abs(b),sep = "-")]] = "$\\mathcal{I^+}$"
}

dt <- data.table(data.frame(x.list))
dt$y_total <- dt$y_2 + dt$y_4
dt$y_color_total <- rep("y-total", nrow(dt))
dt$x <- x
dt$y_set_total <- '$\\mathcal{I^-}$'

dt.tall <- melt(dt, id.vars = c("x"), measure.vars = c("y-2", "y-4", "y-8", "y-total"),
                variable.name = "color", value.name = c("y"))
set.dt <- melt(dt, measure.vars = c("y-set-2", "y-set-4", "y-set-8", "y-set-total"), variable.name = "name", value.name = "set")
plot.dt <- data.table(dt.tall, set.dt$set)

ggplot(plot.dt)+
  geom_line(aes(x, y, color= color ))+
  geom_segment(data = plot.dt[(x == 4)&(V2 == "$\\mathcal{I^-}$")],
               aes(x = x, xend = x, y = 0, yend = y),
                   arrow=arrow(length = unit(0.1, "cm")))+
  geom_segment(data = plot.dt[(x == 3)&(V2 == "$\\mathcal{I^-}$")],
               aes(x = x, xend = x, y = 0, yend = y),
               arrow=arrow(length = unit(0.1, "cm")))+
  geom_segment(data = plot.dt[(x == -1)&(V2 == "$\\mathcal{I^-}$")],
               aes(x = x, xend = x, y = 0, yend = y),
               arrow=arrow(length = unit(0.1, "cm")))+
  facet_grid(. ~ V2)

standAlone <- TRUE
suffix <- if(standAlone)"-standAlone" else ""
tikz(file = '~/Documents/masters-thesis/no-hinge-loss.tex', standAlone = standAlone)

plot <- ggplot(plot.dt)+
  geom_line(aes(x, y, color= color ))+
  geom_segment(data = plot.dt[(x == 4)&(V2 == "$\\mathcal{I^-}$")],
               aes(x = x, xend = x, y = 0, yend = y),
               arrow=arrow(length = unit(0.1, "cm")))+
  geom_segment(data = plot.dt[(x == 3)&(V2 == "$\\mathcal{I^-}$")],
               aes(x = x, xend = x, y = 0, yend = y),
               arrow=arrow(length = unit(0.1, "cm")))+
  geom_segment(data = plot.dt[(x == -1)&(V2 == "$\\mathcal{I^-}$")],
               aes(x = x, xend = x, y = 0, yend = y),
               arrow=arrow(length = unit(0.1, "cm")))+
  facet_grid(. ~ V2)

print(plot)
dev.off()
tinytex::pdflatex("~/Documents/masters-thesis/no-hinge-loss.tex")




