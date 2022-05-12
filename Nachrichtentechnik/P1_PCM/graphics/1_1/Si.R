library(ggplot2)

outputName <- "Si_10kHz.pdf"
pdfWidth <- 10
pdfHeight <- pdfWidth * 0.618


T   <- 1/10 * 10^-3
tau <- 15 * 10^-6

f0 <- 1/T

U2 <- 1

m <- 10

amplitudes <- function(n) {

if(n == 0) { return( 2*U2 * tau/T ) }

 p <- abs(    2*U2 * tau/T * sin(pi * n * tau/T) / (n * pi * tau/T))

 print(p)

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

xlimits <- c(-10, 10)
xbreaks <- seq(-10, 10, 2)
#xlabels <- c(-5,-4,-3,-2,-1,0,"1", "2 [..1/(T0/2)]", "3", "4", "5")
xlabels <- xbreaks
ylimits <- c(-0.01, 2*U2 * tau/T * 1.382)

xlabel <- "f / f0"
ylabel <- bquote("U"[2]~"(f)")


hsBlue <- "#00b1db"

p <- ggplot(data.frame(x=c(0,2)), aes(x=x)) +
    theme_minimal() +
    scale_x_continuous(limits = xlimits, breaks = xbreaks, labels=xlabels) +
    scale_y_continuous(limits = ylimits) +
    stat_function( fun = amplitudes, n = 4000, linetype=2, color = hsBlue) +
    xlab(xlabel) +
    ylab(ylabel) +

    annotate( "text", x=8, y=0.12, label=paste(c("f0=", f0/1000, " kHz"), collapse=""), color="gray80")



linewidth <- 1

for( i in 1:m ) {

    p <- p + geom_segment( x = line_xcoordinates[i], y = 0, xend = line_xcoordinates[i], yend = theoretical_ys[i] , color=hsBlue,   linetype="solid", size = linewidth)
    p <- p + geom_segment( x = -line_xcoordinates[i], y = 0, xend = -line_xcoordinates[i], yend = theoretical_ys[i] , color=hsBlue,   linetype="solid", size = linewidth)
}
p <- p + geom_segment( x = 0, y = 0, xend = 0, yend = amplitudes(0), color=hsBlue,   linetype="solid", size = linewidth)

pdf(outputName, pdfWidth, pdfHeight)
p
