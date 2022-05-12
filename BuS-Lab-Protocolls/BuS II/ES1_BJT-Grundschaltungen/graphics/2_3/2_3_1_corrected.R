library(ggplot2)

width <- 10
height <- 0.618 * width

pdfName <- "2_3_1_corrected.pdf"


R3 <- 1.3 # collector resistance
R <- c(100, 33.33, 9.09, 0.99)

R <- (R * R3) / (R+R3)

V <- c(162.5, 159.1, 144.9, 73.22)


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

p <- ggplot(data = dat, aes(x = R, y=V)) +
    theme_minimal() +
    xlab(xlab)+
    ylab(ylab)+
    geom_smooth(method = "lm", se=FALSE, color=curveColor, size=0.618) +
    geom_point(color=pointColor, size=2)

pdf(pdfName, width, height)
p
