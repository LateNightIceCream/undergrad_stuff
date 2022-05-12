library(ggplot2)
library(scales)
library(mosaic)

width <- 10
height <- width * 0.618

outputName <- "phasengang_TP.pdf"

data <- read.csv("frequenzgang.csv")

v <- data$phi

data <- data.frame(f = data$f, phi = data$phi-180)

#hypFunDB <- vdb ~ B + A/sqrt(1 + (2*pi*f*T)^2)
#hypFunDB <- vdb ~ K + L/sqrt(1 + (2*pi*(f-D)*T)^2)
#hypDB.model <- fitModel(hypFunDB, data=data, start=c(B = -15, A = 100, T=0.0004829))

hypFunDB  <- phi ~ A*atan(2*pi*T*f)
hypDB.model <- fitModel(hypFunDB, data=data, start=c(A = -180/pi, T=500*10^(-6)))


testFunction <- function(f) {

    tau <- 500 * 10^(-6)
    -atan(2*pi*tau*f)*180/pi

}

summary(hypDB.model)

find45deg <- function() {

    N <- 3000

    sampledataf <- c()
    sampledatav <- c()

    for(i in seq(from=min(data$f), to=max(data$f), length.out=N)) {

        sampledataf <- c(sampledataf, i)
        sampledatav <- c(sampledatav, hypDB.model(i))

    }

    v <- sampledatav[which.min(abs(sampledatav + 45))] # watch sign

    sampledataf[match(v, sampledatav)]
}

xbreaks <- 10^(0:4)
xlim <- 10^c(1,4)
minor_breaks <- rep(1:9, 21)*(10^rep(0:10, each=9))

hsBlue <- "#ced4da7F"
theoColor <- "#ffec99"
pointColor <- "#495057"
cutoffColor <- "#d6336c"
cutoffPoint <- data.frame(fg = find45deg(), db=hypDB.model(find45deg()))

cutoffPoint

ylabel <- bquote(phi~ " in °")
xlabel <- "f in Hz"

ylim <- c(-100, 0)

p <- ggplot(data=data, aes(x=f, y=phi)) +
    theme_minimal() +
    ylab(ylabel) +
    xlab(xlabel) +
    scale_y_continuous(limits=ylim) +

    theme(text = element_text(size=16))+

    geom_segment(aes(x = cutoffPoint$fg, y = -100, xend= cutoffPoint$fg, yend=cutoffPoint$db), color=hsBlue, linetype=2, alpha = 0.2) +

    stat_function(fun = hypDB.model, n=4000, color=hsBlue) +
    stat_function(fun = testFunction, n=4000, color=theoColor) +

   geom_point(color=pointColor) +#
    geom_point(data = cutoffPoint, aes(x=fg, y=db), color=cutoffColor) +#

    scale_x_continuous( trans="log10",breaks = xbreaks, minor_breaks=minor_breaks, labels = trans_format("log10", math_format(10^.x)), limits=xlim)




pdf(outputName, width, height)
p
