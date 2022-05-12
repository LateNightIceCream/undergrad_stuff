library(ggplot2)

outputName   <- "2_3_Amplivergleich.pdf"
outputWidth  <- 10
outputHeight <- 0.618 * outputWidth

data <- read.csv("mess.csv")

# function parametersa
A   <- 2
m   <- 7 # number of amplitude values

ylabel <- bquote( "|"~ Delta ~ "a"[n]~"| / dB" )
xlabel <- bquote( "n"[1]~"-n"[2])


amplifun <- function (n) {

    abs( 4 * 2 / (n * pi) * sin(n * pi/2) )

}

deltaX <- 1
deltaCounter <- 0

lineCoordinatesX <- c()
lineCoordinatesY <- c()

lineCoordinatesY_Measurement <- c()

print(amplifun(1))

for (i in c(1,2,3,4,5,6,7)) {

    deltaCounter <- deltaCounter + deltaX

    lineCoordinatesX <- c( lineCoordinatesX, deltaCounter)
#    lineCoordinatesY <- c( lineCoordinatesY, abs(data$ant) )

#    lineCoordinatesY_Measurement <- c( lineCoordinatesY_Measurement, abs(data$anm))

}

ylim   <- c(0, 7*1.0381)
xlim   <- c(0, 8)

xlabels <- c("", "1-2", "2-3", "3-5","", "5-6", "6-7", "7-9")

ybreaks <- seq(0, 10, 1)
xbreaks <- seq(0, 7, 1)


hsBlue <- "#00b1db"
theoreticalColor <- "#afafafFF"


plot <- ggplot(data.frame(x=c(0,2), y=c(0,2)), aes(x=x)) +
    theme_minimal() +
    theme(legend.position="none", plot.title = element_text(color = "gray21", size=1.618^5), plot.subtitle = element_text(color = "grey80", size=1.618^5)) +

    #ggtitle(bquote("Amplitudenspektrum von x(t), Rot: theoretische Werte")) +
    #labs(subtitle="D=0.25, T=1us")

    xlab(xlabel) +
    ylab(ylabel) +

    scale_y_continuous(limits= ylim, breaks=ybreaks) +
    scale_x_continuous(limits= xlim, breaks=xbreaks, labels=xlabels)


linewidth <- (1-0.6180339887498948)*10

theodat <- abs(data$ant)
measdat <- abs(data$anm)

for (i in 1:m) {

   if(theodat[i] < measdat[i] ) {

       # plot measurement first, then plot theoreticals on top

   plot <- plot + geom_segment(
            x = lineCoordinatesX[i],
            y = 0,
            xend = lineCoordinatesX[i],
            yend = measdat[i],
            color=hsBlue,
            linetype="solid", size = linewidth
        )

   plot <- plot + geom_segment(
            x = lineCoordinatesX[i],
            y = 0,
            xend = lineCoordinatesX[i],
            yend = theodat[i],
            color=theoreticalColor,
            linetype="solid", size = linewidth
        )
   } else {

       # plot theoretical first, then plot measurement

   plot <- plot + geom_segment(
            x = lineCoordinatesX[i],
            y = 0,
            xend = lineCoordinatesX[i],
            yend = theodat[i],
            color=theoreticalColor,
            linetype="solid", size = linewidth
        )

   plot <- plot + geom_segment(
            x = lineCoordinatesX[i],
            y = 0,
            xend = lineCoordinatesX[i],
            yend = measdat[i],
            color=hsBlue,
            linetype="solid", size = linewidth
        )


   }

}



pdf(outputName, width = outputWidth, height = outputHeight)
plot
