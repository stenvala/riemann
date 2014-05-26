function l = solveGeodesicBVP(this,p0,p1,varargin)
  % Solve geodesic equation
  %
  % parameters:
  %   - p0: starting point
  %   - p1: end point
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  dim = length(this.s);
  defaults.init = zeros(dim*2,100);
  defaults.t = linspace(0,1);
  for k=1:length(this.s)
    defaults.init(k,:) = linspace(p0(k),p1(k));
    defaults.init(k+dim,1:end-1) = diff(defaults.init(k,:));
    defaults.init(k+dim,end) = defaults.init(k+dim,end-1);
  end
  params = setDefaultParameters(defaults,varargin);
  bcfun = @(y0,y1) [y0(1:dim)-p0;y1(1:dim)-p1];  
  odefun = @(t,q) this.geodesicOdeFun(t,q);
  solinit.x = params.t;
  solinit.y = params.init;
  res = bvp4c(odefun,bcfun,solinit);
  l = res.y(1:dim,:)';  
end
