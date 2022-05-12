library(ggplot2)

width <- 10
height <- 0.618 * width

pdfName <- "2_5_1.pdf"


R3 <- 10000000000 # collector resistance
R <- c(100, 33.33, 9.09, 0.99)

#R <- (R * R3) / (R+R3)

V <- c(0.9973, 0.9745, 0.9726, 0.918)


sum(V/R)/length(V)

dat <- data.frame(R, V)

attach(dat)
#model <- lm(V~log(R))

#coef(model)

#Rs <- seq(from=0, to=100, length.out = 1000)
#Vs <- predict(model, newdata = data.frame(R=Rs))


#predictdata <- data.frame(Rs, Vs)

pointColor <- "#ff6b6b"
curveColor <- "#ced4da7F"

xlab <- bquote("R"["L mit R3"]~" / k"~Omega)
ylab <- bquote("V"["u"])

ylim <- c(0, 1.5)

p <- ggplot(data = dat, aes(x = R, y=V)) +
    theme_minimal() +
    xlab(xlab)+
    ylab(ylab)+
    scale_y_continuous(limits=ylim) +
    geom_smooth(method = "lm", se=FALSE, color=curveColor, size=0.618) +
    geom_point(color=pointColor, size=2)

pdf(pdfName, width, height)
p
