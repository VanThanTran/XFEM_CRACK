% Written By: Matthew Jon Pais, University of Florida (2010)
% Website: http://sites.google.com/site/matthewjpais/Home
% Email: mpais@ufl.edu, matthewjpais@gmail.com

function Gopt = xfemOptimization(theta)
format compact; global CRACK DOMAIN MAT NODES globalK

%%%%% Pre-Processing %%%%%
pHDOF = [];
ao    = 1+3*DOMAIN(3);
CRACK = [4 4;4+ao*cos(theta) 4+ao*sin(theta)];

%%%%% Processing %%%%%
if isempty(globalK) == 1, i = 1; else i = 2; end
if i == 1, connectivity; else NODES(:,2:29) = 0; end                        % Define connectivity
omega           = levelSet(1);                                              % Create phi and psi, define enriched elements
[DOF,DISP]      = calcDOF;                                                  % Total degrees of freedom
[updElem,IElem] = enrElem(1,pHDOF);                                         % Find enriched elements, inclusion elements

if i == 1, globalK = stiffnessMatrix(omega,DOF,1,updElem,IElem);            % Construct global stiffness matrix
else pHDOF = 2*max(NODES(:,1));
     globalK = updateStiffness(globalK,omega,DOF,updElem,pHDOF);            % Update the global stiffness matrix
end

globalF         = forceVector(DOF);                                         % Construct global force vector
freeDOF         = boundaryCond(DOF);                                        % Solve for the degrees of freedom
DISP(freeDOF,:) = globalK(freeDOF,freeDOF)\globalF(freeDOF,:);              % Find the nodal displacement values

%%%%% Post-Processing %%%%%
[KI,KII] = JIntegral(omega,DISP);                                           % Calculate the stress intensity factors
Gopt     = -(KI(1)^2+KII(1)^2)*(1-MAT(2)^2)/MAT(1);