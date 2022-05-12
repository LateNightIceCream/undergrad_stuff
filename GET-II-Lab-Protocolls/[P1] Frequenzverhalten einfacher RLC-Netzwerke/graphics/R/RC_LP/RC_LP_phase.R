#RC Tiefpassfilter

library(ggplot2)

options(scipen=10000)

breaks       <- 10^(-10:10)
minor_breaks <- rep(1:9, 21)*(10^rep(-10:10, each=9))

#ybreaks = c(seq(0,1.0,0.1),round(1/sqrt(2),digits = 3));
#ybreaks = ybreaks[-8] # ybreaks without 0.7 (8th element)

output_width  <- 10
output_height <- output_width * 0.6180339887498948

data <- read.csv(file = "RC_LP.csv")

dataU1    <- data$u1
dataU2    <- data$u2
dataPhase <- data$phase * 2 * pi / 360
dataX     <- data$ffg
dataY     <- dataPhase
displaydata <- data.frame(x=dataX, y=dataY)


ylabel <- bquote( phi ~ "/" ~ degree)
xlabel <- bquote( over( "f", "f"[g]))

rc_fun<- function(f) {-atan(f)}

pdf("RC_LP_phase.pdf", width = output_width, height = output_height, )

####################################################################

p9 <- ggplot(displaydata, aes(dataX, dataY)) +

        theme_minimal() + # maybe theme_bw()
        ggtitle("Phasengang: RC - Tiefpassfilter") +

        stat_function(fun = rc_fun, colour = "#E58700") +

        geom_point(data=displaydata, shape ="plus", aes(color="Dataset2"), color = "deeppink1",  ) +

        theme(axis.title.y = element_text(angle = 0, vjust = .5)) + # rotate axis title

        xlab(xlabel)  +
        ylab(ylabel)  +

        scale_y_continuous(limits=c(-pi/2, 0), breaks = c(0, -pi/2, -pi/4, -1/3*pi, -1/6*pi, -1/12*pi, -5/12*pi), labels = c(0, -90, -45, -60, -30, -15, -75) ) +
        scale_x_continuous(trans = "log10", breaks = breaks, minor_breaks = minor_breaks, limits=c(0.01, 100), position="top")+

        annotation_logticks(sides = "t", colour = "grey69", size = .333) # maybe remove

p9
