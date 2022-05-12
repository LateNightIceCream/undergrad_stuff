library(ggplot2)

outputName <- "u3.pdf"
pdfWidth   <- 10
pdfHeight  <- pdfWidth * 0.618


# squarewave parameters
swAmplitude <- 1
tau         <- 100/100
T           <- 250/100

# u1(t) parameters
U1        <- 1
T1        <- 2000 / 100
U0        <- 0


xlim <- c(-25, 25)
ylim <- c(-U1*1.2361, U1*1.382)

xbreaks <- seq(min(xlim), max(xlim), by = 5)
xlabels <- xbreaks/10

xlabel <- "t / ms"
ylabel <- "x(t) / V"

u1color   <- "#00b1db"
fun_color <- "#00b1db80"

u1 <- function(t) {
    U0 + U1*cos(2*pi*1/T1*t)
}

# easy squarewave!
carrier <- function(t) {

    ifelse(( ( (t + tau/2) %% T) < tau), 1,0)

}


u3 <- function(t) {

    u1(t) * carrier(t)

}

plot <- ggplot(data.frame(x=c(0,2)), aes(x=x)) +
    theme_minimal() +
    scale_x_continuous(limits = xlim, breaks = xbreaks, labels = xlabels ) +
    scale_y_continuous(limits = ylim ) +
    xlab(xlabel) +
    ylab(ylabel) +
#   stat_function( n = 4000, fun = u1, color=u1color )+
#    stat_function( n = 4000, fun = carrier, color=fun_color )
    stat_function( n = 4000, fun = u3, color=u1color )

# complicated squarewave!
## for(n in min(xlim):max(xlim)) {

##     xleft <- n * T - tau/2

##     plot <- plot +
##         geom_segment( x = xleft, y=0, xend = xleft, yend = swAmplitude, color = fun_color) +
##         geom_segment( x = xleft+tau, y=0, xend = xleft+tau, yend = swAmplitude, color = fun_color) +
##         geom_segment( x = xleft, y=swAmplitude, xend = xleft+tau, yend = swAmplitude, color = fun_color) +
##     geom_segment( x = xleft+tau, y=0, xend = xleft+T, yend = 0, color = fun_color)


## }

pdf(outputName, pdfWidth, pdfHeight)
plot
