#RC Tiefpassfilter

library(ggplot2)

options(scipen=10000)

breaks       <- 10^(-10:10)
minor_breaks <- rep(1:9, 21)*(10^rep(-10:10, each=9))

#ybreaks = c(seq(0,1.0,0.1),round(1/sqrt(2),digits = 3));
#ybreaks = ybreaks[-8] # ybreaks without 0.7 (8th element)

output_width  <- 10
output_height <- output_width * 0.6180339887498948

data <- read.csv(file = "RL_HP.csv")

dataU1    <- data$u1
dataU2    <- data$u2
dataPhase <- data$phase
dataX     <- data$ffg
dataY     <- dataU2/dataU1
displaydata <- data.frame(x=dataX, y=dataY)


ylabel <- bquote( phi ~ "/" ~ degree)
xlabel <- bquote( over( "f", "f"[g]))

rc_fun<- function(f) {atan(1/f)}

pdf("RL_HP_phase_clean.pdf", width = output_width, height = output_height, )

####################################################################

p9 <- ggplot(displaydata, aes(dataX, dataY)) +

        theme_minimal() + # maybe theme_bw()

        stat_function(fun = rc_fun, colour = "#E58700") +

        theme(axis.title.y = element_text(angle = 0, vjust = .5)) + # rotate axis title

        xlab(xlabel)  +
        ylab(ylabel)  +

        scale_y_continuous(limits=c(0, pi/2), breaks = c(0, pi/2, pi/4), labels = c(0, 90, 45) ) +
        scale_x_continuous(trans = "log10", breaks = breaks, minor_breaks = minor_breaks, limits=c(0.01, 100), position="bottom")+

        annotation_logticks(sides = "b", colour = "grey69", size = .333) + # maybe remove

        #lines
        geom_segment( aes(x = 0.01, y = pi/4,  xend = 1, yend = pi/4 ), color="grey69", linetype="dashed")+
        geom_segment( aes(x = 1,    y = 0, xend = 1, yend = pi/4 ), color="grey69", linetype="dashed")

p9
