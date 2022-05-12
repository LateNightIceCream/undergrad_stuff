# square wave plot

library(ggplot2)

options(scipen=10000)

epsilon <- 2 * 10^(-3)
T1      <- 1/1000
Xm <- 1


U0m <- 1
R1  <- 5000
R2  <- 10000
C   <- 100*10^(-9)

#U2m    <- U0m * R2 / (sqrt( (R1+R2)^2 + (2*pi/T1 * C * R1 * R2)^2 ))
U2m <- 0.433/2 * sqrt(2)
phase2 <- 0 - atan( (2*pi/T1 * C * R1 * R2) / (R1+R2) )

U2mgem <- 0.425/2 * sqrt(2)

print(U2m-U2mgem)

output_width  <- 10
output_height <- output_width * 0.6180339887498948

ylabel <- bquote( "" )
xlabel <- bquote( "t" )


xbreaks <- c(0, -T1/2, T1/2, -T1, T1)
xlabels <- c(0, bquote("-"~over("T"[1], 2)), bquote(over("T"[1], 2)), bquote(over("-"~"T"[0], 2)), bquote(over("T"[0], 2)))

fun <- function(t) {

  abs(Xm*cos(pi/T1*t))

}

fun2 <- function(t) {

  U2m * cos(2*pi/T1 * t + phase2) + 0.424

}

fun3 <- function(t) {

  U2mgem * cos(2*pi/T1 * t + phase2)+ 0.424

}

function_color <- "#0CB5DF"
indie_wave_color <- "#0CB5DF22"
second_wave_color <- "#FF000070"

#df <- data.frame(x=xsteps, y=wave1)
####################################################################

p <- ggplot(data.frame(x=c(0,2), y=c(0,2)), aes(x=x)) +

        theme_minimal() + # maybe theme_bw()
        theme(legend.position="none", plot.title = element_text(color = "gray21", size=1.6180339887498948^5), plot.subtitle = element_text(color = function_color, size=1.6180339887498948^5)) +
        ggtitle(bquote("U"[2]~"(t)")) +
        labs(subtitle="U"["2eff"]~"=425 mV")+

        stat_function(fun = fun, colour   = indie_wave_color, n=2000)+
        stat_function(fun = fun2, colour  = second_wave_color, n=2000)+
        stat_function(fun = fun3, colour  = function_color, n=2000)+


        theme(text = element_text(size=16.180339887498948), axis.title.y = element_text(angle = 0, vjust = .5), panel.grid.minor.x = element_blank()) + # rotate axis title

        xlab(xlabel) +
        ylab(ylabel)  +

        geom_segment(x = -epsilon, y= 0.424, xend= epsilon, yend=0.424, color=indie_wave_color, linetype="dashed") +

        scale_y_continuous(limits=c(-0.145898034, 1.6180339887498948), breaks=c(0,Xm, 1.6180339887498948), labels=c(0, bquote("1V"), "")) +
        scale_x_continuous(limits=c(-epsilon, epsilon), breaks=xbreaks, labels=xlabels)
        #scale_x_discrete(limits=1, breaks=c(1,2,3)) #labels=c(0, bquote("-"~over("T1",2)), bquote(over(-tau,2)), bquote(over(-tau,2)), bquote(over(tau,2))) )


pdf("3_3_function.pdf", width = output_width, height = output_height, )
p
