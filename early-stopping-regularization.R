library(data.table)
library(ggplot2)

x <- seq(0,5,0.25)

y.list <- list()

subtrain <- function(x){
  -x + 6
}

validation <- function(x){
  (x - 2)^2 + 2
}
function.list <- list("subtrain"=subtrain, "validation"=validation)

for(func.names in names(function.list)){
  for(input in x){
    y <- data.table()
    y$epoch <- input
    y$loss <- sapply(input, function.list[[func.names]])
    y$set <- func.names
    y.list[[paste(func.names, input)]] <- y
  }
}

output.dt <- do.call(rbind, y.list)

ggplot(output.dt)+
  geom_line(aes(epoch, loss, color=set))+
  geom_vline(xintercept=2, color='red', linetype='dashed')+
  ggtitle("Early Stopping Regularization")
