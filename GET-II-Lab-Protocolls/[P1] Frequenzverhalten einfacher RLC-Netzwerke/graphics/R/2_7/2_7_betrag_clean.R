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
dataX     <- data$ffg
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
xlabel <- bquote( over( "f", "f"[g]))

rc_fun<- function(f) {1 / sqrt( 4 + (R*2*pi*f * C - R/(2*pi*f * L) )^2 ) }

pdf("2_7_betrag_clean.pdf", width = output_width, height = output_height, )

####################################################################

p9 <- ggplot(displaydata, aes(dataX, dataY)) +

        theme_minimal() + # maybe theme_bw()

        ggtitle("Betragsgang") +

        stat_function(fun = rc_fun, colour = "dodgerblue3")+

        theme(axis.title.y = element_text(angle = 0, vjust = .5)) + # rotate axis title

        xlab(xlabel)  +
        ylab(ylabel)  +

        scale_y_continuous(limits=c(0, 1), breaks = c(0, 1, 0.5, 1/(2*sqrt(2))), labels = c(0, 1, bquote( over(1,2) ), bquote( over(1, 2*sqrt(2))) ) ) +
        scale_x_continuous(limits=c(4500, 5500), breaks = c(4500, 4600, 4700, 4800, 5000, 5100, 5300, 5400, 5500, 1/(2*pi*sqrt(L*C)), fgb,fga), labels=c(4500, 4600, 4700, 4800, 5000, 5100, 5300, 5400, 5500, bquote(omega["0"]), bquote(omega["-45"]) , bquote(omega["+45"])) ) +

        #lines
        #geom_segment( aes(x = 4500, y = 1/(2*sqrt(2)),  xend = fga, yend = 1/(2*sqrt(2)) ), color="grey69", linetype="dashed") +
        geom_segment( aes(x = 1/(2*pi*sqrt(L*C)),    y = 0,          xend = 1/(2*pi*sqrt(L*C)), yend = 0.5 ), color="grey69", linetype="dashed") +
        geom_segment( aes(x = fgb,    y = 0,          xend = fgb, yend = 1/(2*sqrt(2)) ), color="grey69", linetype="dashed") +
          geom_segment( aes(x = fga,    y = 0,          xend = fga, yend = 1/(2*sqrt(2)) ), color="grey69", linetype="dashed")

p9
