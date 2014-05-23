function g = getInverseMetric(this,varargin)
  % Computes inverse metric, i.e. metric for 1-forms 
  %
  % varargin:
  %   - fun {false}: get as matlabFunction for evaluation
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.fun = false;
  params = setDefaultParameters(defaults,varargin);
  if params.fun
    if isfield(this.myPers,'gInvFun')
        g = this.myPers.gInvFun;
    else
        g = matlabFunction(this.getInverseMetric(),...
        'vars',this.s);  
        this.myPers.gInvFun = g;
    end    
    return;
  end
  if isfield(this.myPers,'gInv')
    g = this.myPers.gInv;
    return;
  end  
  g = inv(this.g);
  this.myPers.gInv = g;
end