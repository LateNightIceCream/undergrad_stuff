library(ggplot2)

measurements <- read.csv("2_2.csv")

pdfWidth   <- 10
pdfHeight  <- pdfWidth * 0.618034

outputName <- "2_2_Eingangskennlinie.pdf"


xlims <- c(0, max(measurements$UBE))
ylims <- c(0, max(measurements$IB))

xlabel <- bquote("U"["BE"]~" / V")
ylabel <- bquote("I"["B"]~" / µA")

exp.model <- lm(log(IB) ~ UBE, data = measurements)


 xvals <- seq(0.58, 0.65, 0.00001)
 yvals <- exp( predict(exp.model, data.frame(UBE=xvals)  ))

points <- data.frame(x = xvals, y = yvals)


point_color <- "#00B0F6"
fade_color <- "#00B0F62F"

plot <- ggplot(data = measurements, aes(y = IB, x = UBE)) +
    theme_minimal() +
    xlab(xlabel) +
    ylab(ylabel) +
    scale_x_continuous() +
    scale_y_continuous() +
    #geom_point(color = "gray60", data=points, aes(x = x, y=y)) +
    geom_line(color = "gray90", data=points, aes(x = x, y=y), size=1) +
    geom_point(color = point_color) +
    annotate("text", x = 0.6, y=7.5, label=bquote("@U"["CE"]~"=6V"), color=fade_color, size=5)

pdf(outputName, pdfWidth, pdfHeight)
plot
