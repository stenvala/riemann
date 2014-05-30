function dqdt = geodesicOdeFun(this,t,q)
  % Solve geodesic equation
  %
  % parameters:
  %   - point: initial point
  %   - tangent: tangent vector
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %  
  
  dim = length(this.s);
  dqdt = zeros(2*dim,1);
  dqdt(1:dim) = q(dim+1:end);
  
  GammaFun = this.getChristoffelSymbols('fun',true);
  point = num2cell(q(1:length(this.s)));
  Gamma = GammaFun(point{:});
  for i=1:length(this.s)
    dqdt(dim+i) = -q(dim+1:end)'*reshape(Gamma(i,:,:),dim,dim)*q(dim+1:end);    
  end
  
end
