classdef rmSymb < handle
  % Class for perfoming symbolic operation on Riemannian manifold
  %
  % properties:
  %   - metricTensor: metric tensor of the manifold (function handle to
  %     symbolic function)
  %   - symVars: symbolic variables (cell array) i.e. coordinates
  %  
  % varargin:  
  %   - dim {2}: dimension of the manifold
  %   - title {''}: title of the manifold
  %   - description {''}: description of the manifold
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  properties (GetAccess=protected,SetAccess=protected)
    g
    s % symbolic variables (i.e. coordinates)
    dim
    title
    description
    myPers 
  end
  methods (Access=public)
    %% Constructors
    function this = rmSymb(metricTensor,symVars, varargin)
        defaults.dim = 2;
        defaults.description = '';
        defaults.title = '';
        params = setDefaultParameters(defaults,varargin);
        this.g = metricTensor;
        this.s = symVars;
        this.dim = params.dim;
        this.description = params.description;
        this.title = params.title;        
    end
    %% Getters
    G = getChristoffelSymbols(this,varargin);    
    g = getInverseMetric(this,varargin);      
    l = getPathLength(this,path);
  end
  methods (Access=protected)
    
  end
  methods (Access=private)
    
  end
  methods (Static)
    J = getJacobian(fun,vars);
    g = getMetricFromHeight(h,x,y);   
    g = getPullBackMetric(domain,codomain,g);
  end  
end