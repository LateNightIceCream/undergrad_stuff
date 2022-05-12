library(ggplot2)

outputName = "2_3_widerstand.pdf"
outputWidth = 10
outputHeight = outputWidth * 0.618

#diodeDataFB <- read.csv("durchlassrichtung.csv")
diodeDataRB <- read.csv("sperrrichtung.csv")

xlabel <- "U / V"
ylabel <- "I / mA"

ylimimits <- c(min(diodeDataRB$I), 50*0.618)

U1 <- diodeDataRB$U[length(diodeDataRB$U)-1]
I1 <- diodeDataRB$I[length(diodeDataRB$I)-1]
I2 <- diodeDataRB$I[length(diodeDataRB$I)]
U2 <- diodeDataRB$U[length(diodeDataRB$U)]

gz <- (I2-I1)/(U2-U1)
n  <- I2 - U2 * gz

I_linear <- function(U) {
    gz * U + n
}

                                        #
hsBlue <- "#00b1db"
hsInvert <- "#ff5d02"
uzgreen <- "#59B574"

point <- data.frame(x = -5.616, y=0)

plot <- ggplot( data= diodeDataRB, aes(x = U, y = I)) +
    theme_minimal() +
    xlab(xlabel) +
    ylab(ylabel) +
    geom_point(color=hsInvert)+
    scale_y_continuous(limits=ylimimits)+
    stat_function(fun = I_linear, color = hsBlue, n=5000)+
    annotate("text", x = -5.75, y = 4, label=bquote("U"["Z"]), color = uzgreen)+
    geom_point(data = point, aes(x = x, y=y), col = uzgreen)

pdf(outputName, width = outputWidth, height = outputHeight)
plot

