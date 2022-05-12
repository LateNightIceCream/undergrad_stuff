library(ggplot2)

outputName <- "1_1_spektrum.pdf"
pdfWidth <- 10
pdfHeight <- 0.61803399 * pdfWidth

f1 <- 500
f2 <- 4000

numOfPeriods <- 3

U0 <- 0.6
U1 <- 1
U2 <- 1

p1 <- U0*U2/2
p2 <- U1*U2/4

xlims <- c(-(f1+f2)*1.382, (f1+f2)*1.382)
ylims <- c(0, p1*1.382)

xlabel <- bquote("f / kHz")
ylabel <- bquote("U"[3]~"(f)")

xbreaks <- c(-(f1+f2), -(f2), -(f2-f1), 0, f2-f1, f2, f2+f1)
xlabels <- xbreaks/1000

hsBlue  <- "#00b1db"
u2color <- "#00b1db80"
grey    <- "#b3b3b360"

plot <- ggplot(data.frame(x=c(0,2)), aes(x=x)) +
    theme_minimal() +
    xlab(xlabel) +
    ylab(ylabel) +
    scale_x_continuous(limits=xlims, breaks=xbreaks, label=xlabels) +
    scale_y_continuous(limits=ylims)+
        geom_segment(aes(x=-(f1+f2), y=0, xend=-(f1+f2), yend=p2), color = hsBlue, size=2) +
        geom_segment(aes(x=-(f1-f2), y=0, xend=-(f1-f2), yend=p2), color = hsBlue, size=2)+
        geom_segment(aes(x=-(f2), y=0, xend=-(f2), yend=p1), color = hsBlue, size=2)



for(i in c(-1,1)) { # not working? with c(-1,1)

    plot <- plot +
        geom_segment(aes(x=i*(f1+f2), y=0, xend=i*(f1+f2), yend=p2), color = hsBlue, size=2) +
    geom_segment(aes(x=i*(f1-f2), y=0, xend=i*(f1-f2), yend=p2), color = hsBlue, size=2)+
        geom_segment(aes(x=i*(f2), y=0, xend=i*(f2), yend=p1), color = hsBlue, size=2)

}



pdf(file = outputName, width = pdfWidth, height = pdfHeight)
plot
