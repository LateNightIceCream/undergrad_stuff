library(ggplot2)
library(mosaic)
library(scales)

outputName   <- "2_1_704kbit_Übertragungsfunktion.pdf"
outputWidth  <- 10
outputHeight <- 0.618 * outputWidth

data <- read.csv("data.csv")


xValues  <- data$f
yValues1 <- data$Eingang
yValues2 <- data$Ausgang

hsBlue <- "#99ffb5"
theoreticalColor <- "#fbde96"

dataSchnib <- data.frame(x = xValues, y1=yValues1, y2=yValues2, dif = yValues2-yValues1)


xlab <- "f / MHz"
#ylab <- "dBm"
ylab <- "u2/u1  / dB"

ylimits <- c(-70, 10)
ybreaks <- c(0, -20, -40, -60)

xlimits <- c(0.3, 10)
xbreaks <- 10^(0:1)
minor_breaks <- rep(1:9, 21)*(10^rep(-1:10, each=9))


a <- -20
b <- -45
d <- 0.08625

hypFunDB    <- dif ~ A + B/( sqrt(1 + 1/(D*x)^2) )
hypDB.model <- fitModel(hypFunDB, data=dataSchnib, start=c(A=a, B=b, D=d))

snackyDB <- function(f) {

    A <- a
    B <- b
    D <- d

    A+B/( sqrt(1 + 1/(D*f)^2 ) )

}

regColor   <- "grey85"
pointColor <- "#00b1db"

plot <- ggplot(data = dataSchnib, aes(x = x, y=y2) ) +
    theme_minimal() +
    xlab(xlab) +
    ylab(ylab) +
    scale_y_continuous(limits = ylimits, breaks = ybreaks) +
    scale_x_continuous( limits=xlimits, trans="log10",breaks = xbreaks, minor_breaks=minor_breaks, labels = trans_format("log10", math_format(10^.x))) +
#    stat_function(fun=snackyDB, n=4000)+
#    stat_function(fun=hypDB.model, n=4000, color=regColor) +
#    geom_smooth(method="lm",aes(x=x, y=dif), color = regColor, se=FALSE) +
    geom_point(aes(x=x, y=dif), color=pointColor)

################################

linewidth <- (1-0.6180339887498948)*10

## for( i in 1:nrow(data)) {

##    if(yValues2[i] < yValues1[i] ) {

##        # plot measurement first, then plot theoreticals on top

##    plot <- plot + geom_segment(
##             x = xValues[i],
##             y = 0,
##             xend = xValues[i],
##             yend = yValues2[i],
##             color=hsBlue,
##             linetype="solid", size = linewidth
##         )

##    plot <- plot + geom_segment(
##             x = xValues[i],
##             y = 0,
##             xend = xValues[i],
##             yend = yValues1[i],
##             color=theoreticalColor,
##             linetype="solid", size = linewidth
##         )
##    } else {

##        # plot theoretical first, then plot measurement

##    plot <- plot + geom_segment(
##             x = xValues[i],
##             y = 0,
##             xend = xValues[i],
##             yend = yValues1[i],
##             color=theoreticalColor,
##             linetype="solid", size = linewidth
##         )

##    plot <- plot + geom_segment(
##             x = xValues[i],
##             y = 0,
##             xend = xValues[i],
##             yend = yValues2[i],
##             color=hsBlue,
##             linetype="solid", size = linewidth
##         )

##    }


## }


pdf(outputName, width = outputWidth, height = outputHeight)
plot

