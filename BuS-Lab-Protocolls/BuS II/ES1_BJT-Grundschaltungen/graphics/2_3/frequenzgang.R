library(ggplot2)
library(scales)
library(mosaic)

width <- 10
height <- width * 0.618

outputName <- "2_3_frequenzgang.pdf"

data <- read.csv("ESIGK1_fg.csv")

v <- data$ua/data$ue

data <- data.frame(f = data$f, v = v, vdb = 20 * log10(v))

hypFunDB <- vdb ~ K+L/(sqrt(1+1/(2*pi*M*f)^2))
hypDB.model <- fitModel(hypFunDB, data=data, start=c(K=60, L=20, M=0.00005))


find3db <- function() {

    N <- 3000
    zerodb <- 45

    sampledataf <- c()
    sampledatav <- c()

    for(i in seq(from=min(data$f), to=max(data$f), length.out=N)) {

        sampledataf <- c(sampledataf, i)
        sampledatav <- c(sampledatav, hypDB.model(i))

    }

    v <- sampledatav[which.min(abs(sampledatav - (zerodb - 3)))]

    sampledataf[match(v, sampledatav)]
}

xbreaks <- 10^(0:4)
minor_breaks <- rep(1:9, 21)*(10^rep(0:10, each=9))

fg <- 1700
hsBlue <- "#ced4da7F"
pointColor <- "#339af0"
cutoffColor <- "#d6336c"
cutoffPoint <- data.frame(fg = find3db(), db=hypDB.model(find3db()))

ylabel <- bquote("|V(f)|"~" in dB")
xlabel <- "f in Hz"

p <- ggplot(data=data, aes(x=f, y=vdb)) +
    theme_minimal() +
    ylab(ylabel) +
    xlab(xlabel) +
    stat_function(fun = hypDB.model, n=4000, color=hsBlue) +
    geom_point(color=pointColor) +#
    geom_point(data = cutoffPoint, aes(x=fg, y=db), color=cutoffColor) +#
    scale_x_continuous( trans="log10",breaks = xbreaks, minor_breaks=minor_breaks, labels = trans_format("log10", math_format(10^.x)))

pdf(outputName, width, height)
p
