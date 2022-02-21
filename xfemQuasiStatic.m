% Written By: Matthew Jon Pais, University of Florida (2010)
% Website: http://sites.google.com/site/matthewjpais/Home
% Email: mpais@ufl.edu, matthewjpais@gmail.com

clear all; close all; clc; format compact; tic; global CRACK NODES MAT

%%%% Pre-Processing %%%%%
addpath('D:/MATLAB CODES/MXFEM 1d3/Benchmarks');
% Crack_Growth_Paris_classical
% Crack_Growth_Paris_modified
% inputQuasiStatic;                                                           % Define the geometry, materials, discontinuities
% Edge_Crack_Finite_Plate_1hole
% Center_Crack_Full
% Edge_Crack_3Point_load_bend
Crack_Growth_3holes

Em     = MAT(1);                                                            % Young's modulus for the matrix
vm     = MAT(2);    
Emeff = 0.5*Em/(1-vm^2);
iter = numIterations;
Knum = [];
for i = 1:iter
    
    %%%%% Processing %%%%%
    if i == 1, connectivity; pHDOF = []; else NODES(:,4:29) = 0; end        % Define connectivity
    omega           = levelSet(i);                                          % Create phi and psi, define enriched elements
    [DOF,DISP]      = calcDOF;                                              % Total degrees of freedom
    [updElem,IElem] = enrElem(i,pHDOF);                                     % Find enriched elements, inclusion elements

    if i == 1,  plotMesh; globalK = stiffnessMatrix(omega,DOF,iter,updElem,IElem);    % Construct global stiffness matrix        
    else globalK = updateStiffness(globalK,omega,DOF,updElem,pHDOF); end    % Update the global stiffness matrix
    
    globalF         = forceVector(DOF,i);                                   % Construct global force vector
    freeDOF         = boundaryCond(DOF);                                    % Solve for the degrees of freedom

    DISP(freeDOF,:) = globalK(freeDOF,freeDOF)\globalF(freeDOF,:);          % Find the nodal displacement values
%     plotMain(omega,DISP);
    %%% Post-Processing %%%%%
    if i == iter, plotMain(omega,DISP); end                                 % Make plots
    if isempty(CRACK) == 0
        pHDOF    = 2*max(NODES(:,2));                                       % Maximum constant DOF at current iteration 
        [KI,KII] = JIntegral(omega,DISP);                                   % Calculate the stress intensity factors
        K1(i,:) = KI/Emeff; K2(i,:) = KII/Emeff;
        Knum = [Knum;K1(i,1) K2(i,1)];
        Gopt     = -(KI(1)^2+KII(1)^2)*(1-MAT(2)^2)/MAT(1);
        exit     = growCrack(KI,KII,omega);                                 % Advance crack for quasi-static growth
        if strcmp(exit,'YES') == 1
            disp('WARNING: No crack growth, iterations exited early.')
            plotMain(omega,DISP); 
            break
        end
    end
    
    disp(['Iteration ',num2str(i),' completed. Elapsed time is ',num2str(toc,'%0.4f'),'.'])    
end