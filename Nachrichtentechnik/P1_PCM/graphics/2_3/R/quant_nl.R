library(ggplot2)

outputName <- "linquant_c.pdf"

width  <- 10
height <- 0.618 * width

linq <- read.csv("lin_quant.csv")

linq <- data.frame( x=linq$U1, y=linq$U2 )


# quantization step size
s = 5/32

print(s)

quant_levels <- c(0)

for(i in 1:32) {

    quant_levels <- c(quant_levels, i * s)

}

theoretical_value <- function(u) {

    # 2*s/s = 2 --> floor --> 2*s, 3*s/s=3 --> floor --> 3*s, etc
    y <- floor(u/s)*s # i just typed this and it works :D

    return(y)

}

#print(quant_levels)

borders <- data.frame(x=quant_levels, y=quant_levels)

xlim <- c(-5,5)
xlab <- "U1 / V"
ylab <- "U2 / V"

curve_color <- "#00b1db4F"
point_color <- "#FF807A"


p <- ggplot(data = linq, aes(x=x, y=y)) +
    theme_minimal() +
    scale_x_continuous(limits=xlim) +
    xlab(xlab) +
    ylab(ylab) +
    stat_function(fun=theoretical_value, n=4000, color=curve_color) +
    geom_point(color=point_color, size=1.618, shape=3) +
#geom_point(data=borders, color="pink", size=1.618, shape=5) +
    geom_segment(x=s, y=0, xend=s, yend=-3, color=curve_color, alpha=0.5, size=0.3, linetype=8) +
    annotate("text", x=s, y=-3.2, label=s, size=3, color="#00b1db")


pdf(outputName, width, height)
p
