function l = solveGeodesic(this,point,tangent,varargin)
  % Solve geodesic equation
  %
  % parameters:
  %   - point: initial point
  %   - tangent: tangent vector
  %
  % varargin:
  %   - t {[0 1]}: time span for solution
  %   - odeFun {@ode45}: function handle for ode solver
  %   - odeOptions {[]}: options for ode solver
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.t = [0 1];
  defaults.odeFun = @ode45;
  defaults.odeOptions = [];
  params = setDefaultParameters(defaults,varargin);
  init = [point; tangent];
  
  odefun = @(t,q) this.geodesicOdeFun(t,q);
  res = feval(params.odeFun,odefun,params.t,init,params.odeOptions);
  l = res.y(1:length(this.s),:)';  
  
end
