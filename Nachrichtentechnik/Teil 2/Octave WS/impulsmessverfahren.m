clear all;
clc

pkg load signal;

Ts = 0.001;
fs = 1/Ts

t = 0:Ts:10000; % sampling frequency: 1/a

pulsecenter = 50;
pulsewidth  = 0.002;

pulse1 = imp(t, pulsecenter, pulsewidth);
pulse2 = 0.5*imp(t, pulsecenter+0.05, pulsewidth);

pulses = pulse1 + pulse2;

%g = abs(sinc(0.1.*(t-500)));

g = imp(t, pulsecenter+500, 200);

%con = conv(pulse, g);
%con = downsample(con, 2);

fourier = abs(fft(pulses));
xf = linspace(0, fs, length(fourier));

fourier = fourier(1:floor(max(t)/Ts/2));
xf      = xf(1:floor(max(t)/Ts/2));

plot(xf, fourier)
xlabel("f")
%plot(t, g)
%ylim([0, 1.5])