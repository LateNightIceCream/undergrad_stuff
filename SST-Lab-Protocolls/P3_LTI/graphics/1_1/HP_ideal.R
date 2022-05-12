library(ggplot2)

outputName <- "HP_ideal.pdf"
pdfWidth   <- 10
pdfHeight  <- pdfWidth * 0.618

xlimits <- c(-4,4)
ylimits <- c(0, 1.382)

xbreaks <- seq(-4,4,1)
xlabels <- c("","",bquote("-"~omega[g]),"",0,"",bquote(omega[g]),"","")

ybreaks <- c(0.5, 1)
ylabels <- c("","1")

hsBlue <- "#00b1db"

p <- ggplot(data.frame(x=c(0,2)), aes(x=x)) +
  theme_minimal() +
  
  theme(legend.position="none", plot.title = element_text(color = "gray21", size=1.382^8), plot.subtitle = element_text(color = "grey80", size=1.6180339887498948^5)) +
  ggtitle(bquote("Amplitudenfrequenzgang: Idealer Hochpass")) +
  
  xlab(bquote(omega)) +
  ylab(bquote("|G(j" ~ omega ~ ")|")) +
  
  scale_x_continuous(limits = xlimits, breaks = xbreaks, labels=xlabels) +
  scale_y_continuous(limits = ylimits, breaks = ybreaks, labels=ylabels) +
  geom_segment( x = -2, y=0, xend=-2, yend=1, color=hsBlue ) +
  geom_segment( x = 2, y=0, xend=2, yend=1, color=hsBlue ) +
  geom_segment( x = 2, y=1, xend=4, yend=1, color=hsBlue ) +
  geom_segment( x = -2, y=1, xend=-4, yend=1, color=hsBlue ) +
  geom_segment( x = -2, y=0, xend=2, yend=0, color=hsBlue )

pdf(outputName, pdfWidth, pdfHeight)
p
