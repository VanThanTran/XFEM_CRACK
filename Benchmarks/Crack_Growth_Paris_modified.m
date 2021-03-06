global BC CRACK DOMAIN FORCE GROW INC MAT PLOT VOID

% DOMAIN(1,2) = number of elements in x,y-direction
% DOMAIN(3,4) = elemental length in x,y-direction
% MAT(1,3)    = Young's modulus for domain, inclusion
% MAT(2,4)    = Poisson's ratio for domain, inclusion
% MAT(5)      = plane stress (1) or plane strain (2)
% MAT(6)      = plane stress thickness
% MAT(7)      = critical stress intensity factor for domain
% MAT(8) = threshold Mode I stress intensity factor
% MAT(9) = threshold Mode II stress intensity factor
% MAT(10) = yield stress for domain

% CRACK(i,1)  = x-coordinate of 1st point of ith segment
% CRACK(i,2)  = y-coordinate of 1st point of ith segment
% CRACK(i,3)  = x-coordinate of 2nd point of ith segment/1st point (i+1)th segment
% CRACK(i,4)  = y-coordinate of 2nd point of ith segment/1st point (i+1)th segment

% INC(i,:)    = x-coordinate of center(1), y-coordinate of center(2), radius(3)
% INC(1,:)    = [x0 y0 x1 y1] defining linear material interface

% VOID(i,:)   = x-coordinate of center(1), y-coordinate of center(2), radius(3)

% GROW(1,:)   = Fixed dNumber of iterations(1), crack growth increment(2)
% GROW(1,:)   = Paris Law: Number of cycles(1), Cycles per iteration(2), C(3), m(4),

% FORCE(i,1)  = Edge of ith distribued force: Uniaxial Tension Y(1),Uniaxial Tension X(2)
% FORCE(i,2)  = Magnitude of ith distributed force in x-direction
% FORCE(i,3)  = Magnitude of ith distributed force in y-direction

% BC(i,1)     = Boundary condition: Bottom Rollers(1),Edge Crack(2),Half Center Crack(3),Full Center Crack(4),First Quadrant(5)
% PLOT(i,j)   = YES = 1, NO = 0
% PLOT(1,j)   = Plot Level Set(1), PHI(2), PSI(3), ZETA(4), CHI(5), Discontinuities(6), Narrow Band Radius(7) level set function
% PLOT(2,j)   = Plot Mesh(1), Node Numbers(2), Element Numbers(3), Enriched
%               Nodes(4), Discontinuities(5), J-Domain Radius(6)
% PLOT(3,j)   = Plot Deformation(1), Node Number(2), Element Numbers(3),
%               Enriched Nodes(4), Deformed Crack (Inner Element Only)(5), Deformation Scaling Factor(6)
% PLOT(4,j)   = Plot Stress(1), Average Nodal Stress(2)
% PLOT(5,j)   = Plot Stress Contour(1), Filled Contour(2), Von Mises Only(3)

% %%%%%%%%%%%%%%%%%%%%%%%%%%% GEOMETRY PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%
% Height = 10;                                                                 % Domain Height
% Width  = 6;                                                                 % Domain Width
% LElem  = 1/5;                                                              % Element Length
% 
% DOMAIN = [Width/LElem,Height/LElem,LElem,LElem];
% MAT    = [10E6,0.3,20E6,0.3,2,0,Inf];
% CRACK  = [2 Height/2;4 Height/2];
% INC    = [];
% VOID   = [];
% GROW   = [];
% FORCE  = [1 0 1];
% BC     = 4;
% PLOT   = zeros(5,7);
% PLOT(4,1) = 1; PLOT(2,1) = 1; PLOT(2,5) = 1; 
% PLOT(2,4) = 1; PLOT(3,5) = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%% GEOMETRY PARAMETERS (Paris Law Crack Growth) %%%%%%%%%%%%%%%%%%%%%%%%%%%
Height = 0.4;                                                               % Domain Height
Width  = 0.3;                                                               % Domain Width
LElem  = 1/500;                                                             % Element Length

DOMAIN = [Width/LElem,Height/LElem,LElem,LElem];
% MAT    = [71.7E9,0.33,0,0,2,0,30E6];
% CRACK  = [0 Height/2;0.01 Height/2];
% INC    = [];
% VOID   = [];
% GROW   = [2500 50 1.5E-10 3.8];
% FORCE  = [1 0 78.629032258064512E6];
% BC     = 3;
% PLOT   = zeros(5,7);
% PLOT(1,:) = [1 0 0 0 0 1 0];
% PLOT(2,:) = [1 0 0 1 1 0 0];


% Height = 0.4;                                                               % Domain Height
% Width  = 0.3;                                                               % Domain Width
% LElem  = 1/499;                                                             % Element Length
% % DOMAIN = [Width/LElem,Height/LElem,LElem,LElem];
% nEx = 149; lx = Width/nEx; nEy = 199; ly = Height/nEy;
% DOMAIN = [nEx nEy lx ly];
MAT    = [71.7E9,0.33,0,0,2,0,30E6 2.2 1 520e6];   % Alumninum alloy 7075-T6
% MAT    = [71.7E9,0.33,0,0,2,0,30E6];
CRACK  = [0 Height/2;0.01 Height/2];
INC    = [];
VOID   = [];
GROW   = [2500 75 1.5E-10 3.8 0.7 0.84 0.3];
% GROW   = [2500 50 1.5E-10 3.8];      old codes
% FORCE  = [1 0 78.629032258064512E6];  % old codes
FORCE  = [];
BC     = 3;
PLOT   = zeros(5,7);
PLOT(2,:) = [1 0 0 1 1 0 0];





 