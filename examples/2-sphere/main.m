%% solve for metric on 2-sphere and compute path lengths
%
% Spherical coordinates
% r = 1
% theta = [0, 2*pi)
% varphi = [0, pi]

clear all; close all; clc;
% define metric tensor

syms theta varphi
r = 1;
x = r*sin(theta)*cos(varphi);
y = r*sin(theta)*sin(varphi);
z = r*cos(theta);

g = rmSymb.getPullBackMetric([theta,varphi],[x,y,z]);
rm = rmSymb(g,[theta,varphi],'dim',2);

% compute path length
thetaPath = linspace(0,pi);
varphiPath = linspace(0,pi*2);
rm.getPathLength([thetaPath' varphiPath'])

%%

thetaSpan = linspace(0,pi,15);
varphiSpan = linspace(0,2*pi,30);
[T, V] = meshgrid(thetaSpan,varphiSpan);
X = matlabFunction(x,'vars',[theta varphi]);
Y = matlabFunction(y,'vars',[theta varphi]);
Z = matlabFunction(z,'vars',[theta varphi]);

fig('figure',1,'height',16,'width',16);
mesh(X(T,V),Y(T,V),Z(T,V),...
  'edgeColor','blue','faceColor','white','faceAlpha',0.7);
axis equal
% draw path
hold on
plot3(X(thetaPath,varphiPath),Y(thetaPath,varphiPath),Z(thetaPath,varphiPath),...
  'color','r','linewidth',4);
hold off