library(ggplot2)

outputName = "2_2_kennlinie.pdf"
outputWidth = 10
outputHeight = outputWidth * 0.618

diodeDataFB <- read.csv("durchlassrichtung.csv")
diodeDataRB <- read.csv("sperrrichtung.csv")

xlabel <- "U / V"
ylabel <- "I / mA"

powerloss <- function(U) {

    1.5/U * 1000

}
                                        #
hsBlue <- "#00b1db"
hsInvert <- "#ff5d02"
hsGreen <- "#59B574"
hsGreenfade <- "#59B5745E"

ylimits <- c(min(diodeDataRB), max(diodeDataFB))

plot <- ggplot( data= diodeDataFB, aes(x = diodeDataFB$U, y = diodeDataFB$I)) +
    theme_minimal() +
    xlab(xlabel) +
    ylab(ylabel) +
    geom_point(color=hsBlue) +
    geom_point(color=hsInvert,data=diodeDataRB, aes(x = diodeDataRB$U, y = diodeDataRB$I))+
    scale_y_continuous(limits=ylimits) +
    stat_function(fun = powerloss, color = hsGreen) +
    annotate("text", x=-4.6, y=-268, label="Verlustleistungshyperbel", size=04, color = hsGreenfade)

pdf(outputName, width = outputWidth, height = outputHeight)
plot

