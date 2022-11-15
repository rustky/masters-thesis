library(data.table)
library(ggplot2)

parabola <- function(h){
  input <- seq(-5,5, by= 0.5)
  y <- input^2
  x <- numeric(21)
  x[0:10] <- -sqrt(y[0:10])+h
  x[11:21] <- sqrt(y[11:21])+h
  return(x)
}

h_vals <- c(-3,1,3)

x.list <- list()
for(hs in h_vals){
  x.list[[paste(hs)]] <- parabola(hs)  
}
  
dt <- data.table(do.call(cbind, x.list))
dt$y <- seq(-5,5, by= 0.5)^2

colnames(dt) <- c('H1', 'H2', 'H3', 'y')
gg <- ggplot(dt)+
  geom_line(aes(x = H1, y))+
  geom_line(aes(H2,y))+
  geom_line(aes(H3, y))+
  xlab("Augmented Predictions")+
  ylab("Loss")
