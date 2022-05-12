# this is some messy code :D
library(ggplot2)
library(scales)


width <- 10
height <- width * 0.618

outputName <- "PH.pdf"


phase <- function(f) {
    atan(1/(f*0.00001))*180/pi
}

xbreaks <- 10^(0:10)
minor_breaks <- rep(1:9, 21)*(10^rep(0:10, each=9))

fg <- 1700
hsBlue <- "grey70"
pointColor <- "#00b1db"
cutoffColor <- "#db0058"
cutoffPoint <- data.frame(fg = fg, db=-3)

ylabel <- bquote(phi~"("~omega~") in "~degree)
xlabel <- "f in Hz"

ybreaks <- c(90, 45, 0)

p <- ggplot(data=data.frame(x=c(1,10^10)), aes(x=x)) +
    theme_minimal() +
    ylab(ylabel) +
    xlab(xlabel) +
    scale_x_continuous( trans="log10",breaks = xbreaks, minor_breaks=minor_breaks, labels = trans_format("log10", math_format(10^.x))) +
    scale_y_continuous(breaks = ybreaks)+
    stat_function(fun = phase, n = 4000, color="#ff922b")

pdf(outputName, width, height)
p
