library(ggplot2)

measurements <- read.csv("2_2.csv")

pdfWidth   <- 10
pdfHeight  <- pdfWidth * 0.618034

outputName <- "2_2_Stromübertragung.pdf"


xlims <- c(0, max(measurements$IC))
ylims <- c(0, max(measurements$IB))

ylabel <- bquote("I"["C"]~" / mA")
xlabel <- bquote("I"["B"]~" / µA")



point_color <- "#00C0AF"
fade_color <- "#00C0AF2F"



plot <- ggplot(data = measurements, aes(x = IB, y = IC)) +
    theme_minimal() +
    xlab(xlabel) +
    ylab(ylabel) +
    scale_x_continuous() +
    scale_y_continuous() +
    geom_smooth(se = FALSE, n = 2000, method = "lm", color = "grey90") +
    annotate("text", x = 2, y=2, label=bquote("@U"["CE"]~"=6V"), color=fade_color, size=5)+
    geom_point(color = point_color)

pdf(outputName, pdfWidth, pdfHeight)
plot
