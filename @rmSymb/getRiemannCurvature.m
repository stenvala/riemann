function R = getRiemannCurvature(this,varargin)
  % Computes Riemann curvature tensor
  %
  % R^i_{jkl} indices are as R(i,j,k,l)
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
    if isfield(this.myPers,'RFun') && ~params.recompute
      R = this.myPers.RFun;
    else
      R = matlabFunction(simplify(this.getRiemannCurvature('g',params.g),...
        'recompute',params.recompute),...
        'vars',this.s);
      this.myPers.RFun = R;
    end
    return;
  end
  if isfield(this.myPers,'R') && ~params.recompute
    R = this.myPers.R;
    return;
  end  
  Gamma = this.getChristoffelSymbols('g',params.g,'recompute',params.recompute);
  R = sym(zeros(this.dim,this.dim,this.dim,this.dim));
  for i=1:this.dim
    for j=1:this.dim
      for k=1:this.dim
        for l=1:this.dim
          R(i,j,k,l) = diff(Gamma(i,l,j),this.s(k)) - ...
            diff(Gamma(i,k,j),this.s(l));
          for m=1:this.dim
            R(i,j,k,l) = R(i,j,k,l) + ...
              Gamma(i,k,m)*Gamma(m,l,j) - ...
              Gamma(i,l,m)*Gamma(m,k,j);
          end
        end
      end
    end
  end
  this.myPers.R = R;
end