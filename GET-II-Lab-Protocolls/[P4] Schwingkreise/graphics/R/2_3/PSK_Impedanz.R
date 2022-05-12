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

pdf("PSK_Impedanz.pdf", width = output_width, height = output_height)

 circles <- data.frame(
   x0 = rep(1:3, 3),
   y0 = rep(1:3, each = 3),
   r = seq(0.1, 1, length.out = 9)
)

ylimit <- 1.6180339887498948*1.23606797749978964
xlimit <- ylimit*2

Rpos <- xlimit*0.6180339887498948
angle <- atan(1/Rpos)

dirposx <- Rpos
dirposy <- Rpos * 0.23606797749978964
#
offset  <- 0.618
dirposx2<- dirposx - offset
dirposy2<- dirposy + offset

####################################################################

p9 <- ggplot(data.frame(x=c(0, 2),y=c(0,2)), aes(x,y)) +

        theme_minimal() + # maybe theme_bw()

        #ggtitle("Zeigerbild der Impedanz einer verlustbehafteten Spule im Serienmodell") +

        theme(axis.title.y = element_text(angle = 0, vjust = 0.6180339887498948, size=16.18, color="#0000007F"), axis.text.y = element_text(size = 32.36, color = c("grey60", LcolorNoAlpha))) + # rotate axis title
        theme(axis.title.x = element_text(angle = 0, hjust = 0.6180339887498948, size=16.18, color="#0000007F"), axis.text.x = element_text(size = 32.36, color = c("grey60", RcolorNoAlpha))) +

        xlab(xlabel)  +
        ylab(ylabel)  +

        scale_y_continuous(limits=c(-ylimit, ylimit),  breaks = c(0,1), labels=c( 0,"" ) ) +
        scale_x_continuous(limits=c(0, xlimit),  breaks = c(0,Rpos), labels=c(0, bquote("R"["p"])) )+
        # grenzfrequenzpfeile
        geom_segment( aes(x = 0, y = 0, xend = Rpos/2, yend = Rpos/2 ), color=Lcolor,   linetype="solid", arrow = arrow(length = unit(0.5, "cm")), size = 1.3819660112501051) +
        geom_segment( aes(x = 0, y = 0, xend = Rpos/2, yend = -Rpos/2 ), color=Lcolor,   linetype="solid", arrow = arrow(length = unit(0.5, "cm")), size = 1.3819660112501051) +

        annotate(geom="text", x=Rpos+0.1458980337503154, y=0.01458980337503154, label=expression(omega[0]), color=Rcolor, size=11.459) +


        geom_segment( aes(x = 0, y = 0, xend = Rpos, yend = 0 ), color=Rcolor,   linetype="solid", arrow = arrow(length = unit(0.5, "cm")), size = 1.3819660112501051)+


        annotate(geom="text", x=Rpos/2, y=Rpos/2+0.1618, label=expression(omega["+45"]), color=Lcolor, size=11.459)+
        annotate(geom="text", x=Rpos/2, y=-(Rpos/2+0.1618), label=expression(omega["-45"]), color=Lcolor, size=11.459)+

        #direction arrow
        geom_curve( aes(x = dirposx, y = dirposy, xend = dirposx2, yend = dirposy2),
             curvature = 1/(Rpos/2)/4, angle = 90, color = DirectionColor, size=1.3819660112501051, arrow = arrow(length = unit(0.5, "cm")))+
        annotate(geom="text", x=0.2+(dirposx+dirposx2)/2, y=0.2+(dirposy + dirposy2)/2, label=expression(omega), color=DirectionColor, size=11.459)+


        geom_circle(aes(x0 = Rpos/2, y0 = 0, r = Rpos/2), inherit.aes = FALSE, color=Tcolor, size=1.6180339887498948)+
        coord_fixed(ratio=1)

p9
