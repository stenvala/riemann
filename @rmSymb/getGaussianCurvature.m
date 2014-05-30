function K = getGaussianCurvature(h,x,y)
  % returns Gaussian curvature of a surface in Cartesian coordinates
  %
  % properties:
  %   - h: height
  %   - x: x-coordinate (symbolic variable)
  %   - y: y-coordinate (symbolic variable)
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  hx = diff(h,x);
  hy = diff(h,y);
  K = (diff(hx,x)*diff(hy,y)-diff(hx,y)*diff(hy,x))/((1 + hx^2 + hy^2)^2);
  
end