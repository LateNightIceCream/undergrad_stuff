# RL Hochpassfilter
library(ggplot2)

options(scipen=10000)

output_width  <- 10
output_height <- output_width * 0.6180339887498948

ylabel <- bquote("U / V")
xlabel <- bquote( "f / kHz")

xbreaks <- c(300, 1000, 2000, 4000, 6000, 8000, 10000)

ieff <- 0.0015
r    <- 200
c1   <- 0.5 * 10^(-6)
c2   <- 1   * 10^(-6)

uges<- function(f) {ieff * sqrt(r^2 + 1/(4*pi^2*f^2 * c2^2))}
ur  <- function(f) {ieff * r}
uc  <- function(f) {ieff * 1/(2*pi*f*c2)}

pdf("2_4_2.pdf", width = output_width, height = output_height)


####################################################################

p9 <- ggplot(data.frame(x = c(300, 10000)), aes(x = x))+

        theme_minimal() + 

        ggtitle(bquote("C = 1"~mu~"F") ) +

        stat_function(fun = uges, colour = "#F8766F")+
        stat_function(fun = ur, colour   = "#00C0AF")+
        stat_function(fun = uc, colour   = "#619CFF")+
        #scale_colour_manual("Function", values=c("blue","red"), breaks=c(uges_legend,"exp"))+

        theme(axis.title.y = element_text(angle = 0, vjust = .5)) +


        xlab(xlabel)  +
        ylab(ylabel)  +

        scale_y_continuous(limits=c(0, 1.75), breaks = c(0,0.5,1,1.5,2,0.3), labels = c(0,0.5,1,1.5,2,0.3)) +

        scale_x_continuous(breaks = xbreaks, limits=c(300, 10000), labels = xbreaks/1000 )+

        annotate(geom="text", x=2000, y=0.4,  label=bquote("Uges"),  color="#F8766D",  size=4*1.618) +
        annotate(geom="text", x=5000, y=0.1, label=bquote("UC2"),   color="#619CFF",  size=6.18) +
        annotate(geom="text", x=9000, y=0.22,  label=bquote("UR"),    color="#00C0AF",  size=6.18)

p9
