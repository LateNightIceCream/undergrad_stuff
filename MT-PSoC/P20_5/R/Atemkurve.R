library(ggplot2)

csv <- read.csv( "C:/Users/Celery/Documents/Hochschule/Messtechnik/MT-PSoC/MT-PSoC/P20_5/R/output_test_2.csv" )

getActualFrequency <- function(T) {   # T in ms
  
  csv <- read.csv("C:/Users/Celery/Desktop/why.csv")
  
  newdata <- cbind(csv, 1/(0.001*csv$period))
  colnames(newdata) <- c("period", "percent", "frequency")
  
  snacks <- loess(data=newdata,formula=percent~log(period))
  
  prediction <- predict(snacks, data.frame(period=T))
  
  predictFrame <- data.frame(period=T, percent=prediction)
  
  predictFrame <- cbind(predictFrame, apparentPeriod=predictFrame$period*predictFrame$percent/100)
  
  return( 1/(0.001*predictFrame$apparentPeriod) )
  
}

samplingFrequency <- 10 #(Hz)

# ----------------------------------------------------


# add a name to the csv column
colnames(csv) <- c("T_values", "T_values_DS", "T_values_Interpol")

# vector holdig each element's row/entry number
rowNumbers <- c(0:(nrow(csv)-1))

# calculating each entry's time
times <- rowNumbers * 1/samplingFrequency

# adding a time column (t) to the csv
breatheData <- cbind(csv, t=times)

print(breatheData)

pointsize <- 1.618
print(nrow(csv))
print(nrow(breatheData))

# ----------------------------------------------------


plotty <- ggplot(data = breatheData, aes(x=t, y=T_values)) +
  theme_minimal() +

  xlab("t /s") +
  ylab(bquote("T /°C")) +

  scale_x_continuous(breaks = seq(0, ceiling(1/samplingFrequency * nrow(csv)), by=ceiling(1/samplingFrequency * length(rowNumbers)/20)) ) +

  geom_point(color="#fc7978", size=pointsize) +
  geom_point(aes(x = t, y = T_values_DS), color="grey70", size=pointsize) +
  geom_point(aes(x = t, y = T_values_Interpol), color="green1", size=pointsize)


plotty


print(paste0("Total sampling time: ", 1/samplingFrequency * nrow(csv), "s"))
