clear all; close all; clc; global BC DOMAIN FORCE INC MAT PLOT VOID

% DOMAIN(1,2) = number of elements in x,y-direction
% DOMAIN(3,4) = elemental length in x,y-direction
% MAT(1,3)    = Young's modulus for domain, inclusion
% MAT(2,4)    = Poisson's ratio for domain, inclusion
% MAT(5)      = plane stress (1) or plane strain (2)
% MAT(6)      = plane stress thickness
% MAT(7)      = critical stress intensity factor for domain
% INC(i,:)    = x-coordinate of center(1), y-coordinate of center(2), radius(3)
% INC(1,:)    = [x0 y0 x1 y1] defining linear material interface
% VOID(i,:)   = x-coordinate of center(1), y-coordinate of center(2), radius(3)
% FORCE(i,1)  = Edge of ith distribued force: Uniaxial Tension Y(1),Uniaxial Tension X(2)
% FORCE(i,2)  = Magnitude of ith distributed force in x-direction
% FORCE(i,3)  = Magnitude of ith distributed force in y-direction
% BC(i,1)     = Boundary condition: Bottom Rollers(1),Edge Crack(2),Half Center Crack(3),Full Center Crack(4),First Quadrant(5)

%%%%%%%%%%%%%%%%%%%%%%%%%%% GEOMETRY PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%
Height = 8;                                                % Domain height
Width  = 8;                                                % Domain width
LElem  = 1/20;                                             % Element length

DOMAIN = [Width/LElem,Height/LElem,LElem,LElem];
MAT    = [10e6,0.3,0,0,2,0,10e6];
INC    = [];
VOID   = [4 4 1];
FORCE  = [1 0 1];
BC     = 10;
PLOT   = zeros(5,7);

%%%%%%%%%%%%%%%%%%%%%%%%% OPTIMIZATION PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%
LB = -pi/2;                                               % Lower bound
UB =  pi/2;                                               % Upper bound

options = optimset('Display','iter','TolFun',1e-9,'TolX',1e-6);
[x,fval] = fminbnd(@xfemOptimization,LB,UB,options)