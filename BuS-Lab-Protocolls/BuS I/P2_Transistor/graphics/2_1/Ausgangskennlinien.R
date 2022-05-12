library(ggplot2)

IB_10 <- read.csv("IB_10.csv")
IB_20 <- read.csv("IB_20.csv")
IB_30 <- read.csv("IB_30.csv")


pdfWidth   <- 10
pdfHeight  <- pdfWidth * 0.618034

outputName <- "2_1_Ausgangskennlinie.pdf"


xlims <- c(0, max(IB_30$UCE))
ylims <- c(0, max(IB_30$IC))

ylabel <- "IC / mA"
xlabel <- bquote("U"["CE"]~" / V")

xbreaks <- seq(0, 12.5, by=1)

IB30_color      = "#F8766D"
IB30_color_fade = "#F8766D2F"
IB20_color      = "#00C0AF"
IB20_color_fade = "#00C0AF2F"
IB10_color      = "#00B0F6"
IB10_color_fade = "#00B0F62F"

plot <- ggplot(data = IB_30, aes(x = UCE, y=IC)) +
    theme_minimal() +
    scale_x_continuous(limits = xlims, breaks=xbreaks) +
    scale_y_continuous(limits = ylims) +
    xlab(xlabel) +
    ylab(ylabel) +
    geom_point(color = IB30_color) +
    geom_point(data = IB_20, color = IB20_color) +
    geom_point(data = IB_10, color = IB10_color) +
    geom_smooth(method=loess, formula = y ~ log(x), se=FALSE, color=IB30_color_fade,n=4000) +
    geom_smooth(data=IB_20, method=loess, formula = y ~ log(x), se=FALSE, color=IB20_color_fade, n=4000) +
    geom_smooth(data=IB_10, method=loess, formula = y ~ log(x), se=FALSE, color=IB10_color_fade, n=4000) +
    annotate("text", x=12, y = 13.5, label=bquote("I"["B"]~"=30µA"), color=IB30_color_fade) +
    annotate("text", x=12, y = max(IB_20$IC-1), label=bquote("I"["B"]~"=20µA"), color=IB20_color_fade) +
    annotate("text", x=12, y = max(IB_10$IC-1), label=bquote("I"["B"]~"=10µA"), color=IB10_color_fade) +
    geom_segment(aes(x = 1, y = 0, xend = 1, yend =14), linetype="dashed", color="grey90")


pdf(outputName, pdfWidth, pdfHeight)
plot
