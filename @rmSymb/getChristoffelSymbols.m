function G = getChristoffelSymbols(this,varargin)
  % Computes Christoffel symbols
  %
  % Gamma^i_{jk} indices are as G(i,j,k)
  %
  % varargin:
  %   - fun {false}: get as matlabFunction for evaluation
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.fun = false;
  params = setDefaultParameters(defaults,varargin);
  if params.fun
    if isfield(this.myPers,'GammaFun')
        G = this.myPers.GammaFun;
    else
        G = matlabFunction(this.getChristoffelSymbols(),...
        'vars',this.s);  
        this.myPers.GammaFun = G;
    end    
    return;
  end
  if isfield(this.myPers,'Gamma')
    G = this.myPers.Gamma;
    return;
  end  
  
  ginv = this.getInverseMetric();
  G = sym(zeros(this.dim,this.dim,this.dim));
  for i=1:this.dim
    for j=1:this.dim
      for k=1:this.dim
        for m=1:this.dim                         
          G(i,j,k) = G(i,j,k) + ...
            ginv(m,i)*(...
            diff(this.g(m,k),this.s(j))+...
            diff(this.g(j,m),this.s(k))-...
            diff(this.g(k,j),this.s(m)));
        end
      end
    end
  end
  this.myPers.Gamma = G;
end