# square wave plot

library(ggplot2)

options(scipen=10000)

Xm      <- 1
D       <- 0.25
T1      <- 1
epsilon <- 2 * T1
tau     <- D * T1

a0 <- 4 * Xm * (D - 0.5)

m <- 15

amplifun <- function(n) {

    4 * Xm / (n*pi) * sin(n * pi * D)

}

# hardcoded bc i dont have time, i sometimes hate R
# very hackish and ugly but does the job :D


wave1 <- function(t) {
  amplifun(1) * cos(2*pi/T1*t)
}
wave2 <- function(t) {
  amplifun(2)* cos( 2 * 2 * pi / T1 * t  )
}
wave3 <- function(t) {
  amplifun(3) * cos(3*2*pi/T1*t )
}
wave4 <- function(t) {
  amplifun(4) * cos(4*2*pi/T1*t )
}
wave5 <- function(t) {
  amplifun(5) * cos(5*2*pi/T1*t )
}
wave6 <- function(t) {
 amplifun(6) * cos(6*2*pi/T1*t )
}
wave7 <- function(t) {
  amplifun(7) * cos(7*2*pi/T1*t)
}
wave8 <- function(t) {
 amplifun(8) * cos(8*2*pi/T1*t)
}
wave9 <- function(t) {
  amplifun(9) * cos(9*2*pi/T1*t )
}
wave10 <- function(t) {
  amplifun(10) * cos(10*2*pi/T1*t )
}
wave11 <- function(t) {
  amplifun(11) * cos(11*2*pi/T1*t)
}
wave12 <- function(t) {
  amplifun(12) * cos(12*2*pi/T1*t)
}
wave13 <- function(t) {
  amplifun(13) * cos(13*2*pi/T1*t)
}
wave14 <- function(t) {
  amplifun(14) * cos(14*2*pi/T1*t)
}
wave15 <- function(t) {
  amplifun(15) * cos(15*2*pi/T1*t)
}

totalwave <- function(t) {

    a0/2 + wave1(t) + wave2(t) + wave3(t)   + wave5(t) + wave6(t) + wave7(t) + wave9(t) + wave10(t) + wave11(t) + wave13(t) + wave14(t) + wave15(t) #+ wave4(t) + wave8(t) + wave12(t)

}


# this could be so easy but R decides not to make it easy :(
#for(n in 1:m) {

  #wavevector[n] <-  function(f) {

    #amplifun(n) * cos(n*2*pi/T1*t)

  #}
#}

output_width  <- 10
output_height <- output_width * 0.6180339887498948

ylabel <- bquote( "x" )
xlabel <- bquote( "t" )


xbreaks <- c(0, -tau/2, tau/2, -T1/2, T1/2, -T1, T1)
xlabels <- c(0, bquote("-"~over(tau, 2)), bquote(over(tau, 2)), bquote("-"~over("T", 2)), bquote(over("T", 2)), bquote("-T"), bquote("T"))

function_color <- "#0CB5DF"
indie_wave_color <- "#0CB5DF22"

#df <- data.frame(x=xsteps, y=wave1)
####################################################################

p <- ggplot(data.frame(x=c(0,2), y=c(0,2)), aes(x=x)) +

        theme_minimal() +
        theme(legend.position="none", plot.title = element_text(color = "gray21", size=1.6180339887498948^5), plot.subtitle = element_text(color = "grey80", size=1.6180339887498948^5)) +
        ggtitle(bquote("Reihenentwicklung von x(t) bis zur 16. Oberwelle")) +
        labs(subtitle="D=0.25")+

        stat_function(fun = wave1, colour   = indie_wave_color, n=2000)+
        stat_function(fun = wave2, colour   = indie_wave_color, n=2000)+
        stat_function(fun = wave3, colour   = indie_wave_color, n=2000)+
        stat_function(fun = wave4, colour   = indie_wave_color, n=2000)+
        stat_function(fun = wave5, colour   = indie_wave_color, n=2000)+
        stat_function(fun = wave6, colour   = indie_wave_color, n=2000)+
        stat_function(fun = wave7, colour   = indie_wave_color, n=2000)+
        stat_function(fun = wave8, colour   = indie_wave_color, n=2000)+
        stat_function(fun = wave9, colour   = indie_wave_color, n=2000)+
        stat_function(fun = wave10, colour  = indie_wave_color, n=2000)+
        stat_function(fun = wave11, colour  = indie_wave_color, n=2000)+
        stat_function(fun = wave12, colour  = indie_wave_color, n=2000)+
        stat_function(fun = wave13, colour  = indie_wave_color, n=2000)+
        stat_function(fun = wave14, colour  = indie_wave_color, n=2000)+
        stat_function(fun = wave15, colour  = indie_wave_color, n=2000)+
         stat_function(fun = totalwave, colour  = function_color, n=2000)+

        theme(text = element_text(size=16.180339887498948), axis.title.y = element_text(angle = 0, vjust = .5), panel.grid.minor.x = element_blank()) + # rotate axis title

        xlab(xlabel) +
        ylab("")  +

        scale_y_continuous(limits=c(-1.618*Xm, 1.618*Xm), breaks=c(-Xm, 0,Xm), labels=c("-A", 0, "A")) +
        scale_x_continuous(limits=c(-epsilon, epsilon), breaks=xbreaks, labels=xlabels)


pdf("1_3_Reihe.pdf", width = output_width, height = output_height, )
p
