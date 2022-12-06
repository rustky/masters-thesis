library(data.table)
library(tikzDevice)
library(ggplot2)

logistic.loss <- function(label, predictions){
  output <- log(1 + exp(-label*predictions))
}

dt <- data.table(
  label = c(rep(1, 50), rep(-1, 50)),
  predicted.value = c(seq(-5, 5, length.out = 50), seq(-5, 5, length.out = 50))
)
dt$output <- logistic.loss(dt$label, dt$predicted.value)

tikz(file = '~/Documents/masters-thesis/logistic-loss.tex', standAlone = TRUE,
     width = 6, height = 3)
plot <- ggplot(dt)+
  geom_line(aes(predicted.value, output))+
  facet_grid(.~label,
             labeller = label_both)+
  ggtitle("Logistic Loss $\\ell(y_i, \\hat{y}_i) = \\log(1 + e^{-y_i \\hat{y}_i})$")+
  xlab("Predicted Value: $\\hat{y}_i$")+
  ylab("Loss Output: $\\ell(y_i, \\hat{y}_i)$")+
  theme(text = element_text(size = 14))

print(plot)
dev.off()
tinytex::pdflatex("~/Documents/masters-thesis/logistic-loss.tex")
