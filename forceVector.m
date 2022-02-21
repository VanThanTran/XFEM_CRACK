% Written By: Matthew Jon Pais, University of Florida (2009)
% Website: http://sites.google.com/site/matthewjpais/Home
% Email: mpais@ufl.edu, matthewjpais@gmail.com

function globalF=forceVector(DOF,iter)
% This function creates the global force vector from the user supplied
% input file.

global DOMAIN MAT FORCE CONNEC XYZ

nXElem  = DOMAIN(1);                                                        % Number of elements in the x-direction
nYElem  = DOMAIN(2);                                                        % Number of elements in the y-direction
le      = DOMAIN(3);                                                        % Length of a side of an element 
globalF = sparse(DOF,1);                                                    % Create the global force vector

if isempty(FORCE) == 1
    m = 1;                                                                  % For iteration dependent loading, loop through x, y, and x-y directions
    aa = mod(iter,2);
    stressHistory = inputLoadHistory(ceil(iter/2));
%     c = 10;   % Scaling factor'
    c = 1;   % Scaling factor'
else
    m = size(FORCE,1);
end
if MAT(5) == 1, h = MAT(6); else, h = 1; end

% Create the global force matrix from distributed loading
for iForce = 1:m
    
    if isempty(FORCE) == 0                                                  % Constant amplitude loading
        edge   = FORCE(iForce,1);                                           % Specified edge
        xForce = h*FORCE(iForce,2);                                         % Specified distributed force in x-direction
        yForce = h*FORCE(iForce,3);                                         % Specified distributed force in y-direction
    else                                                                    % Variable amplitude loading
        edge = m;                                                         % Uniaxial tension in y-direction
        if m == 1                         % Vertical loading
%             if     aa == 1              % Maximum stress
%                 xForce = c*stressHistory(3);
%                 yForce = c*stressHistory(2);
%             elseif aa == 0              % Minimum stress
%                 xForce = c*stressHistory(6);
%                 yForce = c*stressHistory(5);
%             end
            if     aa == 1              % Maximum stress
                xForce = 0;
                yForce = c*stressHistory(3);
            elseif aa == 0              % Minimum stress
                xForce = 0;
                yForce = c*stressHistory(6);
            end
        elseif m == 2                   % Horizontal loading
            if     aa == 1              % Maximum stress
                xForce = c*stressHistory(1);
                yForce = 0;%c/2*stressHistory(3);
            elseif aa == 0              % Minimum stress
                xForce = c*stressHistory(4);
                yForce = 0;%c/2*stressHistory(6);
            end
        end
    end

    switch edge
        case 1                                                              % Uniaxial tension in y-direction
            node = CONNEC((nYElem-1)*(nXElem)+1,5);                         % Initial node along top edge
            for i = 1:nXElem+1
                if (i == 1) || (i == nXElem+1)                              % Convert distributed force to nodal force
                    globalF(2*node-1,1) = le*xForce/2;                      % Elemental force in x-direction for edge nodes
                    globalF(2*node,1)   = le*yForce/2;                      % Elemental force in y-direction for edge nodes 
                else
                    globalF(2*node-1,1) = le*xForce;                        % Elemental force in x-direction
                    globalF(2*node,1)   = le*yForce;                        % Elemental force in y-direction
                end
                node = node+1;                                              % Update node along top edge
            end
            node = 1;                                                       % Initial node along bottom edge
            for i = 1:nXElem+1                                             
                if (i == 1) || (i == nXElem+1)                              % Convert distributed force to nodal force
                    globalF(2*node-1,1) = -le*xForce/2;                     % Element force in x-direction for edge nodes
                    globalF(2*node,1)   = -le*yForce/2;                     % Element force in y-direction for edge nodes
                else
                    globalF(2*node-1,1) = -le*xForce;                       % Element force in x-direction
                    globalF(2*node,1)   = -le*yForce;                       % Element force in y-direction
                end
                node = node+1;                                              % Update node along bottom edge
            end
        case 2                                                              % Uniaxial tension in x-direction
            node = nXElem+1;                                                % Initial node along right edge
            for i = 1:nYElem+1
                if (i == 1) || (i == (nYElem+1))                            % Convert distributed force to nodal force
                    globalF(2*node-1,1) = le*xForce/2;                      % Elemental force in x-direction for edge nodes
                    globalF(2*node,1)   = le*yForce/2;                      % Elemental force in y-direction for edge nodes 
                else
                    globalF(2*node-1,1) = le*xForce;                        % Elemental force in x-direction
                    globalF(2*node,1)   = le*yForce;                        % Elemental force in y-direction
                end
                node = node+nXElem+1;                                       % Update node along right edge
            end
            node = 1;                                                       % Initial node along left edge
            for i = 1:nYElem+1
                if (i == 1) || (i == (nXElem+1))                            % Convert distributed force to nodal force
                    globalF(2*node-1,1) = -le*xForce/2;                     % Elemental force in x-direction for edge nodes
                    globalF(2*node,1)   = -le*yForce/2;                     % Elemental force in y-direction for edge nodes 
                else
                    globalF(2*node-1,1) = -le*xForce;                       % Elemental force in x-direction
                    globalF(2*node,1)   = -le*yForce;                       % Elemental force in y-direction
                end
                node = node+nXElem+1;                                       % Update node along bottom edge
            end            
        case 3                                                              % Distributed force along bottom edge
            node = 1;                                                       % Initial node along bottom edge
            for i = 1:nXElem+1
                if (i == 1) || (i == (nXElem+1))
                    globalF(2*node-1,1) = le*xForce/2;                      % Elemental force in x-direction for edge nodes
                    globalF(2*node,1)   = le*yForce/2;                      % Elemental force in y-direction for edge nodes 
                else
                    globalF(2*node-1,1) = le*xForce;                        % Elemental force in x-direction
                    globalF(2*node,1)   = le*yForce;                        % Elemental force in y-direction
                end
                node = node+1;                                              % Update node along bottom edge
            end
        case 4                                                              % Distributed force along left edge
            node = 1;                                                       % Initial node along left edge
            for i = 1:nYElem+1
                if (i == 1) || (i == (nXElem+1))
                    globalF(2*node-1,1) = le*xForce/2;                      % Elemental force in x-direction for edge nodes
                    globalF(2*node,1)   = le*yForce/2;                      % Elemental force in y-direction for edge nodes 
                else
                    globalF(2*node-1,1) = le*xForce;                        % Elemental force in x-direction
                    globalF(2*node,1)   = le*yForce;                        % Elemental force in y-direction
                end
                node = node+nXElem+1;                                       % Update node along bottom edge
            end
            
            
        case 5 % Point-load for 3 points bending
%             xyP = [487.5 150]; % position for imposing force
%             id = find((abs(XYZ(:,3)-xyP(2)) < 1e-8)& (abs(XYZ(:,2)-xyP(1)) < 1e-8));
%             globalF(2*id,1)   = yForce;
            
            xyP = [150 187.5]; % position for imposing force
            id = find((abs(XYZ(:,3)-xyP(2)) < 1e-8)& (abs(XYZ(:,2)-xyP(1)) < 1e-8));
            globalF(2*id-1,1) = xForce;
            
        case 6  % for panel with 3 holes
            xyP = [8 10]; % position for imposing force
            id = find((abs(XYZ(:,3)-xyP(2)) < 1e-8)& (abs(XYZ(:,2)-xyP(1)) < 1e-8));
            globalF(2*id-1,1) = xForce;
        otherwise
            disp('Unknown edge specified, please modify the input.')
    end
end