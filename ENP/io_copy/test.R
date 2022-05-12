library(ggplot2)
library(latex2exp)

data <- read.csv("test_data1.txt")
data_malloc <- read.csv("test_data2.txt")

data$totalsec        <- data$sec + data$min*60
data_malloc$totalsec <- data_malloc$sec + data_malloc$min*60

data$t_db <- log10(data$totalsec)
data_malloc$t_db <- log10(data_malloc$totalsec)

data
data_malloc
require(scales)
p <- ggplot(data, aes(x = n, y = t_db)) +
  theme(plot.title    = element_text(color = "gray21", size=1.6180339887498948^5),
        plot.subtitle = element_text(color = "grey70", size=1.6180339887498948^5)) +

  ggtitle("'real'-Laufzeit von io_copy abhängig von der Blockgröße") +
  labs(subtitle = "Zwei Durchläufe") +


  xlab(TeX('Blockgröße / Bytes'))+
  ylab(TeX('$\\log\\,\\frac{t_{\\,real}}{1s}$'))+
  theme_minimal() +
  geom_line(color="blue") +
  geom_point(color="blue") +
  geom_line(data = data_malloc, aes(x=n, y=t_db)) +
  geom_point(data = data_malloc, aes(x=n, y=t_db)) +
    scale_x_continuous(trans = log2_trans(),
    breaks = trans_breaks("log2", function(x) 2^x),
    labels = trans_format("log2", math_format(2^.x)))

pdf("test", 10, 6.18)
p
