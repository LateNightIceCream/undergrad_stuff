library(ggplot2)

outputName = "2_1_kennlinie_sperr.pdf"
outputWidth = 10
outputHeight = outputWidth * 0.618

diodeDataRB <- read.csv("sperrrichtung.csv")

diodeDataRB$I <- -diodeDataRB$I
diodeDataRB$U <- -diodeDataRB$U

xlabel <- "U / V"
ylabel <- "I / µA"

                                        #
hsBlue <- "#00b1db"
hsInvert <- "#ff5d02"

plot <- ggplot( data= diodeDataRB, aes(x = U, y = I)) +
    theme_minimal() +
    xlab(xlabel) +
    ylab(ylabel) +
    geom_point(color=hsInvert) +

pdf(outputName, width = outputWidth, height = outputHeight)
plot

