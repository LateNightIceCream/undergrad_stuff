
clear all

bitrate = 1000000;

f = (-10):(0.0001):(10);

si = 20*log10(1 .* sinc(f).^2);

plot(f,si);
ylim([-100,2])