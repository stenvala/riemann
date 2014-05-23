function g = getMetricFromHeight(h,x,y,g3)
  % Constructs pull-back metric to a surface in 3D.
  %
  % properties:
  %   - h: height function
  %   - x: symbolic variable
  %   - y: symbolic varible
  %   - g3 {eye(3)}: 3-D metric to pull-back
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  if nargin < 4
    g3 = eye(3);
  end
  
  J = [1 0;0 1;diff(h,x) diff(h,y)]; 
  g = J'*g3*J;
  
end