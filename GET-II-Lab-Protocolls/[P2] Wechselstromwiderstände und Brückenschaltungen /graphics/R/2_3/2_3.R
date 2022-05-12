# RL Hochpassfilter
library(ggplot2)

options(scipen=10000)

output_width  <- 10
output_height <- output_width * 0.6180339887498948

ylabel <- bquote("U / V")
xlabel <- bquote( "f / kHz")

xbreaks <- c(1,200,400,600,800,1000,1200,1400,1600,1800,2000)
ybreaks <- c(0, 0.3, 0.5, 0.75, 1, 1.5)

ieff <- 0.0015
r    <- 200
L    <- 0.06

uges<- function(f) {ieff * sqrt(r^2 + (4*pi^2*f^2 * L^2)) }
ur  <- function(f) {ieff * r}
ul  <- function(f) {ieff * (2*pi*f*L)}

pdf("2_3.pdf", width = output_width, height = output_height)


####################################################################

p9 <- ggplot(data.frame(x = c(1, 2000)), aes(x = x))+

        theme_minimal() +

        ggtitle(bquote("L = 60 mH")) +

        stat_function(fun = uges, colour = "#F8766F")+
        stat_function(fun = ur, colour   = "#00C0AF")+
        stat_function(fun = ul, colour   = "#619CFF")+
        #scale_colour_manual("Function", values=c("blue","red"), breaks=c(uges_legend,"exp"))+

        theme(axis.title.y = element_text(angle = 0, vjust = .5)) +

        xlab(xlabel)  +
        ylab(ylabel)  +

        scale_y_continuous(limits=c(0, 1.75), breaks = ybreaks, labels = ybreaks) +

        scale_x_continuous(breaks = xbreaks, limits=c(1, 2000), labels = xbreaks/1000 )+

        annotate(geom="text", x=1000, y=0.75,  label=bquote("Uges"),  color="#F8766D",  size=4*1.618) +
        annotate(geom="text", x=1300, y=0.62, label=bquote("UL"),    color="#619CFF",  size=6.18) +
        annotate(geom="text", x=1800, y=0.22,  label=bquote("UR"),   color="#00C0AF",  size=6.18)

p9
