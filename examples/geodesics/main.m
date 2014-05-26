%% solve for geodesic equation
clear all; close all; clc;
% define metric tensor and riemannian manifold with respect to chart
syms x y

h = sin(x)*cos(y); % height function
g = rmSymb.getMetricFromHeight(h,x,y);
rm = rmSymb(g,[x,y],'dim',2);

%% initial conditions for geodesic solver

% solve geodesic with initial value solver
initPosition = [0 pi/4]';
initVector = [1 0]';
geo = rm.solveGeodesic(initPosition,initVector,...
  't',[0 3]');
% solve geodesic with boundary value solver
initPosition = [0 pi/4]';
endPosition = [-pi pi/4]';
geoBVP = rm.solveGeodesicBVP(initPosition,endPosition);

%% display surface and solved geodesics
fig('figure',1,'height',16,'width',16);

s = linspace(-pi,pi,100)*2;
[X, Y] = meshgrid(s,s);
H = matlabFunction(h,'vars',[x y]);

surf(X,Y,H(X,Y),'edgecolor','none','facecolor','interp');
hold on
zPlus = 0.1;
plot3(geo(:,1),geo(:,2),H(geo(:,1),geo(:,2))+zPlus,'color','m','linewidth',4);
plot3(geoBVP(:,1),geoBVP(:,2),H(geoBVP(:,1),geoBVP(:,2))+zPlus,'color','k','linewidth',4);
hold off

view([0 90])
