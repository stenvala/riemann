%% solve for metric on 2-sphere and compute path lengths
%
% Spherical coordinates
% r = 1
% theta = [0, pi]
% varphi = [0, 2*pi)

clear all; close all; clc;
% define metric tensor

syms theta varphi real % computation is considerably faster if variables are assumed to be real
r = 1;
x = r*sin(theta)*cos(varphi);
y = r*sin(theta)*sin(varphi);
z = r*cos(theta);

g = rmSymb.getPullBackMetric([theta,varphi],[x,y,z]);
rm = rmSymb(g,[theta,varphi]);

% compute path length
thetaPath = linspace(0,pi);
varphiPath = linspace(0,pi*8);
% rm.getPathLength([thetaPath' varphiPath']);

%R = simplify(rm.getRiemannCurvature());
%S = simplify(rm.getRicciScalar());
%% Plot sphere and the path

thetaSpan = linspace(0,pi,15);
varphiSpan = linspace(0,pi*2,30);
[T, V] = meshgrid(thetaSpan,varphiSpan);
X = matlabFunction(x,'vars',[theta varphi]);
Y = matlabFunction(y,'vars',[theta varphi]);
Z = matlabFunction(z,'vars',[theta varphi]);

fig('figure',1,'height',16,'width',16);
mesh(X(T,V),Y(T,V),Z(T,V),...
  'edgeColor','blue','faceColor','white','faceAlpha',0.8);
axis equal

% draw path
hold on
plot3(X(thetaPath,varphiPath),Y(thetaPath,varphiPath),Z(thetaPath,varphiPath),...
  'color','r','linewidth',4);
hold off

% solve some geodesic equation i.e. find a great circle (doesn't work if it
% goes through the pole where metric is singular)
initPosition = [1 1]';
initVector = [1 1]';
tSpan = linspace(0,6,1e3);
geo = rm.solveGeodesic(initPosition,initVector,...
  't',tSpan);
hold on
rScale = 1.03; % scale radius slightly to get out from the sphere
X = matlabFunction(x*rScale,'vars',[theta varphi]);
Y = matlabFunction(y*rScale,'vars',[theta varphi]);
Z = matlabFunction(z*rScale,'vars',[theta varphi]);
plot3(X(geo(:,1),geo(:,2)),...
  Y(geo(:,1),geo(:,2)),...
  Z(geo(:,1),geo(:,2)),...
  'color','k','linewidth',4);
hold off


saveas(gcf,'fig.png');