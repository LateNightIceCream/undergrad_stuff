#RC Tiefpassfilter

library(ggplot2)

options(scipen=10000)

breaks       <- 10^(-10:10)
minor_breaks <- rep(1:9, 21)*(10^rep(-10:10, each=9))

#ybreaks = c(seq(0,1.0,0.1),round(1/sqrt(2),digits = 3));
#ybreaks = ybreaks[-8] # ybreaks without 0.7 (8th element)

output_width  <- 10
output_height <- output_width * 0.6180339887498948

data  <- read.csv(file = "/home/zamza/Documents/HS/Semester 2/GET II/Labs/[P2] Wechselstromwiderstände und Brückenschaltungen /graphics/csv/31a.csv")
datab <-read.csv(file = "/home/zamza/Documents/HS/Semester 2/GET II/Labs/[P2] Wechselstromwiderstände und Brückenschaltungen /graphics/csv/32a.csv")
datac <- read.csv(file = "/home/zamza/Documents/HS/Semester 2/GET II/Labs/[P2] Wechselstromwiderstände und Brückenschaltungen /graphics/csv/33a.csv")

datat <-read.csv(file = "/home/zamza/Documents/HS/Semester 2/GET II/Labs/[P2] Wechselstromwiderstände und Brückenschaltungen /graphics/csv/special_L.csv")

#dataUR    <- data$ureff
dataUL    <- data$ULL
#dataUG    <- data$ugeff
dataXa     <- data$f
dataXb     <- datab$f
dataXc     <- datac$f
dataYa     <- data$scheinwiderstand
dataYb     <- datab$scheinwiderstand
dataYc     <- datac$scheinwiderstand

displaydata  <- data.frame(x = dataXa, y=dataYa)
displaydata2 <- data.frame(x = dataXb, y=dataYb)
displaydata3 <- data.frame(x = dataXc, y=dataYc)

totaldata    <- data.frame(x = datat$f, y=datat$scheinwiderstand)

ylabel <- bquote( "|Z|" / ~ Omega )
xlabel <- bquote( "f" / ~"Hz")

R <- 1000
L <- 0.298809597817879
URS <- 2
I <- 0.002

color1 <- "#00BCD8"
color2 <- "#00BF7D"
color3 <- "#F8766D"

color4 <- "#00BCD8"
color5 <- "#00BF7D"
color6 <- "#F8766D"

pdf("3_3_Scheinwiderstand.pdf", width = output_width, height = output_height, )

####################################################################

p9 <- ggplot(totaldata, aes(datat$f, datat$scheinwiderstand)) +

        theme_minimal() + # maybe theme_bw()
        theme(legend.position = c(0.8, 0.9), legend.background = element_rect(colour = '#FFFFFFFF', fill = 'white', size = 3), legend.title = element_blank()) +

        ggtitle(bquote( "|Z|")) +

        geom_smooth(method="auto", se=FALSE, color="grey68") +

        geom_point(data=displaydata,  shape ="plus",  size=2.75, aes(x=dataXa, y=dataYa,colour="3.1 b)")) +
        geom_point(data=displaydata2, shape ="plus", size=2.75, aes(x = dataXb, y = dataYb, color="3.2 a)")) +
        geom_point(data=displaydata3, shape ="plus", aes(x = dataXc, y = dataYc, color="3.3 a)"),  size=2.75) +

        scale_colour_manual(breaks = c("3.1 b)", "3.2 a)", "3.3 a)"), values = c("3.1 b)"=color1, "3.2 a)"=color2, "3.3 a)"=color3))+

        theme(axis.title.y = element_text(angle = 0, vjust = .5)) + # rotate axis title

        xlab(xlabel)  +
        ylab(ylabel)  +

        scale_y_continuous(limits=c(0, 4000), breaks = seq(0, 4000, by=400)) +
        scale_x_continuous(limits=c(0, 2000), breaks = seq(0, 2000, by=500) )

p9
