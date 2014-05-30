function g = getPullBackMetric(domain,codomain,g)
  % Constructs pullback metric.
  %
  % Transition map is domain -> codomain, which pulls back the metric g at
  % codomain to domain
  % 
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  if nargin < 3
    g = eye(length(codomain));
  end
  
  J = rmSymb.getJacobian(codomain,domain);
  g = J'*g*J;
  
end
