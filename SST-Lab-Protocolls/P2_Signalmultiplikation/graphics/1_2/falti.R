library(ggplot2)

outputName <- "Falti_ohne_GA_träger_richtig.pdf"
pdfWidth <- 10
pdfHeight <- pdfWidth * 0.618


T   <- 250 * 10^-6
tau <- 100 * 10^-6

U2 <- 1

m <- 7

amplitudes <- function(n) {

if(n == 0) { return( U2 * tau/T ) }

U2 * tau/T * abs(sin(pi * n * tau/T) / (n * pi * tau/T))

}

line_xcoordinates <- c()
theoretical_ys <- c()
deltacounter <- 0

deltax  <- 1

for(i in 1:m) {

  deltacounter<-deltacounter+deltax
  line_xcoordinates <- c(line_xcoordinates, deltacounter)

  theoretical_ys <- c(theoretical_ys, amplitudes(i))

}

xlimits <- c(-5, 5)
xbreaks <- seq(-5, 5, 1)
xlabels <- xbreaks * 1/T / 1000
ylimits <- c(-0.1, U2/2)

xlabel <- "f / kHz"
ylabel <- bquote("U"[3]~"(f)")


hsBlue  <- "#00b1db5F"
hsBlue2 <- "#00b1db"

p <- ggplot(data.frame(x=c(0,2)), aes(x=x)) +
    theme_minimal() +
    scale_x_continuous(limits = xlimits, breaks = xbreaks, labels=xlabels) +
    scale_y_continuous(limits = ylimits) +
    stat_function( fun = amplitudes, n = 4000, linetype=2, color = hsBlue) +
    xlab(xlabel) +
    ylab(ylabel)


linewidth <- 1
cosFreq <- 500/(1/T)

for( i in 1:m ) {

    cosAmp1 <- amplitudes(i)
    cosAmp2 <- amplitudes(i)

#    p <- p + geom_segment( x = line_xcoordinates[i], y = 0, xend = line_xcoordinates[i], yend = theoretical_ys[i] , color=hsBlue,   linetype="solid", size = linewidth)
#    p <- p + geom_segment( x = -line_xcoordinates[i], y = 0, xend = -line_xcoordinates[i], yend = theoretical_ys[i] , color=hsBlue,   linetype="solid", size = linewidth)


  # cos
    p <- p + geom_segment(
                 x = line_xcoordinates[i]+cosFreq,
                 y = 0,
                 xend = line_xcoordinates[i]+cosFreq,
                 yend = cosAmp1,
                 color = hsBlue2,
                 size = linewidth
             )

    p <- p + geom_segment(
                 x = line_xcoordinates[i]-cosFreq,
                 y = 0,
                 xend = line_xcoordinates[i]-cosFreq,
                 yend = cosAmp2,
                 color = hsBlue2,
                 size = linewidth
             )

    p <- p + geom_segment(
                 x = -line_xcoordinates[i]-cosFreq,
                 y = 0,
                 xend = -line_xcoordinates[i]-cosFreq,
                 yend = cosAmp1,
                 color = hsBlue2,
                 size = linewidth
             )

    p <- p + geom_segment(
                 x = -line_xcoordinates[i]+cosFreq,
                 y = 0,
                 xend = -line_xcoordinates[i]+cosFreq,
                 yend = cosAmp2,
                 color = hsBlue2,
                 size = linewidth
             )
}

#p <- p + geom_segment( x = 0, y = 0, xend = 0, yend = amplitudes(0), color=hsBlue,   linetype="solid", size = linewidth)
##  p <- p + geom_segment(
##                  x = cosFreq,
##                  y = 0,
##                  xend = cosFreq,
##                  yend = amplitudes(cosFreq),
##                  color = hsBlue2,
##                  size = linewidth
##              )

## p <- p + geom_segment(
##              x = -cosFreq,
##              y = 0,
##              xend = -cosFreq,
##              yend = amplitudes(-cosFreq),
##              color = hsBlue2,
##              size = linewidth
## )

pdf(outputName, pdfWidth, pdfHeight)
p
