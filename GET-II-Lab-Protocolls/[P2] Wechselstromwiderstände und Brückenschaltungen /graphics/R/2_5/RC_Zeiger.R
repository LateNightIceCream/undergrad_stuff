#Komplexe Zeiger von R, L, C

library(ggplot2)

options(scipen=10000)

output_width  <- 10
output_height <- output_width


ylabel <- "Im"
xlabel <- "Re"

Rpos <- 0.75

Rcolor <- "#00BF7D"
Lcolor <- "#FF67A4"
Tcolor <- "#00BCD8"

pdf("RC_Zeiger.pdf", width = output_width, height = output_height)

####################################################################

p9 <- ggplot(data.frame(x=c(0, 2),y=c(0,2)), aes(x,y)) +

        theme_minimal() + # maybe theme_bw()

        ggtitle("Zeigerbild der Impedanz einer verlustbehafteten Kapazität / Kondensator im Serienmodell") +

        theme(axis.title.y = element_text(angle = 0, vjust = 0.5, size=16.18), axis.text.y = element_text(size = 13.82, color = c("grey60", Lcolor) )) + # rotate axis title
        theme(axis.title.x = element_text(angle = 0, hjust = 0.5, size=16.18), axis.text.x = element_text(size = 13.82, color = c("grey60", Rcolor))) +

        xlab(xlabel)  +
        ylab(ylabel)  +

        scale_y_continuous(limits=c(-1.382, 0),  breaks = c(0,-1), labels=c( 0, bquote("-"~over(1,omega ~ "C"["s"])) ) ) +
        scale_x_continuous(limits=c(0, 1.382),  breaks = c(0,Rpos), labels=c(0, bquote("R"["sC"])), position="top")+

        #lines "#E58700"
        # L
        geom_segment( aes(x = 0,    y = -1, xend   = Rpos, yend = -1 ), color=Lcolor,   linetype="dashed", size = 1.618)+
        # R
        geom_segment( aes(x = Rpos, y = -1, xend = Rpos,    yend = 0 ), color=Rcolor,   linetype="dashed", size = 1.618) +
        # total
        geom_segment( aes(x = 0,    y = 0, xend    = Rpos, yend = -1 ), color=Tcolor,   linetype="solid", arrow = arrow(length = unit(0.5, "cm")), size = 1.618)

        #annotate(geom="text", x=Rpos+0.05, y=1.05, label=bquote(underline("Z")), color=Tcolor, size=6.18)

p9
