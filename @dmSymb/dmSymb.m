classdef dmSymb < handle
  % Class for perfoming symbolic operation on differentiable manifold
  %
  % properties:  
  %   - symVars: symbolic variables (cell array) i.e. coordinates
  %  
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  properties (GetAccess=protected,SetAccess=protected)    
    s % symbolic variables (i.e. coordinates)
    dim % dimension, can be used short of length(symVars)
  end
  methods (Access=public)
    %% Constructors
    function this = dmSymb(symVars)
        this.s = symVars;
        this.dim = length(symVars);        
    end    
  end
  methods (Access=protected)
    
  end
  methods (Access=private)
    
  end
  methods (Static)
    J = getJacobian(fun,vars);
  end  
end