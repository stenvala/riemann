%% solve for geodesic equation
clear all; close all; clc;
% define metric tensor and riemannian manifold with respect to chart
syms x y real

h = sin(x)*cos(y); % height function
K = rmSymb.getGaussianCurvature(h,x,y); % just for fun

g = rmSymb.getMetricFromHeight(h,x,y);
rm = rmSymb(g,[x,y]);

% for evaluation
G = matlabFunction(g,'vars',[x y]);
H = matlabFunction(h,'vars',[x y]);
%% initial conditions for geodesic solver

% solve geodesic with initial value solver
initPosition = [0 pi/4]';
initVector = [4 0]';
tSpan = [0 5]';
geo = rm.solveGeodesic(initPosition,initVector,...
  't',tSpan);

% solve geodesic with boundary value solver, search for local minimum path
% between points
initPosition = [0 pi/4]';
endPosition = [-2*pi -pi/4]';
geoBVP = rm.solveGeodesicBVP(initPosition,endPosition);

% solve geodesic at Jacobi metric, for this, establish new manifold
initPosition = initPosition;
initVector = initVector;
tSpan = [0 10];
E = 0.5*initVector'*G(initPosition(1),initPosition(2))*initVector+...
  9.8*H(initPosition(1),initPosition(2)); % compute initial energy
gj = (E-9.8*h)*g; % this the Jacobi metric
rmj = rmSymb(gj,[x,y]);
geoj = rmj.solveGeodesic(initPosition,initVector,'t',tSpan);

%% display surface and solved geodesics
fig('figure',1,'height',24,'width',24);

s = linspace(-pi,pi,200)*3;
[X, Y] = meshgrid(s,s);

surf(X,Y,H(X,Y),'edgecolor','none');
hold on
zPlus = 0.1;
plot3(geo(:,1),geo(:,2),H(geo(:,1),geo(:,2))+zPlus,'color','m','linewidth',4);
plot3(geoBVP(:,1),geoBVP(:,2),H(geoBVP(:,1),geoBVP(:,2))+zPlus,'color','k','linewidth',4);
plot3(geoj(:,1),geoj(:,2),H(geoj(:,1),geoj(:,2))+zPlus,'color','y','linewidth',4);
hold off

view([0 90])

saveas(gcf,'fig.png','png');
