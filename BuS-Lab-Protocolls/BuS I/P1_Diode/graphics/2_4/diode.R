library(ggplot2)

outputName = "2_4_kennlinie.pdf"
outputWidth = 10
outputHeight = outputWidth * 0.618

diodeDataFB <- read.csv("2_4.csv")

xlabel <- bquote("U"[e]~"/V")
ylabel <- bquote("U"[a]~"/V")
                                        #
hsBlue <- "#00b1db"

plot <- ggplot( data= diodeDataFB, aes(x = Ue, y = Ua)) +
    theme_minimal() +
    xlab(xlabel) +
    ylab(ylabel) +
    geom_point(color=hsBlue)

pdf(outputName, width = outputWidth, height = outputHeight)
plot
