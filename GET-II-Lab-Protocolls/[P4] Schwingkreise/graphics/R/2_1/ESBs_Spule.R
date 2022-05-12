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
Tcolor        <- "#00BCD8"
AngleColor    <- "#FF67A4"


pdf("ESBs_Spule.pdf", width = output_width, height = output_height)

####################################################################

p9 <- ggplot(data.frame(x=c(0, 2),y=c(0,2)), aes(x,y)) +

        theme_minimal() + # maybe theme_bw()

        #ggtitle("Zeigerbild der Impedanz einer verlustbehafteten Spule im Serienmodell") +

        theme(axis.title.y = element_text(angle = 0, vjust = 0.6180339887498948, size=16.18, color="#0000007F"), axis.text.y = element_text(size = 32.36, color = c("grey60", LcolorNoAlpha))) + # rotate axis title
        theme(axis.title.x = element_text(angle = 0, hjust = 0.6180339887498948, size=16.18, color="#0000007F"), axis.text.x = element_text(size = 32.36, color = c("grey60", RcolorNoAlpha))) +

        xlab(xlabel)  +
        ylab(ylabel)  +

        scale_y_continuous(limits=c(0, 1.23606797749978964),  breaks = c(0,1), labels=c( "",bquote(omega ~ "L"["s"]) ) ) +
        scale_x_continuous(limits=c(0, 1.23606797749978964),  breaks = c(0,Rpos), labels=c("", bquote("R"["s"]) ) )+

        #lines "#E58700"
        # L
        geom_segment( aes(x = 0, y = 1, xend = Rpos, yend = 1 ), color=Lcolor,   linetype="dashed", size = 1.3819660112501051)+
        geom_segment( aes(x = 0, y = 0, xend = 0, yend = 1 ), color=Lcolor,   linetype="solid", arrow = arrow(length = unit(0.5, "cm")), size = 1.3819660112501051) +
        # R
        geom_segment( aes(x = Rpos, y = 0, xend = Rpos, yend = 1 ), color=Rcolor,   linetype="dashed", size = 1.3819660112501051) +
        geom_segment( aes(x = 0, y = 0, xend = Rpos, yend = 0 ), color=Rcolor,   linetype="solid", arrow = arrow(length = unit(0.5, "cm")), size = 1.3819660112501051) +
        # total
        geom_segment( aes(x = 0, y = 0, xend = Rpos, yend = 1 ), color=Tcolor,   linetype="solid", arrow = arrow(length = unit(0.5, "cm")), size = 1.618) +

        # angle display
        geom_curve( aes(x = angleDisplayX, y = tan(angle) * angleDisplayX, xend = 0, yend = tan(angle) * angleDisplayX + angleDisplayX * tan(pi/2-angle)/2),
             curvature = 0.23606797749978964, angle = 90, color = AngleColor, size=1.3819660112501051) +

        annotate(geom="text", x=angleDisplayX*0.333333, y=(tan(angle) * angleDisplayX + angleDisplayX * tan(pi/2-angle)/2)*0.6180339887498948, label=expression(delta), color=AngleColor, size=12.36) +

        annotate(geom="text", x=Rpos+0.0618, y=1.0618, label=expression(underline(Z)), color=Tcolor, size=12.36)

p9
