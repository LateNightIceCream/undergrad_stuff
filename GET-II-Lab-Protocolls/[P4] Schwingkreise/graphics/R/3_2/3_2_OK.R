#RC Tiefpassfilter

library(ggplot2)

options(scipen=10000)

breaks       <- 10^(-10:10)
minor_breaks <- rep(1:9, 21)*(10^rep(-10:10, each=9))

output_width  <- 10
output_height <- 10

data  <- read.csv(file = "/home/zamza/Documents/HS/Semester 2/GET II/Labs/[P4] Schwingkreise/graphics/csv/3_2a.csv")
data2 <- read.csv(file = "/home/zamza/Documents/HS/Semester 2/GET II/Labs/[P4] Schwingkreise/graphics/csv/3_2b.csv")

dataX  <- data$f
dataY  <- data$phi

numberofpoints <- 13

real1      <- c()
imaginary1 <- c()

real2      <- c()
imaginary2 <- c()

for(i in 0:(numberofpoints)) {

  real1 <- c(real1, cos(data$phi[i]*pi/180) * data$U[i])
  imaginary1 <- c(imaginary1, sin(data$phi[i]*pi/180) * data$U[i])

  real2 <- c(real2, cos(data2$phi[i]*pi/180) * data2$U[i])
  imaginary2 <- c(imaginary2, sin(data2$phi[i]*pi/180) * data2$U[i])


}

displaydata  <- data.frame(x=real1, y=imaginary1)
displaydata2 <- data.frame(x=real2, y=imaginary2)

ylabel <- bquote( "Im" / ~"V" )
xlabel <- bquote( "Re" / ~"V")

color1 <- "#00B0F6"
color2 <- "#E58700"


pdf("3_2_OK.pdf", width = output_width, height = output_height, )

####################################################################

p9 <- ggplot(displaydata, aes(dataX, dataY)) +

        theme_minimal() + # maybe theme_bw()

        geom_point(data=displaydata, shape ="plus",   aes(x = real1, y = imaginary1, color="a"), color = color1,  size=2.75) +
        geom_point(data=displaydata2,  shape ="plus", aes(x = real2, y = imaginary2, color="b"), color = color2,  size=2.75) +

        theme(axis.title.y = element_text(angle = 0, vjust = .5)) + # rotate axis title

        xlab(xlabel)  +
        ylab(ylabel)  +

        scale_y_continuous(limits=c(-0.3, 0.3), breaks = seq(-0.5, 0.5, by=0.1)) +
        scale_x_continuous(limits=c(0, 0.8), breaks = seq(0, 0.8, by=0.1) )+

        coord_fixed(ratio=1)

p9
