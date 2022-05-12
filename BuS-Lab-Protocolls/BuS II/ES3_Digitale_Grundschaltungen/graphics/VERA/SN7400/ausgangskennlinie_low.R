library(ggplot2)

width  <- 10
height <- 0.618 * width

outputName <- "SN7400_Ausgangskennlinie_low.pdf"

data <- read.csv("daten_aus_low.csv")
data$ualow <- data$ualow * 1000 # convert to mV

model <- lm(ualow~ialow, data=data)

summary(model)

modelFun <- function(i) {

    7.745 * i + 64.3882

}


ylabel <- bquote("U"["a,LOW"~"/ mV"])
xlabel <- bquote("I"["a,LOW"]~"/ mA")

ylims   <- c(0, 200)

pointcolor <- "#495057" # gray7
curvecolor <- "#ced4da7f" # gray4
linecolor  <- "#f06595"

p <- ggplot(data = data, aes(x = ialow, y=ualow)) +
    theme_minimal() +
    scale_y_continuous(limits = ylims) +
    ylab( ylabel ) +
    xlab( xlabel ) +

    theme(text = element_text(size=16)) +

    geom_segment( aes(x = 0, y = 400, xend = 20, yend=400), color=linecolor ) +

    geom_point( color=pointcolor ) +
    stat_function(fun = modelFun, color=curvecolor, n=4000)

pdf(outputName, width, height)
p
