library(ggplot2)

width   <- 10;
height  <- 0.618 * width;
pdfName <- "opv_feed.pdf"

Us <- 5;

slope <- 6.18;

xstop <- Us/slope;

linear_region <- function(x) {
    ifelse(x>=(-xstop), ifelse(x<=xstop, slope*x, Us), -Us)
}

xlim <- c(-2,2)
ylim <- c(-Us*1.382, Us*1.382)

xbreaks <- seq(-2, 2, 1)
ybreaks <- seq(-Us, Us, 2)

xlabels <- c("", "", 0, "", "")
ylabels <- c("-Us", "" , "" , "" , "" , "+Us")

xlab <- bquote("U"[e])
ylab <- bquote("U"[a])

blue5 <- "#339af0"

p <- ggplot(data.frame(x=c(-2, 2)), aes(x)) +
    theme_minimal() +
    xlab(xlab) +
    ylab(ylab) +
    scale_x_continuous(limits=xlim, breaks=xbreaks, labels=xlabels) +
    scale_y_continuous(limits=ylim, breaks=ybreaks, labels=ylabels) +
    stat_function(fun = linear_region, n=4000, color=blue5)

pdf(pdfName, width, height)
p
