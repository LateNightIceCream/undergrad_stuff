# this is some messy code :D
library(ggplot2)
library(scales)


width <- 10
height <- width * 0.618

outputName <- "BP.pdf"

R1 <- 10000
R3 <- 200
R2 <- 20000
C2 <- 7.9*10^-9
C1 <- 7.9 * 10^-9

uebertragungsfunktion <- function(f) {
#    20*log10(1/(1+1/(0.00001^2*f^2)))
     #20*log10( 1/( sqrt(  (1+R1/R3+R1*C2/(R2*C1))^2 + (2*pi*f*R1*C2 - 1/(2*pi*f*R2*C1) - R1/(2*pi*f*R3*R2*C1) )^2  ) )  )
    20*log10( R2*C2 / sqrt( (-R1 * (C1+C2))^2 + (1/(2*pi*f) + R1/(R3*2*pi*f)-2*pi*f*C1*C2*R1*R2)^2 ) )
}

uebertragungsfunktion(2*10^7)

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
