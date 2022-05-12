# RL Hochpassfilter
library(ggplot2)

options(scipen=10000)

breaks       <- 10^(-10:10)
minor_breaks <- rep(1:9, 21)*(10^rep(-10:10, each=9))

ybreaks = c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 1/sqrt(2), 0.8, 0.9, 1)
ylabels = c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, "", bquote(over(1,sqrt(2))), 0.8, 0.9, 1)

output_width  <- 10
output_height <- output_width * 0.6180339887498948

data <- read.csv(file = "RL_HP.csv")

dataU1    <- data$u1
dataU2    <- data$u2
dataPhase <- data$phase
dataX     <- data$ffg
dataY     <- dataU2/dataU1
displaydata <- data.frame(x=dataX, y=dataY)


ylabel <- bquote( over( "|" ~ underline("U")[2] ~ "|"  , "|" ~ underline("U")[1] ~ "|") )
xlabel <- bquote( over( "f", "f"[g]))

rc_fun<- function(f) {1 / sqrt(1 + 1/(f)^2)}

pdf("RL_HP.pdf", width = output_width, height = output_height, )

####################################################################

p9 <- ggplot(displaydata, aes(dataX, dataY)) +

        theme_minimal() + # maybe theme_bw()

        ggtitle("Betragsgang: RL - Hochpassfilter") +

        stat_function(aes(color = "he world"), fun = rc_fun, colour = "dodgerblue3")+

        #geom_point(aes(colour = "red", shape="plus") , shape="plus") +
        geom_point(data=displaydata, shape ="plus", aes(color="Dataset2"), color = "deeppink1",  ) +

        #geom_point(aes(color = "Dataset1"), colour="deeppink1", shape="plus", size=2)+
        #geom_point(data = displaydata, aes(color="Dataset1"), colour="deeppink1", shape="plus", size=2) +

        theme(axis.title.y = element_text(angle = 0, vjust = .5)) +

        theme(
          legend.position = c(0.95, 0.95),
          legend.justification = c("right", "top")
        ) +

        xlab(xlabel)  +
        ylab(ylabel)    +

        scale_y_continuous(limits=c(0, 1), breaks = ybreaks, labels=ylabels) +
        scale_x_continuous(trans = "log10", breaks = breaks, minor_breaks = minor_breaks, limits=c(0.01, 100))+

        annotation_logticks(sides = "b", colour = "grey69", size = .333) # maybe remove


p9
