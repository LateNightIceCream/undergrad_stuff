library(ggplot2)

outputName <- "Ausgangsspektrum.pdf"
pdfWidth   <- 10
pdfHeight  <- pdfWidth * 0.618

xlimits <- c(-4,4)
ylimits <- c(0, 1.382)

xbreaks <- seq(-4,4,1)
#xlabels <- c("","",bquote("-"~omega[g]),"",0,"",bquote(omega[g]),"","")
xlabels <- c("","",bquote("-2"~omega["0"]),bquote("-"~omega["0"]),0,bquote(omega["0"]),bquote("2"~omega["0"]),"","")

ybreaks <- c(0,0.25,0.5, 1)
ylabels <- c("0","1/2","1","2")

hsBlue <- "#00b1db"
color2 <- "#00b1db2F"
#cosColor <- "#db0058"
cosColor <- "#00b1db"

cosfreq1 <- 1
cosfreq2 <- 2

K1 <- 0.5

p <- ggplot(data.frame(x=c(0,2)), aes(x=x)) +
    theme_minimal() +

    theme(legend.position="none", plot.title = element_text(color = "gray21", size=1.382^8), plot.subtitle = element_text(color = "grey80", size=1.6180339887498948^5)) +
    ggtitle(bquote("Spektrum des Ausgangssignals u"["2"]~"(t)")) +

    xlab(bquote(omega)) +
    ylab(bquote("|U"["2"]~"(j" ~ omega ~ ")| /Vs")) +

    scale_x_continuous(limits = xlimits, breaks = xbreaks, labels=xlabels) +
    scale_y_continuous(limits = ylimits, breaks = ybreaks, labels=ylabels) +
  #geom_segment( x = -2, y=0, xend=-2, yend=1, color=hsBlue ) +
  #geom_segment( x = 2, y=0, xend=2, yend=1, color=hsBlue ) +
  #geom_segment( x = 2, y=1, xend=-2, yend=1, color=hsBlue ) +
  #geom_segment( x = -2, y=0, xend=-4, yend=0, color=hsBlue ) +
  #geom_segment( x = 2, y=0, xend=4, yend=0, color=hsBlue ) +

    geom_segment( x = cosfreq1, y=0, xend=cosfreq1, yend=K1/2, color=cosColor ) +
    geom_segment( x = -cosfreq1, y=0, xend=-cosfreq1, yend=K1/2, color=cosColor ) +
    geom_segment( x = cosfreq2, y=0, xend=cosfreq2, yend=K1/2, color=color2, linetype="dashed" ) +
    geom_segment( x = -cosfreq2, y=0, xend=-cosfreq2, yend=K1/2, color=color2, linetype="dashed") +
    geom_segment( x = 0, y=0, xend=0, yend=K1, color=cosColor )

pdf(outputName, pdfWidth, pdfHeight)
p
