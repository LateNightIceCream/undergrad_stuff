#Komplexe Zeiger von R, L, C

library(ggplot2)
library(ggforce)

options(scipen=10000)

output_width  <- 10
output_height <- output_width


ylabel <- "Im"
xlabel <- "Re"




angleDisplayX <- 0.1618

Rcolor        <- "#00BF7D2F"
RcolorNoAlpha <- "#00BF7D"
Lcolor        <- "#F8766D2F"
LcolorNoAlpha <- "#F8766D"
Tcolor        <- "#00B0F6"
AngleColor    <- "#FF67A4"
DirectionColor<- "#00B0F67F"

pdf("2_4_OK.pdf", width = output_width, height = output_height)


ylimit <- 0.006180339887498948
xlimit <- ylimit*2

R <- 100
L <- 1.3
C <- 22.6 * 10^(-6)

Rpos <- 1/R

dirposx <- Rpos/2
dirposy <- -Rpos/2 * 0.6180339887498948 * 1.3155617496424828
#
offset  <- 0.0005
dirposx2<- dirposx - offset*2
dirposy2<- dirposy + offset



re_part <- function(w) {

  R/(R^2 + w^2 * L^2)

}

im_part <- function(w) {

  -w*L/(R^2+w^2*L^2)+w*C

}

numberOfPoints <- 20000


rePoints <- c()
imPoints <- c()

for (i in 0:numberOfPoints) {

  rePoints <- c(rePoints, re_part(i))
  imPoints <- c(imPoints, im_part(i))

}

points <- data.frame(x = rePoints, y=imPoints)

####################################################################

p9 <- ggplot(data.frame(x=c(0, 2),y=c(0,2)), aes(x,y)) +

        theme_minimal() + # maybe theme_bw()

        theme(axis.title.y = element_text(angle = 0, vjust = 0.6180339887498948, size=16.18, color="#0000007F"), axis.text.y = element_text(size = 32.36, color = c("grey60", LcolorNoAlpha))) + # rotate axis title
        theme(axis.title.x = element_text(angle = 0, hjust = 0.6180339887498948, size=16.18, color="#0000007F"), axis.text.x = element_text(size = 32.36, color = c("grey60", RcolorNoAlpha))) +

        xlab(xlabel)  +
        ylab(ylabel)  +

        scale_y_continuous(limits=c(-ylimit, ylimit),  breaks = c(0,1), labels=c( 0,"" ) ) +
        scale_x_continuous(limits=c(0, xlimit),  breaks = c(0,Rpos), labels=c(0, bquote(over(1,"R"["s"]))) )+

        geom_segment( aes(x = 0, y = 0, xend = Rpos, yend = 0 ), color=Rcolor,   linetype="solid", arrow = arrow(length = unit(0.5, "cm")), size = 1.3819660112501051)+

        #direction arrow
        geom_curve( aes(x = dirposx, y = dirposy, xend = dirposx2, yend = dirposy2),
             curvature = -0.25, angle = 90, color = DirectionColor, size=1.3819660112501051, arrow = arrow(length = unit(0.5, "cm")))+

        annotate(geom="text", x=Rpos + Rpos*0.09016994374947421, y=0, label=expression(omega~"=0"), color=Rcolor, size=11.459)+
        annotate(geom="text", x=re_part(1/(sqrt(L*C))), y=-0.000381, label=expression(omega[0]), color=Rcolor, size=11.459)+

        geom_path(data=points, color=Tcolor, size=1.6180339887498948) +

        annotate(geom="text", x=Rpos/2-offset, y=-Rpos/2 + offset, label=expression(omega), color=DirectionColor, size=11.459)


p9
