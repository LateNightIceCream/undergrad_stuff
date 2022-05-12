library(ggplot2)

outputName = "2_5.pdf"
outputWidth = 10
outputHeight = outputWidth * 0.618

diodeDataFB <- read.csv("2_5.csv")

xlabel <- bquote("I"[L]~"/mA")
ylabel <- bquote("U"[a]~"/V")
                                        #
hsBlue <- "#00b1db"

plot <- ggplot( data= diodeDataFB, aes(x = IL * 1000, y = Ua)) +
    theme_minimal() +
    xlab(xlabel) +
    ylab(ylabel) +
    geom_point(color=hsBlue)

pdf(outputName, width = outputWidth, height = outputHeight)
plot
