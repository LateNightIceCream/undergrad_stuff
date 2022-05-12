library(ggplot2)

outputName <- "loss.pdf"
pdfWidth <- 10
pdfHeight <- pdfWidth * 0.618


T   <- 250 * 10^-6
tau <- 125 * 10^-6

U2 <- 1

m <- 5

amplitudes <- function(n) {

if(n == 0) { return( U2 * tau/T ) }

abs(    U2 * tau/T * sin(pi * n * tau/T) / (n * pi * tau/T))

}

wave1 = function(t) {

    2*amplitudes(1) * sin(2*pi*1/T*t)

}
wave0 = function(t) {

    amplitudes(0)

}
wave3 = function(t) {

    2*amplitudes(3) * sin(3*2*pi*1/T*t)
}
wave5 = function(t) {

    2*amplitudes(5) * sin(5*2*pi*1/T*t)
}

resWave = function(t) {

    wave0(t)+wave1(t) + wave3(t)

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

xlimits <- c(0,4*T)
xbreaks <- seq(0, 4*T, T)
xlabels <- c("0", "T", "2T", "3T", "4T")
ylimits <- c(-0.15, U2*1.618)

xlabel <- "t"
ylabel <- bquote("u"[2]~"(t) / A")


hsBlue <- "#00b1db"

p <- ggplot(data.frame(x=c(0,2)), aes(x=x)) +
    theme_minimal() +
    scale_x_continuous(limits = xlimits, breaks = xbreaks, labels=xlabels) +
    scale_y_continuous(limits = ylimits) +
#    stat_function( fun = amplitudes, n = 4000, linetype=2, color = hsBlue) +
#    stat_function( fun = wave1, n = 4000, linetype=1, color = hsBlue) +
#    stat_function( fun = wave0, n = 4000, linetype=1, color = hsBlue) +
#    stat_function( fun = wave3, n = 4000, linetype=1, color = hsBlue) +
    stat_function( fun = resWave, n = 4000, linetype=1, color = hsBlue) +
    xlab(xlabel) +
    ylab(ylabel)



pdf(outputName, pdfWidth, pdfHeight)
p
