library(ggplot2)

outputName <- "2_1_4Q.pdf"

pdfWidth <- 10
pdfHeight <- pdfWidth

axisLabelSize <- 5
overshoot <- 1

Is <- 0.15 * 10^-6
UT <- 2.2 * 0.026

AN <- 0.9999
BN <- AN / (1-AN)
Ai <- 0.1
ICS<- Is
Uearly <- 75


Usat <- 0.2

IB1 <- 50 * 10^-6
IB2 <- 75 * 10^-6
IB3 <- 100 * 10^-6

IB_scale_factor <- 3.5 / (log(1/Is - 1) * UT)

diode_FB <- function(U) {
    Is * (exp( U/UT ) - 1)
}

base_voltage <- function( IB ) {

    #-10 * 10^-6 * ( exp(-UBE/UT) + 1 )

    IB <- IB

    ifelse((IB<0) & (IB > min(ylimits))  ,
        -log(-IB/Is-1) * UT * IB_scale_factor,
        NaN
    )
}

early <- function (UCE, IB) {

    UBE <- abs(base_voltage(-IB))

    #BN * IB - (1 - AN * Ai) / (1 - AN) * ICS * ( exp((UBE-UCE)/UT) - 1)

    factor <- IB * 10000

 factor*   Is * exp(UBE/UT) * ( 1 + UCE/Uearly) * 2.5 / (Is * exp(UBE/UT) * (1+3/Uearly))

}

forward_active <- function(UCE, IB) {

    xshift <- exp(log(Usat)-early(Usat, IB))

    ifelse(UCE < 4,

    ifelse(UCE > Usat,
           early(UCE, IB),

           ifelse(UCE>5000*IB*xshift, log(UCE+xshift) - log(Usat+xshift) + early(Usat, IB), NaN)
   ),

   NaN

   )

}

amplification <- function(IB) {

    B <- 0.8625

    ifelse((IB<0) & (IB > min(ylimits)), -B*IB, NaN)

}


xlimits <- c(-4, 4)
ylimits <- c(-4, 4)

ybreaks <- seq(min(ylimits), max(ylimits), by = 1)
xbreaks <- seq(min(xlimits), max(xlimits), by = 1)

ylabels <- c(0.8, 0.6, 0.4, 0.2, 0, 1, 2, 3, 4)
xlabels <- c(100, 75, 50, 25, 0, 1, 2, 3, 4)

function_size <- 1

axis_color <- "grey70"
IB_color   <- "#00B0F6"
IC_color   <- "#B983FF"
amp_color  <- "#00C0AF"


plot <- ggplot( data.frame(x=c(0, 2)), aes(x) ) +

    theme_minimal() +
    theme(plot.margin = unit(c(1.3,1.3,1.3,1.3), "cm")) +
    coord_cartesian(xlim = xlimits, ylim = ylimits,clip = "off") +

    scale_y_continuous(breaks = ybreaks, labels = ylabels) +
    scale_x_continuous(breaks = xbreaks, labels = xlabels) +

    xlab("") +
    ylab("") +

    # y axis
    geom_segment(aes(x = 0, y = min(ylimits), xend = 0, yend = max(ylimits)), color = axis_color, arrow = arrow(length = unit(0.38, "cm"))) +

    geom_segment(aes(x = 0, y = min(ylimits)+0.001, xend = 0, yend = min(ylimits)  - 0.001), color = axis_color, arrow = arrow(length = unit(0.38, "cm"))) +

    # x axis
    geom_segment(aes(x = min(xlimits), y = 0, xend = max(xlimits), yend = 0), color = axis_color, arrow = arrow(length = unit(0.38, "cm")) ) +

    geom_segment(aes(x = min(xlimits) + 0.001, y = 0, xend = min(xlimits)-0.001, yend = 0), color = axis_color, arrow = arrow(length = unit(0.38, "cm")) ) +

    # axis labels
    annotate("text", color="grey70", label = bquote("I"["B"]~"/µA"), x = min(xlimits)/2, y = min(ylimits) - overshoot, size = axisLabelSize) +

    annotate("text", color="grey70", label = bquote("U"["BE"]~"/V"), x = min(xlimits)-overshoot, y = min(ylimits)/2, size = axisLabelSize) +

    annotate("text", color="grey70", label = bquote("U"["CE"]~"/V"), x = max(xlimits)/2, y = min(ylimits) - overshoot, size = axisLabelSize) +

   annotate("text", color="grey70", label = bquote("I"["C"]~"/A"), x = min(xlimits)-overshoot, y = max(ylimits)/2, size = axisLabelSize) +

    stat_function (fun = forward_active, args = c(IB3 * 1.25), n = 10000, color = axis_color, size=function_size, linetype = "dashed") +

    stat_function (fun = base_voltage, n = 10000, color = IB_color, size=function_size) +

stat_function (fun = forward_active, args = c(IB3), n = 10000, color = IC_color, size=function_size) +

stat_function (fun = forward_active, args = c(IB2), n = 10000, color = IC_color, size=function_size) +

stat_function (fun = forward_active, args = c(IB1), n = 10000, color = IC_color, size=function_size)+

    stat_function (fun = amplification, n = 10000, color = amp_color, size=function_size) +

    geom_segment(aes(x = 4.5, y = 1, xend = 4.5, yend = 3), linetype="solid" ,arrow=arrow(length=unit(0.38, "cm")), color = IC_color) + annotate("text", x = 4.6, y = 2, label=bquote("I"["B"]), color = IC_color) +
 # quadrant annotations
    annotate("text", color = IC_color, x = 2, y = 4, label="I", size = 8)+
    annotate("text", color = amp_color, x = -2, y = 4, label="II", size = 8)+
    annotate("text", color = IB_color,  x = -2, y = -4, label="III", size = 8)+
    annotate("text", color = axis_color, x = 2, y = -4, label="IV", size = 8)


pdf(outputName, width = pdfWidth, height = pdfHeight)
plot
