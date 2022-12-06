library(data.table)
library(tikzDevice)
library(ggplot2)

random.function <- function(x){
  y <- sin(3*x) + cos(x/2) + sin(x^2)
}

dt <- data.table(
  x = seq(-5, 5, length.out = 400)
)
dt$y <- random.function(dt$x)

tikz(file = '~/Documents/masters-thesis/grad-descent.tex', standAlone = TRUE,
     width = 6, height = 3)
plot <- ggplot(dt)+
  geom_line(aes(x,y), size = 1.5)+
  geom_text(aes(2.5, -2.5, label = "Try to get here"))+
  geom_segment(aes(x = 2.25, xend = 2.1, y = -2.25, yend = -0.75),
               arrow=arrow(length = unit(0.1, "cm")))+
  geom_segment(aes(x = 2.75, xend = 3.3, y = -2.25, yend = -1.8),
               arrow=arrow(length = unit(0.1, "cm")))+
  geom_segment(aes(x = 3.1, xend = 4, y = -2.5, yend = -1.75),
               arrow=arrow(length = unit(0.1, "cm")))+
  xlab("$z$")+
  ylab("$\\ell(z)$")+
  xlim(0,4.5)+
  theme(text = element_text(size = 12))
print(plot)
dev.off()
tinytex::pdflatex("~/Documents/masters-thesis/grad-descent.tex")
