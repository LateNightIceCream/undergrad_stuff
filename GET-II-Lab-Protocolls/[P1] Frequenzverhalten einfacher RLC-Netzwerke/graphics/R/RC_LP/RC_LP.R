#RC Tiefpassfilter

library(ggplot2)

options(scipen=10000)

breaks       <- 10^(-10:10)
minor_breaks <- rep(1:9, 21)*(10^rep(-10:10, each=9))

ybreaks = c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 1/sqrt(2), 0.8, 0.9, 1)
ylabels = c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, "", bquote(over(1,sqrt(2))), 0.8, 0.9, 1)

output_width  <- 10
output_height <- output_width * 0.6180339887498948

data <- read.csv(file = "RC_LP.csv")

dataU1    <- data$u1
dataU2    <- data$u2
dataPhase <- data$phase
dataX     <- data$ffg
dataY     <- dataU2/dataU1
displaydata <- data.frame(x=dataX, y=dataY)


ylabel <- bquote( over( "|" ~ underline("U")[2] ~ "|"  , "|" ~ underline("U")[1] ~ "|") )
xlabel <- bquote( over( "f", "f"[g]))

rc_fun<- function(f) {1 / sqrt(1 + (f)^2)}

pdf("RC_LP.pdf", width = output_width, height = output_height, )

####################################################################

p9 <- ggplot(displaydata, aes(dataX, dataY)) +

        theme_minimal() + # maybe theme_bw()

        ggtitle("Betragsgang: RC - Tiefpassfilter") +

        stat_function(fun = rc_fun, colour = "dodgerblue3")+

        geom_point(data=displaydata, shape ="plus", aes(color="Dataset2"), color = "deeppink1",  ) +

        theme(axis.title.y = element_text(angle = 0, vjust = .5)) +

        xlab(xlabel)    +
        ylab(ylabel)    +

        scale_y_continuous(limits=c(0, 1), breaks = ybreaks, labels=ylabels) +
        scale_x_continuous(trans = "log10", breaks = breaks, minor_breaks = minor_breaks, limits=c(0.01, 100))+

        annotation_logticks(sides = "b", colour = "grey69", size = .333) # maybe remove


p9
