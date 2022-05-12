#RC Tiefpassfilter

library(ggplot2)

options(scipen=10000)

breaks       <- 10^(-10:10)
minor_breaks <- rep(1:9, 21)*(10^rep(-10:10, each=9))

#ybreaks = c(seq(0,1.0,0.1),round(1/sqrt(2),digits = 3));
#ybreaks = ybreaks[-8] # ybreaks without 0.7 (8th element)

output_width  <- 10
output_height <- output_width * 0.6180339887498948

data <- read.csv(file = "2_7.csv")

dataU1    <- data$u1
dataU2    <- data$u2
dataPhase <- data$phase
dataX     <- data$f
dataY     <- dataU2/dataU1
displaydata <- data.frame(x=dataX, y=dataY)

R  <- 1000;
RP <- 1000;
L  <- 0.001;
C  <- 0.000001;


fga <- (sqrt( ((RP+R)/(2*RP*R*C))^2 + 1/(L*C)) + (RP+R)/(2*RP*R*C) ) / (2*pi)
fgb <- (sqrt( ((RP+R)/(2*RP*R*C))^2 + 1/(L*C)) - (RP+R)/(2*RP*R*C) ) / (2*pi)

print(fga)
print(fgb)

ylabel <- bquote( over( "|" ~ underline("U")[2] ~ "|"  , "|" ~ underline("U")[1] ~ "|") )
xlabel <- bquote( over( "f" / ~"Hz"))

rc_fun<- function(f) {1 / sqrt( 4 + (R*2*pi*f * C - R/(2*pi*f * L) )^2 ) }

pdf("2_7_betrag.pdf", width = output_width, height = output_height, )

####################################################################

p9 <- ggplot(displaydata, aes(dataX, dataY)) +

        theme_minimal() + # maybe theme_bw()

        ggtitle("Betragsgang: RLC - Netzwerk") +

        stat_function(fun = rc_fun, colour = "dodgerblue3")+

        geom_point(data=displaydata, shape ="plus", aes(color="Dataset2"), color = "deeppink1",  ) +

        theme(axis.title.y = element_text(angle = 0, vjust = .5)) + # rotate axis title

        xlab(xlabel)  +
        ylab(ylabel)  +

        scale_y_continuous(limits=c(0, 1), breaks = c(0, 1, 0.5, 1/(2*sqrt(2)), 0.25, 0.125), labels = c(0, 1, bquote( over(1,2) ), bquote( over(1, 2*sqrt(2))), bquote( over(1, 4) ) , bquote( over(1, 8))) ) +
        scale_x_continuous(limits=c(3000, 5700), breaks = seq(3000, 5700, by=200) )


p9
