% Written By: Matthew Jon Pais, University of Florida (2009)
% Website: http://sites.google.com/site/matthewjpais/Home
% Email: mpais@ufl.edu, matthewjpais@gmail.com

% clear all; close all; clc; format short;

ai = 0.01;                  % Initial crack length [m]
p  = 0.06;                  % Pressure [MPa]
m  = 3.8;                   % Paris Law exponent
C  = 1.5E-10;               % Paris Law constant
r  = 3.25;                  % Radius [m]
t  = 0.00248;               % Thickness [m]

% Cycles with data points
N  = 0:50:2450;

% Crack length predicted by Paris Law
aP = (N*C*(1-m/2)*(p*r*sqrt(pi)/t).^m+ai^(1-m/2)).^(1/(1-m/2));
  
% Crack length predicted using XFEM with Paris Law to determine length of
% growth increment and maximum circumferential stress to determine direction
aX = [0.0100 0.0102 0.0103 0.0105 0.0107 0.0109 0.0111 0.0113 0.0115...
      0.0117 0.0119 0.0122 0.0124 0.0127 0.0129 0.0132 0.0135 0.0138...
      0.0141 0.0144 0.0148 0.0151 0.0155 0.0159 0.0163 0.0167 0.0172...
      0.0177 0.0182 0.0187 0.0193 0.0199 0.0205 0.0212 0.0219 0.0227...
      0.0235 0.0244 0.0254 0.0264 0.0275 0.0288 0.0301 0.0316 0.0333...
      0.0351 0.0371 0.0394 0.0421 0.0451];
  
figure; hold on; grid on
plot(N,aP*1000,'o-k',N,aX*1000,'s-k')
xlabel('Number of Cycles'); ylabel('Crack Length [mm]')
title('Comparison of Analytical Paris Law and XFEM with Paris Law Growth Increments')
legend('Paris Law','XFEM','Location','NorthWest');