#Komplexe Zeiger von R, L, C

library(ggplot2)

options(scipen=10000)

output_width  <- 10
output_height <- output_width


ylabel <- "Im / V"
xlabel <- "Re / V"

Rpos <- 0.618

f <- 300
Uges_eff <- 2.223
Ur_eff   <- 2
Ul_eff   <- 1.1063
Ull_eff  <- 1.10203
Urs_eff  <- 0.09707
phi      <- 84.96647 * pi/180


Rcolor <- "#FF67A4"
Lcolor <- "#F8766D"
Tcolor <- "#00BCD8"

UgesColor<- "#B983FF"
ULColor  <- "#00C0AF"
OKcolor  <- "#00B0F6"

pdf("ZeigerbildSpannung.pdf", width = output_width, height = output_height)

####################################################################

p9 <- ggplot(data.frame(x=c(0, 2),y=c(0,2)), aes(x,y)) +

        theme_minimal() + # maybe theme_bw()

        ggtitle("Zeigerdiagramm für f = 300Hz (gestrichelt: Ortskurve)") +

        theme(axis.title.y = element_text(angle = 0, vjust = 0.5, size=16.18) ) + # rotate axis title
        theme(axis.title.x = element_text(angle = 0, hjust = 0.5, size=16.18) ) +

        xlab(xlabel)  +
        ylab(ylabel)  +

        scale_y_continuous(limits=c(0,1.5),  breaks = seq(0,1.5, by=0.25)) +
        scale_x_continuous(limits=c(0,3),  breaks = seq(0,3, by=0.5))+

        #lines "#E58700"
        # ur
        geom_segment( aes(x = 0, y = 0, xend = Ur_eff, yend = 0 ), color=Tcolor,   linetype="solid", arrow = arrow(length = unit(0.5, "cm")), size = 1.3819)+
        annotate(geom="text", x=Ur_eff-0.23, y=0.05, label="UR_eff", color=Tcolor, size=6.18) +

        # urs
        geom_segment( aes(x = Ur_eff, y = 0, xend = Ur_eff+Urs_eff, yend = 0 ), color=Rcolor,   linetype="solid", arrow = arrow(length = unit(0.5, "cm")), size = 1.3819)+
        annotate(geom="text", x=Ur_eff+Urs_eff+0.27, y=0, label="URs_eff", color=Rcolor, size=6.18)+

        #ull
        geom_segment( aes(x = Ur_eff+Urs_eff, y = 0, xend = Ur_eff+Urs_eff+cos(phi)*Ull_eff, yend = sin(phi)*Ull_eff ), color=Lcolor,   linetype="solid", arrow = arrow(length = unit(0.5, "cm")), size = 1.3819)+
        annotate(geom="text", x=Ur_eff+Urs_eff+0.4, y=1.1, label="UL*_eff", color=Lcolor, size=6.18) +

        #ul
        geom_segment( aes(x = Ur_eff, y = 0, xend = Ur_eff+Urs_eff+cos(phi)*Ull_eff, yend = sin(phi)*Ull_eff ), color=ULColor,   linetype="solid", arrow = arrow(length = unit(0.5, "cm")), size = 1.3819)+
        annotate(geom="text", x=Ur_eff+Urs_eff, y=1.175, label="UL_eff", color=ULColor, size=6.18) +

        #uges
        geom_segment( aes(x = 0, y = 0, xend = Ur_eff+Urs_eff+cos(phi)*Ull_eff, yend = sin(phi)*Ull_eff ), color=UgesColor,   linetype="solid", arrow = arrow(length = unit(0.5, "cm")), size = 1.3819)+
        annotate(geom="text", x=Ur_eff+Urs_eff-0.34, y=1.05, label="Uges_eff", color=UgesColor, size=6.18) +

        #OK
        geom_segment( aes(x = Ur_eff+Urs_eff+cos(phi)*Ull_eff, y = 0, xend = Ur_eff+Urs_eff+cos(phi)*Ull_eff, yend = 1.5), color=OKcolor,   linetype="dashed", size = 1.3819)+

        geom_segment( aes(x = Ur_eff+Urs_eff+cos(phi)*Ull_eff+0.125, y = 0.333 + 0.25, xend = Ur_eff+Urs_eff+cos(phi)*Ull_eff+0.125, yend = 0.5 + .25), color=OKcolor,   arrow = arrow(length = unit(0.5, "cm")), linetype="solid", size = 1)+
        annotate(geom="text", x=Ur_eff+Urs_eff+cos(phi)*Ull_eff+0.125 + 0.075, y=0.333 + 0.25 + 0.075, label="f", color=OKcolor, size=6.18)

p9
