library(ggplot2)

width  <- 10
height <- 0.618 * width

outputName <- "SN7400_Ausgangskennlinie_high.pdf"

data <- read.csv("daten_aus_high.csv")

data$iahigh <- -data$iahigh

model <- lm(uahigh~iahigh, data=data)



summary(model)

modelFun <- function(i) {

    -0.096639 * i + 3.692579

}


ylabel <- bquote("U"["a,HIGH"~"/ V"])
xlabel <- bquote("-I"["a,HIGH"]~"/ mA")
ylims   <- c(0, 5)

pointcolor <- "#495057" # gray7
curvecolor <- "#ced4da7f" # gray4
linecolor  <- "#74c0fc0f"

p <- ggplot(data = data, aes(x = iahigh, y=uahigh)) +
    theme_minimal() +
    scale_y_continuous(limits = ylims) +
    ylab( ylabel ) +
    xlab( xlabel ) +

    theme(text = element_text(size=16)) +

    geom_segment( aes(x = 0, y=2.4, xend = 30, yend=2.4), color = linecolor, linetype=2 ) +

    stat_function(fun = modelFun, color=curvecolor, n=4000) +
    geom_point( color=pointcolor )

pdf(outputName, width, height)
p
