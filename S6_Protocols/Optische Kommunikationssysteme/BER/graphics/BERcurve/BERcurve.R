library("ggplot2")

width   <- 10
height  <- 0.618 * width
outName <- "BERcurve.pdf"

data <- read.csv("ber.csv")
startAttenuation <- 22.35
endAttenuation   <- 26.65
data$attenuation = seq(startAttenuation, endAttenuation, by = 0.1)
data

p <- ggplot(data, aes(x = Empfleistung, y = log(abs(BER)))) +
  theme_minimal() +
  geom_point()


pdf(outName, width, height)
p
