function l = solveGeodesic(this,point,tangent,varargin)
  % Solve geodesic equation
  %
  % parameters:
  %   - point: initial point
  %   - tangent: tangent vector
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.t = [0 1];
  params = setDefaultParameters(defaults,varargin);
  init = [point; tangent];
  
  odefun = @(t,q) this.geodesicOdeFun(t,q);
      
  res = ode45(odefun,params.t,init);
  l = res.y(1:length(this.s),:)';
  
  
end
