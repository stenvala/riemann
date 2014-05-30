function S = getRicciScalar(this,varargin)
  % Computes Ricci scalar
  %
  % varargin:
  %   - fun {false}: get as matlabFunction for evaluation
  %   - g {this.g}: metric tensor
  %   - recompute {false}: recompute and don't use persistent if available
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.fun = false;
  defaults.recompute = false;
  defaults.g = this.g;
  params = setDefaultParameters(defaults,varargin);
  if params.fun
    if isfield(this.myPers,'SFun') && ~params.recompute
      S = this.myPers.SFun;
    else
      S = matlabFunction(simplify(this.getRicciTensor('g',params.g,...
        'recompute',params.recompute)),...
        'vars',this.s);
      this.myPers.SFun = S;
    end
    return;
  end
  if isfield(this.myPers,'S') && ~params.recompute
    S = this.myPers.S;
    return;
  end
  
  
  ginv = inv(params.g);
  Ri = this.getRicciTensor(varargin{:});
  
  S = 0;
  
  for i = 1:length(this.s)
    for j = 1:length(this.s)
      S = S + ginv(i,j)*Ri(i,j);
    end
  end  
  
end