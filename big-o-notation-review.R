library(ggplot2)
library(data.table)
library(ggrepel)
library(tikzDevice)

x <- 1:10

linear <- function(x){
  x
}

log.linear <- function(x){
  x * log(x)
}

quadratic <- function(x){
  x^2
}
functions <- c("linear"=linear, "logarithmic"=log, "log-linear"=log.linear, "quadratic"=quadratic)
big.O <- c("linear"="O($n$)", "logarithmic"="$O(\\log n$)", "log-linear"="$O(n\\log n)$", "quadratic"="$O(n^2)$")
y.list <- list()
for(i in names(functions)){
  for(input in x){
    temp = data.table()
    print(functions[i])
    temp$output <- lapply(input,functions[[paste(i)]])
    temp$func <- i
    temp$algorithm <- big.O[i]
    y.list[[paste(i,input)]] <- temp
  }
}

y <- do.call("rbind", y.list)
y$input <- rep(1:10,4)
y.label <- y[y[, .I[output == max(output)], by=func]$V1]
y$func <- factor(y$func, levels = c("quadratic", "log-linear", "linear",
                                              "logarithmic"))
tikz(file = '~/Documents/masters-thesis/big-o-review.tex', standAlone = TRUE,
     width = 6, height = 4)
plot <- ggplot(y)+
  geom_line(aes(input, output, color=func), size = 1.5)+
  scale_x_continuous(breaks=c(1:10))+
  geom_label(data = y.label, aes(x=input, y=output, label=algorithm),
             nudge_x = -0.45,
             nudge_y = 3)+
  ggtitle("Big-O Notation Review")+
  ylab("Output of $foo(n)$")+
  xlab("Input size $n$")+
  theme(text = element_text(size = 11.5))
print(plot)
dev.off()
tinytex::pdflatex('~/Documents/masters-thesis/big-o-review.tex')
  
