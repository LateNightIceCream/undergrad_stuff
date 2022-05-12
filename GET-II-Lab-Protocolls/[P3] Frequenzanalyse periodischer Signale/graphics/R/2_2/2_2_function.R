# square wave plot

library(ggplot2)

options(scipen=10000)

epsilon <- 50 * 10^(-6)
Xm      <- 1
D       <- 0.5
T1      <- 25 * 10^(-6)
tau     <- D * T1


output_width  <- 10
output_height <- output_width * 0.6180339887498948

ylabel <- bquote( "x" )
xlabel <- bquote( "t" )


xbreaks <- c(0, -T1/2, T1/2, -T1, T1)
xlabels <- c(0, bquote("-"~over("T"[1], 2)), bquote(over("T"[1], 2)), bquote(over("-"~"T"[0], 2)), bquote(over("T"[0], 2)))

fun <- function(t) {

  abs(Xm*cos(pi/T1*t))

}

function_color <- "#0CB5DF"
indie_wave_color <- "#0CB5DF22"

#df <- data.frame(x=xsteps, y=wave1)
####################################################################

p <- ggplot(data.frame(x=c(0,2), y=c(0,2)), aes(x=x)) +

        theme_minimal() + # maybe theme_bw()
        theme(legend.position="none", plot.title = element_text(color = "gray21", size=1.6180339887498948^5), plot.subtitle = element_text(color = "grey80", size=1.6180339887498948^5)) +
        ggtitle(bquote("x(t)")) +

        stat_function(fun = fun, colour   = function_color, n=2000)+


        theme(text = element_text(size=16.180339887498948), axis.title.y = element_text(angle = 0, vjust = .5), panel.grid.minor.x = element_blank()) + # rotate axis title

        xlab(xlabel) +
        ylab("")  +

        scale_y_continuous(limits=c(-0.145898034, 1.6180339887498948), breaks=c(0,Xm, 1.6180339887498948), labels=c(0, bquote("X"["m"]), "")) +
        scale_x_continuous(limits=c(-epsilon, epsilon), breaks=xbreaks, labels=xlabels)
        #scale_x_discrete(limits=1, breaks=c(1,2,3)) #labels=c(0, bquote("-"~over("T1",2)), bquote(over(-tau,2)), bquote(over(-tau,2)), bquote(over(tau,2))) )


pdf("2_2_function.pdf", width = output_width, height = output_height, )
p
