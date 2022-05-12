library(ggplot2)

outputName = "2_1_kennlinie.pdf"
outputWidth = 10
outputHeight = outputWidth * 0.618

diodeDataFB <- read.csv("durchlassrichtung.csv")
diodeDataRB <- read.csv("sperrrichtung.csv")

xlabel <- "U / V"
ylabel <- "I / mA"

                                        #
hsBlue <- "#00b1db"
hsInvert <- "#ff5d02"

plot <- ggplot( data= diodeDataFB, aes(x = diodeDataFB$U, y = diodeDataFB$I)) +
    theme_minimal() +
    xlab(xlabel) + 
    ylab(ylabel) + 
    geom_point(color=hsBlue) +
    #geom_point(color=hsInvert,data=diodeDataRB, aes(x = diodeDataRB$U, y = diodeDataRB$I))

pdf(outputName, width = outputWidth, height = outputHeight)
plot

