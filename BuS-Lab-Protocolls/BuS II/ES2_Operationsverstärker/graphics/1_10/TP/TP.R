# this is some messy code :D
library(ggplot2)
library(scales)


width <- 10
height <- width * 0.618

outputName <- "TP.pdf"


uebertragungsfunktion <- function(f) {
    20*log10(1/sqrt(1+0.000001^2*f^2))
}

xbreaks <- 10^(0:10)
minor_breaks <- rep(1:9, 21)*(10^rep(0:10, each=9))

fg <- 1700
hsBlue <- "grey70"
pointColor <- "#00b1db"
cutoffColor <- "#db0058"
cutoffPoint <- data.frame(fg = fg, db=-3)

ylabel <- bquote("|V(f)| / V(0)"~" in dB")
xlabel <- "f in Hz"

p <- ggplot(data=data.frame(x=c(1,10^10)), aes(x=x)) +
    theme_minimal() +
    ylab(ylabel) +
    xlab(xlabel) +
    scale_x_continuous( trans="log10",breaks = xbreaks, minor_breaks=minor_breaks, labels = trans_format("log10", math_format(10^.x))) +
    stat_function(fun = uebertragungsfunktion, n = 4000, color="#339af0")

pdf(outputName, width, height)
p
