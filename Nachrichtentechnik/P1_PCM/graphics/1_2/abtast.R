library(ggplot2)

outputName <- "1_2_Abtast_10kHz_ZB.pdf"
pdfWidth   <- 10
pdfHeight  <- pdfWidth * 0.618


f_sample <- 10000;
T_sample <- 1/f_sample

sampleTime <- 0.002 # seconds

fun <- function(t) {

    U1 <- 1
    f  <- 1000

    U1*cos(2*pi*f*t)
}

sampleValues <- c()
samplePoints <- c()

for(i in 0:(sampleTime * f_sample) ) {

    samplePoints <- c(samplePoints, i*T_sample)

    sampleValues <- c(sampleValues, fun( i*T_sample )  )
}

sample <- data.frame(samplePoints, sampleValues)

# plot
#---------------------------------------------
hsBlue  <- "#00b1db"
hsBlueA <- "#00b1db2F"

xlabel <- "t / ms"
ylabel <- bquote("u"[2]~"(t) / V")

xlimits <- c(min(samplePoints), max(samplePoints))
xbreaks <- seq(min(samplePoints), max(samplePoints), T_sample*2)
xlabels <- xbreaks*1000 # to get ms

p <- ggplot(sample, aes(x=samplePoints, y=sampleValues)) +
    theme_minimal() +
    ggtitle(bquote("f"["a"]~"= 10 kHz")) +
    theme(plot.title = element_text(colour = "#ced4da") ) +
    xlab(xlabel) +
    ylab(ylabel) +
    scale_x_continuous(limits = xlimits, breaks = xbreaks, labels=xlabels) +
    stat_function( fun = fun, n = 4000, linetype=2, color = hsBlueA) +
    geom_point(color=hsBlue)


pdf(outputName, pdfWidth, pdfHeight)
p
