function G = getChristoffelSymbols(this,varargin)
  % Computes Christoffel symbols
  %
  % Gamma^i_{jk} indices are as G(i,j,k)
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
    if isfield(this.myPers,'GammaFun') && ~params.recompute
        G = this.myPers.GammaFun;
    else
        G = matlabFunction(simplify(this.getChristoffelSymbols('g',params.g,...
          'recompute',params.recompute)),...
        'vars',this.s);  
        this.myPers.GammaFun = G;
    end    
    return;
  end
  if isfield(this.myPers,'Gamma') && ~params.recompute
    G = this.myPers.Gamma;
    return;
  end  
  
  ginv = inv(params.g);
  G = sym(zeros(this.dim,this.dim,this.dim));
  for i=1:this.dim
    for j=1:this.dim
      for k=1:this.dim
        for m=1:this.dim                         
          G(i,j,k) = G(i,j,k) + ...
            ginv(m,i)*(...
            diff(params.g(m,k),this.s(j))+...
            diff(params.g(j,m),this.s(k))-...
            diff(params.g(k,j),this.s(m)));
        end
      end
    end
  end
  this.myPers.Gamma = G;
end