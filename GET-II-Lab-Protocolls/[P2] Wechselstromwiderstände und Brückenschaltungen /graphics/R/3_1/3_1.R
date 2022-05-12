#RC Tiefpassfilter

library(ggplot2)

options(scipen=10000)

breaks       <- 10^(-10:10)
minor_breaks <- rep(1:9, 21)*(10^rep(-10:10, each=9))

#ybreaks = c(seq(0,1.0,0.1),round(1/sqrt(2),digits = 3));
#ybreaks = ybreaks[-8] # ybreaks without 0.7 (8th element)

output_width  <- 10
output_height <- output_width * 0.6180339887498948

data <- read.csv(file = "/home/zamza/Documents/HS/Semester 2/GET II/Labs/[P2] Wechselstromwiderstände und Brückenschaltungen /graphics/csv/31a.csv")

dataUR    <- data$ureff
dataUL    <- data$uleff
dataUG    <- data$ugeff
dataPhase <- data$phase
dataX     <- data$f
dataY     <- dataUR
displaydata  <- data.frame(x=dataX,   y=dataUR)
displaydata2 <- data.frame(x = dataX, y=dataUL)
displaydata3 <- data.frame(x = dataX, y=dataUG)

ylabel <- bquote( "U" / ~"V" )
xlabel <- bquote( "f" / ~"Hz")

R <- 1000
L <- 0.298809597817879
I <- 0.002

color1 <- "#00734b"
color2 <- "#007182"
color3 <- "#954741"

color4 <- "#00BCD8"
color5 <- "#00BF7D"
color6 <- "#F8766D"

uges<- function(f) {I * sqrt(R^2 + (4*pi^2*f^2 * L^2)) }
ur  <- function(f) {I * R}
ul  <- function(f) {I * (2*pi*f*L)}

#rc_fun<- function(f) {1 / sqrt( 4 + (R*2*pi*f * C - R/(2*pi*f * L) )^2 ) }

pdf("3_1.pdf", width = output_width, height = output_height, )

####################################################################

p9 <- ggplot(displaydata, aes(dataX, dataY)) +

        theme_minimal() + # maybe theme_bw()

        ggtitle("Messung an realer Induktivität") +

        stat_function(fun = uges, colour = color6)+
        stat_function(fun = ul,   colour = color5)+
        stat_function(fun = ur,   colour = color4) +

        geom_point(data=displaydata, shape ="plus", aes(color="Dataset2"), color = color2,  size=2.75) +
        geom_point(data=displaydata2, shape ="plus", aes(x = dataX, y = dataUL, color="Dataset2"), color = color1,  size=2.75) +
        geom_point(data=displaydata3, shape ="plus", aes(x = dataX, y = dataUG,color="Dataset2"), color = color3,  size=2.75) +

        theme(axis.title.y = element_text(angle = 0, vjust = .5)) + # rotate axis title

        xlab(xlabel)  +
        ylab(ylabel)  +

        scale_y_continuous(limits=c(0, 6), breaks = seq(0, 6, by=0.5)) +
        scale_x_continuous(limits=c(0, 1500), breaks = seq(0, 1500, by=500) ) +

        annotate(geom="text", x=1400, y=1.618,  label=bquote("UR"),  color=color4,  size=4*1.618) +
        annotate(geom="text", x=1400, y=4.8, label=bquote("UL"),    color=color5,  size=6.18) +
        annotate(geom="text", x=1400, y=6,  label=bquote("Uges"),    color=color6,  size=6.18)


p9
