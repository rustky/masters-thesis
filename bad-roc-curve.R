library(data.table)
library(ggplot2)

dt <- data.table(
  FPR = c(0, 0.5, 1),
  TPR = c(0, 0.5, 1),
  q = 1:3
)

dt <- data.table(
  FPR = c(0, 0.3, 1),
  TPR = c(0, 0.9, 1),
  q = 1:3
)

ggplot(dt)+
  geom_point(aes(FPR, TPR))+
  geom_text(aes(FPR, TPR, label = paste("q=", q, sep = ' ')),nudge_y =  -0.01, nudge_x = 0.05)+
  geom_text(aes(0.5 , 0.75, label = 'AUC = 0.5'), size = 6)+
  geom_line(aes(FPR, TPR))+
  geom_area(aes(FPR, TPR), alpha = 0.2)+
  xlab("False Positive Rate")+
  ylab("True Positive Rate")+
  scale_x_continuous(breaks=c(0,0.5,1))+
  scale_y_continuous(breaks=c(0,0.5,1))+
  theme_bw()+
  theme(panel.border = element_blank(),
        panel.grid.major = element_blank(),
        axis.line = element_line(colour = "black"))
  
  
