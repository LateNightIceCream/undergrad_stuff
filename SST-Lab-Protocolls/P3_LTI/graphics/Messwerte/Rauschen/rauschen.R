library(ggplot2)


width <- 10
height <- width * 0.618

outputName <- "rauschleistung.pdf"

u1 <- 0.22499
p1 <- u1^2

rauschen.dat <- read.csv("rausch.csv")
rauschen.dat <- cbind(rauschen.dat, 10*log(rauschen.dat$p/p1))
rauschen.dat <- cbind(rauschen.dat, rauschen.dat$p/p1)

colnames(rauschen.dat)[4] <- "pdb"
colnames(rauschen.dat)[5] <- "pp1"

print(rauschen.dat)

hsBlue <- "#00b1db"
regColor <- "grey70"
textColor <- "grey90"

xlab <- bquote("f"["g"]~" /kHz")
ylab <- bquote("P"[2]~"/"~"P"[1])


xbreaks <- seq(0, 12500, 2500)
xlabels <- xbreaks/1000

labOffsetX <- 200

p <- ggplot(data=rauschen.dat, aes(x=fg, y=pp1)) +
    theme_minimal() +
    xlab(xlab) +
    ylab(ylab) +
    scale_x_continuous(breaks = xbreaks, labels = xlabels) +
    geom_smooth(se=FALSE, method="lm", formula = y~x, color=regColor, size=0.618) +
    geom_point( color=hsBlue) +
    annotate("text", x=rauschen.dat$fg[2]+labOffsetX, y=0.11, label="B3.4", color=textColor) +
    annotate("text", x=rauschen.dat$fg[1]+labOffsetX, y=0.451, label="B3.1", color=textColor) +
    annotate("text", x=rauschen.dat$fg[3]+labOffsetX, y=0.316, label="B3.3", color=textColor)


pdf(outputName, width, height)
p
