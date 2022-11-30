library(data.table)
library(ggplot2)
library(tikzDevice)

dt <- data.table(
  x = seq(-5, 5, by = 0.01)
)

dt$y <- ifelse(dt$x<=0, 1 , 0)
tikz(file = '~/Documents/masters-thesis/zero-one-loss.tex',height =2,standAlone = TRUE)
gg <- ggplot(dt)+
  geom_line(aes(x,y))+
  ggtitle('Zero-One Loss $\\ell(z)=I[z < 0]$')
plot(gg)
dev.off()

tinytex::pdflatex('~/Documents/masters-thesis/zero-one-loss.tex')
