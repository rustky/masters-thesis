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
  xlab("$z$")+
  ylab("$\\ell(z)$")+
  xlim(0,5)+
  theme(text = element_text(size = 12))
print(plot)
dev.off()
tinytex::pdflatex("~/Documents/masters-thesis/grad-descent.tex")
