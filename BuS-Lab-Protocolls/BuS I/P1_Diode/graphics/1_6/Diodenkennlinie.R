# square wave plot

library(ggplot2)

options(scipen=10000)

outputName   <- "diodenkennline.pdf"
outputWidth  <- 10
outputHeight <- 0.618 * outputWidth

UT <- 2.2 * 26 * 10^(-3)
n  <- 1
Is <- 0.15 * 10^(-6)
IsArtificial <- -0.02

ZenerVoltage <- -1

power_hyperbola <- function (U) {

    1.5/U

}

schockley <- function(U) {

    Is*(exp(U/(n*UT))-1)

}

forwardBias <- function(U) {

    #ifelse(U<ZenerVoltage, -schockley(-(U+0.9))+IsArtificial, ifelse(U >= 0, schockley(U), IsArtificial))
    schockley(U)
}

xlabel <- "U / V"
ylabel <- "I / A"

xlim <- c(0,0.9)
ylim <- c(0,schockley(0.9))

xbreaks <- seq(0,0.9, by=0.1)

function_color <- "#00b1db"
power_color <- "#00b1db0F"

####################################################################

p <- ggplot(data.frame(x=c(-2,2), y=c(-2,2)), aes(x=x)) +

        theme_minimal() + # maybe theme_bw()
        theme(legend.position="none", plot.title = element_text(color = "gray21", size=1.6180339887498948^5), plot.subtitle = element_text(color = "grey80", size=1.6180339887498948^5)) +
        #ggtitle("x(t)") +

    stat_function( fun = forwardBias,n=2000, color = function_color, size = 1) +
    stat_function( fun = power_hyperbola,n=2000, color = power_color, size = 1) +

        theme(text = element_text(size=16.180339887498948), axis.title.y = element_text(angle = 0, vjust = .5), panel.grid.minor.x = element_blank()) + # rotate axis title

        xlab(xlabel) +
        ylab(ylabel)  +

        scale_y_continuous(limits=ylim) +
        scale_x_continuous(limits=xlim, breaks=xbreaks)


pdf(outputName, width = outputWidth, height = outputHeight)
p
