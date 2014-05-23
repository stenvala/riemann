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
  end
  methods (Access=public)
    function this = rmSymb(metricTensor,symVars, varargin)
        defaults.dim = 2;
        defaults.description = '';
        defaults.title = '';
        params = setDefaultParameters(defaults,varargin);
        this.g = metricTensor;
        this.symVars = symVars;
        this.dim = params.dim;
        this.description = params.description;
        this.title = params.title;
    end
  end
  methods (Access=protected)
    
  end
  methods (Access=private)
    
  end
  methods (Static)
    g = getMetricFromHeight(h,x,y);      
  end  
end