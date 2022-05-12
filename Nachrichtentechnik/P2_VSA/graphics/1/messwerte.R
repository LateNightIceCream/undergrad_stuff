library(ggplot2)

width  <- 10
height <- 0.618 * width
pdfName <- "1_plot.pdf"

symbolRates <- c( 1, 4, 8)
bandwidths  <- c( 1.298, 5.086, 10.028)

data <- data.frame( x = symbolRates, y = bandwidths )


linearMod <- lm(y ~ x, data=data)
print(linearMod)

modelfun <- function(x) {

    1.24651*x + 0.06911

}

hsBlue <- "#00b1db"
pointColor <- "#ff6b6b"

p <- ggplot(data = data, aes(x=x, y=y)) +
    theme_minimal() +
    xlab(bquote("f"[T]~" /MSps"))+
    ylab(bquote("B /MHz"))+
#    geom_smooth(method="lm") +
    stat_function(fun = modelfun, color=hsBlue)+
    geom_point(color=pointColor)




pdf(pdfName, width, height)
p
