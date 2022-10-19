library(data.table)
library(ggplot2)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
timing.dt <- fread("timing_data.csv")

subset.dt <- timing.dt[timing.dt[,.I[which.max(time_limit)],by=.(loss_name,
                                                                data_size)]$V1]

ggplot(subset.dt)+
  geom_line(aes(data_size, median_time,color=loss_name))+
  geom_ribbon(aes(x=data_size, y=median_time, ymin=min_time, ymax=max_time,
                  fill=loss_name), alpha = 0.5)+
  scale_x_log10()+
  scale_y_log10()