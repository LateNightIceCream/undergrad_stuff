#RC Tiefpassfilter

library(ggplot2)

options(scipen=10000)

breaks       <- 10^(-10:10)
minor_breaks <- rep(1:9, 21)*(10^rep(-10:10, each=9))

output_width  <- 10
output_height <- output_width * 0.6180339887498948

data <- read.csv(file = "/home/zamza/Documents/HS/Semester 2/GET II/Labs/[P4] Schwingkreise/graphics/csv/3_2a.csv")
data2 <- read.csv(file = "/home/zamza/Documents/HS/Semester 2/GET II/Labs/[P4] Schwingkreise/graphics/csv/3_2b.csv")

dataX     <- data$f
dataY     <- data$phi
displaydata  <- data.frame(x=dataX,   y=dataY)
displaydata2 <- data.frame(x=data2$f, y=data2$phi)

ylabel <- bquote( phi / ~"°" )
xlabel <- bquote( "f" / ~"Hz")

color1 <- "#00B0F6"
color2 <- "#E58700"


pdf("3_2_phase.pdf", width = output_width, height = output_height, )

####################################################################

p9 <- ggplot(displaydata, aes(dataX, dataY)) +

        theme_minimal() + # maybe theme_bw()

        geom_point(data=displaydata, shape ="plus", aes(color="a"), color = color1,  size=2.75) +
        geom_point(data=displaydata2, shape ="plus", aes(x = data2$f, y = data2$phi, color="b"), color = color2,  size=2.75) +

        theme(axis.title.y = element_text(angle = 0, vjust = .5)) + # rotate axis title

        xlab(xlabel)  +
        ylab(ylabel)  +

        scale_y_continuous(limits=c(-90, 90), breaks = seq(-90, 90, by=20)) +
        scale_x_continuous(limits=c(2500, 7500), breaks = seq(2500, 7500, by=500) )

p9
