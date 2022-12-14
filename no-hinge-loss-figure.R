library(data.table)
library(tikzDevice)
library(ggplot2)
library(directlabels)

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

label.lookup <- list("2"= "$a_1,b_1,c_1$",
                     "4"=  "$a_2,b_2,c_2$", "8"=  "$a_3,b_3,c_3$")

x.list <- list()
for(b in b_vals){
  x.list[[paste("y",abs(b),sep = "-")]] <- parabola(x, b)
  x.list[[paste("y-color",abs(b),sep = "-")]] <- paste("y",abs(b),sep = "-s")
  x.list[[paste("y-set",abs(b),sep = "-")]] = "$\\mathcal{I^+}$"
  x.list[[paste("y-label",abs(b),sep = "-")]] <- label.lookup[[paste(abs(b))]]
}

dt <- data.table(data.frame(x.list))
dt$y.total <- dt$y.2 + dt$y.4
dt$y.color.total <- rep("y-total", nrow(dt))
dt$predicted.value <- x
dt$y.set.total <- '$\\mathcal{I^-}$'
dt$y.label.total <- "$a^+,b^+,c^+$"

dt.tall <- melt(dt, id.vars = c("predicted.value"), 
                measure.vars = c("y.2", "y.4", "y.8", "y.total"),
                variable.name = "color", value.name = c("y"))
set.dt <- melt(dt, measure.vars = c("y.set.2", "y.set.4", "y.set.8", "y.set.total"), variable.name = "name", value.name = "set")
label.dt <- melt(dt, measure.vars = c("y.label.2", "y.label.4", "y.label.8", "y.label.total"), variable.name = "name", value.name = "label")
plot.dt <- data.table(dt.tall, set= set.dt$set, label=label.dt$label)
plot.dt$set <- factor(plot.dt$set, levels = c('$\\mathcal{I^+}$', '$\\mathcal{I^-}$'))

# ggplot(plot.dt)+
#   geom_line(aes(x, y, color= color ))+
#   geom_segment(data = plot.dt[(x == 4)&(V2 == "$\\mathcal{I^-}$")],
#                aes(x = x, xend = x, y = 0, yend = y),
#                    arrow=arrow(length = unit(0.1, "cm")))+
#   geom_segment(data = plot.dt[(x == 3)&(V2 == "$\\mathcal{I^-}$")],
#                aes(x = x, xend = x, y = 0, yend = y),
#                arrow=arrow(length = unit(0.1, "cm")))+
#   geom_segment(data = plot.dt[(x == -1)&(V2 == "$\\mathcal{I^-}$")],
#                aes(x = x, xend = x, y = 0, yend = y),
#                arrow=arrow(length = unit(0.1, "cm")))+
#   facet_grid(. ~ V2)

standAlone <- TRUE
suffix <- if(standAlone)"-standAlone" else ""
tikz(file = '~/Documents/masters-thesis/no-hinge-loss.tex', standAlone = standAlone,
     width = 6, height = 4)

plot <- ggplot(plot.dt)+
  geom_line(aes(predicted.value, y, color= color))+
  geom_segment(data = plot.dt[(predicted.value == 4)&(set == "$\\mathcal{I^-}$")],
               aes(x = predicted.value, xend = predicted.value, y = 0, yend = y),
               arrow=arrow(length = unit(0.1, "cm")))+
  geom_segment(data = plot.dt[(x == 3)&(set == "$\\mathcal{I^-}$")],
               aes(x = predicted.value, xend = predicted.value, y = 0, yend = y),
               arrow=arrow(length = unit(0.1, "cm")))+
  geom_segment(data = plot.dt[(x == -1)&(set == "$\\mathcal{I^-}$")],
               aes(x = predicted.value, xend = predicted.value, y = 0, yend = y),
               arrow=arrow(length = unit(0.1, "cm")))+
  geom_dl(aes(predicted.value,y,label=label,color = color),
          method = list("first.qp", cex = 1))+
  xlab("Predicted Value")+
  ggtitle("Square Loss Accrues Loss")+
  ylim(0,75)+
  xlim(-5,5)+
  facet_grid(. ~ set)+
  theme(legend.position="none",
        text = element_text(size = 16))

print(plot)
dev.off()
tinytex::pdflatex("~/Documents/masters-thesis/no-hinge-loss.tex")




