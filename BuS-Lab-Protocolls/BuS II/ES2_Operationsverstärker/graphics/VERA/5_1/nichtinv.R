library(ggplot2)

width <- 10
height <- 0.618 * width

pdfName <- "nichtinv.pdf"


dat <- read.csv("nichtinv.csv")

df <- data.frame(ue = dat$ue, ua = dat$ua)

linRegionPointsX <- df$ue[6:17]
linRegionPointsY <- df$ua[6:17]

linData <- data.frame(x = linRegionPointsX, y = linRegionPointsY)

linModel <- lm( y ~ x, linData )

linearRegion <- function(ue) {

    slope     <- 10.995827
    intercept <- -0.007484

    slope * ue + intercept

}

xlabel <- bquote("U"["e"] ~ " / V")
ylabel <- bquote("U"["a"] ~ " / V")

pointColor <- "#495057"
regColor <- "#ced4da7f"

xlims <- c(-1.5, 1.5)
ylims <- c(-15, 15)

p <- ggplot(data = df, aes(x=ue, y=ua)) +
    theme_minimal() +
    xlab(xlabel) +
    theme(text = element_text(size=16))+

    scale_x_continuous(limits=xlims) +
    scale_y_continuous(limits=ylims) +

    stat_function(fun = linearRegion, n=4000, color=regColor) +

    ylab(ylabel) +
    geom_point(color=pointColor)


pdf(pdfName, width, height)
p
