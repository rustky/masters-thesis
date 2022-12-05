library(data.table)
library(tikzDevice)
library(ggplot2)

square.loss <- function(label, predictions){
  output <- (predictions - label)^2
}

squared.hinge.loss <- function(label, predictions){
  output <- (predictions - label)^2
  
}

dt <- data.table(
  label = c(rep(1, 50), rep(-1, 50)),
  predicted.value = c(seq(-5, 5, length.out = 50), seq(-5, 5, length.out = 50))
)
dt$output <- square.loss(dt$label, dt$predicted.value)

tikz(file = '~/Documents/masters-thesis/naive-methods.tex', standAlone = TRUE,
     width = 6, height = 4)
plot <- ggplot(dt)+
  geom_line(aes(predicted.value, output))+
  facet_grid(.~label,
             labeller = label_both)+
  ggtitle("Square Loss $\\ell(y_i, \\hat{y_i}) = (\\hat{y_i} - y_i)^2$")+
  xlab("Predicted Value: $\\hat{y_i}$")+
  ylab("Loss Output: $\\ell(y_i, \\hat{y_i})$")

print(plot)
dev.off()
tinytex::pdflatex("~/Documents/masters-thesis/naive-methods.tex")
