library(ggplot2)
library(scales)
library(mosaic)

width <- 10
height <- width * 0.618

outputName <- "frequenzgang_TP.pdf"

data <- read.csv("frequenzgang.csv")

v <- data$uaeff/data$ueeff

data <- data.frame(f = data$f, v = v, vdb = 20 * log10(v))

hypFunDB <- vdb ~ B + A/sqrt(1 + (2*pi*f*T)^2)
#hypFunDB <- vdb ~ K + L/sqrt(1 + (2*pi*(f-D)*T)^2)
hypDB.model <- fitModel(hypFunDB, data=data, start=c(B = -15, A = 100, T=0.0004829))

hypFunDB  <- vdb ~ B  + A * 20*log10( 1/sqrt(1 + (2*pi*f*T)^2  ) )
hypDB.model <- fitModel(hypFunDB, data=data, start=c(B = 14, A = 1, T=0.00076))


## testFunction <- function(f) {

##     tau = 0.00076
##     A = 1

##     B = 14

##     B + 20*A*log10(1/sqrt(1+(2*pi*(f)*tau)^2))

## }

summary(hypDB.model)

find3db <- function() {

    N <- 3000
    zerodb <- 13.93

    sampledataf <- c()
    sampledatav <- c()

    for(i in seq(from=min(data$f), to=max(data$f), length.out=N)) {

        sampledataf <- c(sampledataf, i)
        sampledatav <- c(sampledatav, hypDB.model(i))

    }

    v <- sampledatav[which.min(abs(sampledatav - (zerodb - 3)))]

    sampledataf[match(v, sampledatav)]
}

pA <- 10^3
pB <- 10^4

(hypDB.model(pB) - hypDB.model(pA))

xbreaks <- 10^(0:4)
xlim <- 10^c(1,4)
minor_breaks <- rep(1:9, 21)*(10^rep(0:10, each=9))

hsBlue <- "#ced4da7F"
pointColor <- "#495057"
cutoffColor <- "#d6336c"
cutoffPoint <- data.frame(fg = find3db(), db=hypDB.model(find3db()))

cutoffPoint

ylabel <- bquote("|V(f)|"~" in dB")
xlabel <- "f in Hz"

p <- ggplot(data=data, aes(x=f, y=vdb)) +
    theme_minimal() +
    ylab(ylabel) +
    xlab(xlabel) +

    theme(text = element_text(size=16))+

    geom_segment(aes(x = cutoffPoint$fg, y = -15, xend= cutoffPoint$fg, yend=cutoffPoint$db), color=hsBlue, linetype=2, alpha = 0.2) +

    stat_function(fun = hypDB.model, n=4000, color=hsBlue) +
#    stat_function(fun = testFunction, n=4000, color="red") +

    geom_point(color=pointColor) +#
    geom_point(data = cutoffPoint, aes(x=fg, y=db), color=cutoffColor) +#

    scale_x_continuous( trans="log10",breaks = xbreaks, minor_breaks=minor_breaks, labels = trans_format("log10", math_format(10^.x)), limits=xlim)




pdf(outputName, width, height)
p
