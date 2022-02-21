% Written By: Matthew Jon Pais, University of Florida (2010)
% Website: http://sites.google.com/site/matthewjpais/Home
% Email: mpais@ufl.edu, matthewjpais@gmail.com

function [freeDOF] = boundaryCond(DOF)
% This function defines the boundary conditions to be applied.

global BC CHI CONNEC DOMAIN NODES VOID XYZ

nXElem   = DOMAIN(1);                                                       % Number of elements in the x-direction
nYElem   = DOMAIN(2);                                                       % Number of elements in the y-direction
fixedDOF = NaN(1,(DOMAIN(1)+1)*(DOMAIN(2)+1));                              % Initialize vector of fixed DOFs

index = 1;
switch BC
    case 1                                                                  % Fix the bottom edge of the domain
        for i = 1:nXElem+1
            if i == 1
                fixedDOF(index:(index+1)) = [2*i-1 2*i];                    % Fix displacement in x and y-direction
                index = index+2;
            else
                fixedDOF(index) = 2*i;                                      % Fix displacement in y-direction
                index = index+1;
            end
        end
    case 2                                                                  % Boundary conditions for an edge crack
        fixedDOF = [2*(nXElem+1)-1 2*(nXElem+1) 2*(nXElem+1)*(nYElem+1)-1];
    case 3                                                                  % Boundary conditions for a center crack
%         node = 1;
%         for i = 1:nYElem+1                                                  % Rollers left edge
%             fixedDOF(index) = 2*node-1;
%             index = index+1;
%             node = node+nXElem+1;
%         end        
%         node = nXElem+1;
%         for i = 1:nYElem+1                                                  % Rollers right edge
%             if i == 1
%                 fixedDOF(index:(index+1)) = [2*node-1 2*node];              % Fix y for bottom right corner
%                 index = index+2;
%             else
%                 fixedDOF(index) = 2*node-1;
%                 index = index+1;
%             end
%             node = node+nXElem+1;
%         end
        
        node = 1;
        for i = 1:nYElem+1                                                  % Rollers left edge
            fixedDOF(index) = 2*node-1;
            index = index+1;
            node = node+nXElem+1;
        end 
        node = 1;
        node = nXElem+1;
        fixedDOF(index) = 2*node;   
    case 4                                                                  % Full center crack, crack at midplane
        vert  = 2*[(nXElem+1)*(nYElem/2)+1 (nXElem+1)*(nYElem/2+1)];
        horiz = 2*((nXElem+1)*(nYElem/2)+1)-1;
        fixedDOF(1:3) = [horiz vert];
        index = index+3;
    case 5                                                                  % Boundary conditions for first quadrant
        node = 1;
        for i = 1:nYElem+1                                                  % Rollers left edge
            fixedDOF(index) = 2*node-1;
            index = index+1;
            node = node+nXElem+1;
        end                
        for i = 1:nXElem+1
            fixedDOF(index) = 2*i;                                          % Fix displacement in y-direction
            index = index+1;
        end
    case 6                                                                  % Hole boundary conditions
        vert  = 2*[(nXElem+1)*(nYElem/2)+1 (nXElem+1)*(nYElem/2+1)];
        horiz = 2*[(nXElem/2+1) (nXElem+1)*nYElem+nXElem/2+1]-1;
        fixedDOF(1:4) = [horiz vert];
        index = index+4;
        
        % Alternate forumulation of boundary conditions
        % vert  = 2*[(nXElem+1)*(nYElem/2)+1:1:(nXElem+1)*(nYElem/2+1)];
        % horiz = 2*[(nXElem/2+1):nXElem+1:(nXElem+1)*nYElem+nXElem/2+1]-1;
        % fixedDOF(1:(length([vert horiz]))) = [horiz vert];
        % index = index+length([vert horiz]);    
    case 7
         fixedDOF = [2*1-1 2*1 2*(nXElem+1)*(nYElem+1)-1];
    case 8 % fix left_lower_corner in x&y, and fix left_upper corner in x direction
        fixedDOF = [2*1-1 2*1 2*(nXElem+1)*(nYElem)-1];
        
    case 9 % 3 points are fixed in example 3 point bending
%         idBot = find(abs(XYZ(:,3)-0) < 1e-8);
%         id1 = find(abs(XYZ(idBot,2) - 262.5) < 1e-8);
%         id2 = find(abs(XYZ(idBot,2) - 637.5) < 1e-8);
%         id3 = find((abs(XYZ(:,3)-150) < 1e-8)& (abs(XYZ(:,2)-37.5) < 1e-8));
%         fixedDOF = [2*id1 (2*id2-1) 2*id2 2*id3];
        
        idLeft = find(abs(XYZ(:,2)-0) < 1e-8);
        id1 = find(abs(XYZ(idLeft,3) - 37.5) < 1e-8);
        id2 = find(abs(XYZ(idLeft,3) - 412.5) < 1e-8);
        id3 = find((abs(XYZ(:,3)-637.5) < 1e-8)& (abs(XYZ(:,2)-150) < 1e-8));
        fixedDOF = [(2*id1-1) 2*id1 (2*id2-1) (2*id3-1)];
    case 10 % 3 points are fixed in example 3 point bending without 1 constranint 
        idLeft = find(abs(XYZ(:,2)-0) < 1e-8);
        id1 = find(abs(XYZ(idLeft,3) - 37.5) < 1e-8);
        id2 = find(abs(XYZ(idLeft,3) - 412.5) < 1e-8);
        fixedDOF = [(2*id1-1) 2*id1 (2*id2-1)];
    
    case 11 % panel with 3 holes
        idLeft = find(abs(XYZ(:,2)-0) < 1e-8);
        id1 = find(abs(XYZ(idLeft,3) - 1) < 1e-8);
        id2 = find(abs(XYZ(idLeft,3) - 19) < 1e-8);
        fixedDOF = [(2*id1-1) 2*id1 (2*id2-1)];
end

% Additional boundary conditions for void interiors
if isempty(VOID) == 0
    HoleNode = find(CHI <= 0);
    LSZero = [];
    nElem  = 1;
    for iY = 1:nYElem
        for iX = 1:nXElem
            chi = CHI(CONNEC(nElem,2:5)');
            if max(chi)*min(chi) < 0
                LSZero = [LSZero CONNEC(nElem,2:5)];
            end
            nElem = nElem+1;
        end
    end
    HoleBC = setdiff(HoleNode,LSZero);
    
    % Loop through HoleBC to check for corresponding enriched nodes
    HoleEnr = [];
    ind     = 2:2:31;
    for i = 1:length(HoleBC)
        HoleEnr = [HoleEnr NODES(HoleBC(i),ind)];
    end
    HoleEnr = unique(HoleEnr);
    if HoleEnr(1) == 0, HoleEnr(1) = []; end
    HoleBC  = [HoleBC HoleEnr];
    fixedDOF(index:(index+2*length(HoleBC)-1)) = [2*HoleBC-1 2*HoleBC];
end

fixedDOF(:,isnan(fixedDOF(1,:))) = [];
freeDOF = setdiff(1:DOF,fixedDOF);                                          % Solve for the free DOF