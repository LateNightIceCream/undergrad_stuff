library(ggplot2)

outputName <- "1_2_dirac_convolution_8kHz.pdf"
pdfWidth   <- 10
pdfHeight  <- pdfWidth * 0.618


# signal parameters

cos_freq = 1000
signal_frequencies <- c(-cos_freq, cos_freq)
signal_amplitudes  <- c(1, 1)

signal <- data.frame(f = signal_frequencies, a = signal_amplitudes)


# dirac parameters

# number of diracs to display/2 (symmetrical around y axis)
num_of_diracs <- 3
sampling_frequency <- 8000

dirac_frequencies <- c()
dirac_amplitudes  <- c()

# Si amplitudes
#U2 <- 1
#T  <- 1/sampling_frequency
#tau <- 15 * 10^-6

#amplitudes <- function(n) {

#if(n == 0) { return( 2*U2 * tau/T ) }

# p <- abs( 2*U2 * tau/T * sin(pi * n * tau/T) / (n * pi * tau/T))

# print(p)

#}

for(i in (-num_of_diracs:num_of_diracs)) {

    dirac_frequencies <- c(dirac_frequencies, i*sampling_frequency)


    amp_value <- sampling_frequency
#    amp_value  <- amplitudes(i)
    dirac_amplitudes  <- c(dirac_amplitudes, amp_value)

}

dirac <- data.frame(f = dirac_frequencies, a = dirac_amplitudes)

# convolution / shifting

conv_frequencies <- c()
conv_amplitudes  <- c()

for(i in (-num_of_diracs:num_of_diracs)) { # diracs

    for(n in (1:length(signal$f))) { # signal

        conv_frequencies <- c(conv_frequencies, dirac$f[i] + signal$f[n] )

        conv_amplitudes  <- c(conv_amplitudes,  dirac$a[i] * signal$a[n] )

    }

}

conv <- data.frame(f = conv_frequencies, a = conv_amplitudes)


# plot
#---------------------------------------------
hsBlue  <- "#00b1db"
hsBlueA <- "#00b1db2F"

xlabel <- "f / kHz"
ylabel <- bquote("U"[2]~"(f)")
ybreaks <- seq(0, max(conv$a), sampling_frequency)

ylabels <- c(0, bquote("1/T"[a]))
#ylabels <- ybreaks

xlimits <- c(min(conv$f), max(conv$f))
xbreaks <- seq(min(min(dirac$f)), max(dirac$f), sampling_frequency)
xlabels <- xbreaks/1000 # to get kHz

ylimits <- c(0, sampling_frequency * 1.382)

p <- ggplot(data.frame(x=c(0,2)), aes(x=x)) +
    theme_minimal() +
#    ggtitle(bquote("f"["a"]~"= 10 kHz")) +
    theme(plot.title = element_text(colour = "#ced4da") ) +
    xlab(xlabel) +
    ylab(ylabel) +
    scale_y_continuous(limits = ylimits, breaks = ybreaks, labels=ylabels) +
    scale_x_continuous(limits = xlimits, breaks = xbreaks, labels=xlabels)
#    stat_function( fun = fun, n = 4000, linetype=2, color = hsBlueA) +
#    geom_point(color=hsBlue)

linewidth <- 1

for(i in 1:length(conv$f)) {

    p <- p + geom_segment(

                       x    = conv$f[i],
                       y    = 0,
                       xend = conv$f[i],
                       yend = conv$a[i],

                       color = hsBlue,
                       linetype = "solid", size = linewidth

                   )



}


pdf(outputName, pdfWidth, pdfHeight)
p
