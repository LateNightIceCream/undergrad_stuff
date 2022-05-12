library(ggplot2)

outputName <- "1_2_Abtast_Rechteck_ZB.pdf"
pdfWidth   <- 10
pdfHeight  <- pdfWidth * 0.618


# squarewave params
T_square = 1/8 * 10^-3 # my favourite Band!!
tau      = 15 * 10^-6

# u1
f1       = 1000

square <- function(t) {
    ifelse(( ( (t + tau/2) %% T_square) < tau), 1,0)
}

u1 <- function(t) {
    cos(2*pi*f1*t)
}

sampled <- function(t) {
    square(t) * u1(t)
}

# plot
#---------------------------------------------
hsBlue  <- "#00b1db"
hsBlueA <- "#00b1db0F"

xlabel <- "t / ms"
ylabel <- bquote("u"[2]~"(t) / V")

xlimits <- c(0, 1/f1*2)
xbreaks <- seq(0, 2*1/f1, 1/f1 / 2)
xlabels <- xbreaks*1000 # to get ms

p <- ggplot(data.frame(x=c(0,2)), aes(x=x)) +
    theme_minimal() +
##    ggtitle(bquote("f"["a"]~"= 10 kHz")) +
    theme(plot.title = element_text(colour = "#ced4da") ) +
    xlab(xlabel) +
    ylab(ylabel) +
    scale_x_continuous(limits = xlimits, breaks=xbreaks, labels=xlabels) +
    stat_function( fun = square, n = 4000, linetype=1, color = hsBlueA) +
    stat_function( fun = u1, n = 4000, linetype=1, color = hsBlueA) +
    stat_function( fun = sampled, n = 4000, linetype=1, color = hsBlue)

pdf(outputName, pdfWidth, pdfHeight)
p
