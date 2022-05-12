#Komplexe Zeiger von R, L, C

library(ggplot2)

options(scipen=10000)

output_width  <- 10
output_height <- output_width


ylabel <- "Im"
xlabel <- "Re"

Rpos <- 0.618

angle <- atan(1/Rpos)

angleDisplayX <- 0.1618



Rcolor        <- "#00BF7D2F"
RcolorNoAlpha <- "#00BF7D"
Lcolor        <- "#F8766D2F"
LcolorNoAlpha <- "#F8766D"
Tcolor        <- "#00B0F6"
AngleColor    <- "#FF67A4"
DirectionColor<- "#00B0F67F"

pdf("PSK_Admittanz.pdf", width = output_width, height = output_height)

####################################################################

p9 <- ggplot(data.frame(x=c(0, 2),y=c(0,2)), aes(x,y)) +

        theme_minimal() + # maybe theme_bw()

        #ggtitle("Zeigerbild der Impedanz einer verlustbehafteten Spule im Serienmodell") +

        theme(axis.title.y = element_text(angle = 0, vjust = 0.6180339887498948, size=16.18, color="#0000007F"), axis.text.y = element_text(size = 32.36, color = c("grey60", LcolorNoAlpha))) + # rotate axis title
        theme(axis.title.x = element_text(angle = 0, hjust = 0.6180339887498948, size=16.18, color="#0000007F"), axis.text.x = element_text(size = 32.36, color = c("grey60", RcolorNoAlpha))) +

        xlab(xlabel)  +
        ylab(ylabel)  +

        scale_y_continuous(limits=c(-1.6180339887498948*1.23606797749978964, 1.6180339887498948*1.23606797749978964),  breaks = c(0,1), labels=c( 0,"" ) ) +
        scale_x_continuous(limits=c(0, 1.23606797749978964),  breaks = c(0,Rpos), labels=c(0, bquote(over(1,"R"["p"])) ) )+

        # total
        geom_segment( aes(x = Rpos, y = -1.6180339887498948, xend = Rpos, yend = 1.6180339887498948), color=Tcolor,   linetype="solid", size = 1.6180339887498948) +
        geom_segment( aes(x = 0, y = 0, xend = Rpos, yend = 0 ), color=Rcolor,   linetype="solid", arrow = arrow(length = unit(0.5, "cm")), size = 1.3819660112501051)+
        # grenzfrequenzpfeile
        geom_segment( aes(x = 0, y = 0, xend = Rpos, yend = 1 ), color=Lcolor,   linetype="solid", arrow = arrow(length = unit(0.5, "cm")), size = 1.3819660112501051) +
        geom_segment( aes(x = 0, y = 0, xend = Rpos, yend = -1 ), color=Lcolor,   linetype="solid", arrow = arrow(length = unit(0.5, "cm")), size = 1.3819660112501051) +

        #annotate(geom="text", x=angleDisplayX*0.333333, y=(tan(angle) * angleDisplayX + angleDisplayX * tan(pi/2-angle)/2)*0.6180339887498948, label=expression(delta), color=AngleColor, size=11.459)
        annotate(geom="text", x=Rpos+0.05572809000084119, y=0.01458980337503154, label=expression(omega[0]), color=Rcolor, size=11.459) +
        annotate(geom="text", x=Rpos+0.1458980337503154/2, y=sqrt(Rpos^2+(1.6180339887498948/2)^2), label=expression(omega["+45"]), color=Lcolor, size=11.459) +
        annotate(geom="text", x=Rpos+0.1458980337503154/2, y=-sqrt(Rpos^2+(1.6180339887498948/2)^2), label=expression(omega["-45"]), color=Lcolor, size=11.459) +

        #direction arrow
        geom_segment( aes(x = 1.1458980337503154, y = -0.3819660112501051, xend = 1.1458980337503154, yend = 0.3819660112501051 ), color=DirectionColor,   linetype="solid", arrow = arrow(length = unit(0.5, "cm")), size = 1.3819660112501051)+
        annotate(geom="text", x=1.1458980337503154+0.09016994374947421/2, y=0, label=expression(omega), color=DirectionColor, size=11.459)

p9
