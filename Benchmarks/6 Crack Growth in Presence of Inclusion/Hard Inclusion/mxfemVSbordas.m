% Written By: Matthew Jon Pais, University of Florida (2009)
% Website: http://sites.google.com/site/matthewjpais/Home
% Email: mpais@ufl.edu, matthewjpais@gmail.com

clear all; close all; clc; format short;

% Crack path predicted by Bordas (2006)
CB = [0	4.000
0.500	4.000
0.596	4.007
0.696	4.015
0.802	4.022
0.898	4.031
0.993	4.037
1.099	4.046
1.194	4.055
1.294	4.066
1.395	4.078
1.496	4.087
1.591	4.097
1.697	4.103
1.797	4.111
1.893	4.118
1.993	4.128
2.094	4.134
2.189	4.140
2.289	4.146
2.491	4.152
2.591	4.156
2.692	4.158
2.793	4.161
2.888	4.163
2.988	4.163
3.094	4.167
3.195	4.167
3.296	4.167
3.396	4.169
3.491	4.169
3.592	4.167
3.693	4.169];
  
% Crack path predicted by MXFEM
CM = [   0    4.0000
    0.5000    4.0000
    0.5998    4.0060
    0.6997    4.0112
    0.7995    4.0180
    0.8992    4.0254
    0.9989    4.0332
    1.0985    4.0415
    1.1981    4.0503
    1.2977    4.0595
    1.3973    4.0687
    1.4969    4.0778
    1.5965    4.0867
    1.6961    4.0955
    1.7957    4.1038
    1.8954    4.1116
    1.9952    4.1188
    2.0950    4.1255
    2.1948    4.1313
    2.2947    4.1363
    2.3946    4.1407
    2.4945    4.1444
    2.5944    4.1476
    2.6944    4.1501
    2.7944    4.1522
    2.8944    4.1537
    2.9944    4.1548
    3.0944    4.1555
    3.1944    4.1560
    3.2944    4.1562
    3.3944    4.1562
    3.4944    4.1562
    3.5944    4.1561
    3.6944    4.1559];

xc = 2;
yc = 2;
rc = 1;
theta = (0:256)*pi*2/256;
xp = rc*cos(theta)+xc;
yp = rc*sin(theta)+yc;

figure; hold on;
plot(xp,yp,'-k')
plot(CB(:,1),CB(:,2),'.k',CM(:,1),CM(:,2),'ok')
title('Comparison of Crack Growth Paths in Presence of Hard Inclusion')
legend('Bordas','MXFEM','Location','NorthEast');
plot([0 4 4 0 0],[0 0 8 8 0],'k'), axis equal; axis off; 