library(ggplot2)

outputName <- "1_1_u1.pdf"
pdfWidth <- 10
pdfHeight <- 0.61803399 * pdfWidth

f1 <- 500
f2 <- 4000

numOfPeriods <- 3

U0 <- 0.6
U1 <- 1
U2 <- 1

xlims <- c(-1/f1 * numOfPeriods/2, 1/f1 * numOfPeriods/2)
#ylims <- c(-U1, (U1+U0))
ylims <- c(-U1*1.618, (U1+U0)*1.382)

xlabel <- bquote("t / ms")
ylabel <- bquote("U / V")

xbreaks <- seq(min(xlims),max(xlims), by = abs(min(xlims)/2))
xlabels <- xbreaks * 1000

u1 <- function(t) {
    U0 + U1*cos(2*pi*f1*t)
}
u2 <- function(t) {
    U2*cos(2*pi*f2*t)
}

u3 <- function(t) {
    u1(t) * u2(t)
}

hsBlue  <- "#00b1db"
u2color <- "#00b1db80"
grey    <- "#b3b3b360"

plot <- ggplot(data.frame(x=c(0,2)), aes(x=x)) +
    theme_minimal() +
    xlab(xlabel) +
    ylab(ylabel) +
    scale_x_continuous(limits=xlims, breaks=xbreaks, label=xlabels) +
    scale_y_continuous(limits=ylims) +
    stat_function(fun = u1, color = hsBlue, n = 2000) +
    stat_function(fun = u2, color = u2color, n = 10000) +
    annotate("text", x = 0.00275, y = -1.2, label=bquote("u"[2]~"(t)"), color=grey)+
annotate("text", x = 0.00175, y = 1.68, label=bquote("u"[1]~"(t)"), color=grey)
#    stat_function(fun = u1, color = grey, n = 2000, linetype = "dashed")+
#    stat_function(fun = u3, color = hsBlue, n = 10000)


pdf(file = outputName, width = pdfWidth, height = pdfHeight)
plot
