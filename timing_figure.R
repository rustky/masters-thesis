library(data.table)
library(ggplot2)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
timing.dt <- fread("timing_data.csv")

# subset.dt <- timing.dt[timing.dt[,.I[which.max(time_limit)],by=.(loss_name,
#                                                                 data_size)]$V1]

ggplot(timing.dt)+
  geom_line(aes(data_size, median_time,color=loss_name))+
  geom_ribbon(aes(x=data_size, y=median_time, ymin=lower_quantile, ymax=upper_quantile,
                  fill=loss_name), alpha = 0.5)+
  scale_x_log10()+
  scale_y_log10()+
  ylab('Time to compute the loss (s)')+
  xlab('Number of Observations to Compute')+
  ggtitle("Time To Compute The Loss With Enforced Time Limit")
