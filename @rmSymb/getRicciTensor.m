function Ri = getRicciTensor(this,varargin)
  % Computes Ricci tensor
  %
  % R_{ij} indices are as R(i,j)
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
    if isfield(this.myPers,'RiFun') && ~params.recompute
      Ri = this.myPers.RiFun;
    else
      Ri = matlabFunction(simplify(this.getRicciTensor('g',params.g,...
        'recompute',params.recompute)),...
        'vars',this.s);
      this.myPers.RiFun = Ri;
    end
    return;
  end
  if isfield(this.myPers,'Ri') && ~params.recompute
    Ri = this.myPers.Ri;
    return;
  end
  
  R = this.getRiemannCurvature('g',params.g,'recompute',params.recompute);
  Ri = sym(zeros(this.dim,this.dim));
  for i=1:this.dim
    for j=1:this.dim
      for k=1:this.dim        
        Ri(i,j) = Ri(i,j) + R(k,i,k,j);        
      end
    end
  end
  this.myPers.Ri = Ri;
end