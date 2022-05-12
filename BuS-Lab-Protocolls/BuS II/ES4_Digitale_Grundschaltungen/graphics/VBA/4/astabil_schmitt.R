library(ggplot2)

width  <- 10
height <- 0.618*width

outputName <- "graph.pdf"


RC <- 0.001

Us <- 2

trig_threshold_low  <- 1/1.6*Us
trig_threshold_high <- 3/4*Us

c_curve_charging <- function(t) {

    Us * (1 - exp(-t/RC))

}

c_curve_discharging <- function(t) {

   Us - c_curve_charging(t)
    # = Us*exp(-t/RC)

}

c_curve_test <- function(t, u_start=0) {

    t_start <- log(Us/u_start)*RC

    c_curve_discharging(t-t_start)

}

charging <- 1;
c_curve_with_trigger <- function(t) {


    compval <- c_curve_charging(t)

    retval <- ifelse(
        compval > trig_threshold_low,

        c_curve_discharging(t),

        c_curve_charging(t)

    )


    return(retval)

}

schmitt_trigger <- function(t) {


#    if(c_curve_charging(t) == ) {
#
#    }

}

p <- ggplot(data.frame(x=c(0, 6*RC)), aes(x)) +
    theme_minimal() +
    stat_function(fun=c_curve_charging, n=4000, color="green") +
    stat_function(fun=c_curve_discharging, n=4000)+
    stat_function(fun=c_curve_with_trigger, color="red", n=10000)+
    stat_function(fun=c_curve_test, color="pink", n=4000)


pdf(outputName, width, height)
p
