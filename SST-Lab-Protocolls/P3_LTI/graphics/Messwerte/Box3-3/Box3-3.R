# this is some messy code :D
library(ggplot2)
library(mosaic)
library(scales)


width <- 10
height <- width * 0.618

outputName <- "Box3-3.pdf"

box3_1.dat <- read.csv("Box3-3.csv")

attach(box3_1.dat)

#box3_1.model <- nls( u ~ k2*f^-2, start=list(k2=2))
modelFun <- udB ~ A+B*exp(K*f)
box3_1.model <- fitModel(modelFun, data=box3_1.dat, start=c(A=20*log10(100/1000), B=20, K=-0.00002))

#modelFun <- udB ~ A+B*exp(K*f)
#box3_1.model <- fitModel(modelFun, data=box3_1.dat, start=c(A=100, B=1, K=-0.00001))

#hypFun <- udB ~ J + K/(L+M*f)
hypFun <- u ~ K+L/(sqrt(1+(2*pi*M*f)^2 ))
hyp.model <- fitModel(hypFun, data=box3_1.dat, start=c(K=100, L=1000, M=0.00005))

hypFunDB <- udB ~ K+L/(sqrt(1+(2*pi*M*f)^2))
hypDB.model <- fitModel(hypFunDB, data=box3_1.dat, start=c(K=-20, L=25, M=0.00005))

#summary(box3_1.model)

max(f)
min(f)

max(u)
min(u)

fmax <- 10^6
deltaf <- 1000

fpoints <- seq(0,fmax,deltaf)

box3_1.dat


xbreaks <- 10^(0:10)
minor_breaks <- rep(1:9, 21)*(10^rep(0:10, each=9))

snacky <- function(f) {

    A <- 100
    B <- 1
    C <- 1
    D <- 0.00005
    #20*log10(100/1000) + 20*exp( -(0.00002)*f )
    A+1000/(sqrt(1+(2*pi*D*f)^2 ))

}
snackyDB <- function(f) {

    A <- -20
    B <- 25
    C <- 1
    D <- 0.00005

    A+B/(sqrt(1+(2*pi*D*f)^2 ))

}

fg <- 1700
hsBlue <- "grey70"
pointColor <- "#00b1db"
cutoffColor <- "#db0058"
cutoffPoint <- data.frame(fg = fg, db=-3)

ylabel <- bquote("U"[2]~"/U"[1]~" in dB")
xlabel <- "f in Hz"

p <- ggplot(data=box3_1.dat, aes(x=f, y=udB)) +
    theme_minimal() +
    ylab(ylabel) +
    xlab(xlabel) +
#geom_smooth(se=FALSE, method="auto", n=2000, color="red2") +
    scale_x_continuous( trans="log10",breaks = xbreaks, minor_breaks=minor_breaks, labels = trans_format("log10", math_format(10^.x))) +
#    geom_path(color = "blue4") +
#    stat_function(fun=snacky, n=4000)+
#    stat_function(fun=snackyDB, n=4000)+
    stat_function(fun=hypDB.model, n=4000, color=hsBlue) +
    geom_segment(x=0, y=-3, xend=log10(fg), yend=-3, linetype=2, color="grey95")+
    geom_segment(x=log10(fg), y=-25, xend=log10(fg), yend=-3, linetype=2, color="grey95")+
    geom_point(color=pointColor) +
    geom_point(data=cutoffPoint, aes(x=fg, y=db), color=cutoffColor)
#   stat_function(fun=hyp.model, n=4000, color="red")
#    stat_function(fun=box3_1.model, n=4000, color=hsBlue)


#for(i in 0:10^4) {

#    print(paste0(i,") ", hypDB.model(i)))

#}

pdf(outputName, width, height)
p
