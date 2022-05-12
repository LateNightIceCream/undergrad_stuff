clear all;
clc;


% transistor constant
K = 1;

% Threshold voltage
Vth = 0.6;

% Gate-Source Voltage (Input)
Vgs = 3;

% Overload voltage
Vov = Vgs - Vth;

% Saturation current
Idsat = 0.5 .* K .* Vov.^2;

% channel length modulation parameter
% unit: 1/V, intersection with Vds-axis is at -1/lambda
lambda = 0.01; 

% Drain-Source Voltages
Vds = 0:0.001:10;

% Drain current as a function of Drain-Source Voltage
id = @(vds, vov) K .*(vov - 0.5 .* vds) .* vds .* (vds<vov) + (0.5 .* K .* vov.^2) .* (vds>=vov);

% Drain current with channel length modulation
id_clm = @(vds, vov) K .*(vov - 0.5 .* vds) .* vds .* (vds<vov) + (0.5.*K.*vov.^2/(vov + 1/lambda) .* (vds + 1/lambda)) .* (vds >= vov);

%id_test = @(vds, vov) (0.5.*K.*vov.^2/(vov + 1/lambda) .* (vds + 1/lambda)) .* (vds >= vov);

% all points on the id spectrum where Vds = Vov = Vgs-Vth (pinch off points)
idpinch = @(vds) 0.5 .* K .* vds.^2;

plot(Vds, id(Vds, Vov), 
      Vds, id_clm(Vds, Vov),
      Vds, id(Vds, Vov./2), 
      Vds, id_clm(Vds, Vov./2),
      Vds, id(Vds, Vov./1.25),
      Vds, id_clm(Vds, Vov./1.25),
      %Vds, id_test(Vds, Vov),
      Vds, idpinch(Vds))
ylim([0,Idsat.*1.382])
xlabel("Drain-Source Voltage")
ylabel("Drain Current")
