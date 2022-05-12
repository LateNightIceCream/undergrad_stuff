library(ggplot2)

width  <- 10
height <- 0.618 * width

outputName <- "SN7400_Eingangskennlinie.pdf"

data <- read.csv("daten.csv")


pointcolor <- "#495057"

xlabel <- bquote("U"["e"]~"/ V")
ylabel <- bquote("I"["e"]~"/ mA")

p <- ggplot(data = data, aes(x = ue, y=ie)) +
    theme_minimal() +
    ylab(ylabel) +
    xlab(xlabel) +
    geom_point(color=pointcolor)


pdf(outputName, width, height)
p
