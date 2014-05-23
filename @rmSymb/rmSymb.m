classdef rmSymb < handle
  % Class for perfoming symbolic operation on Riemannian manifold
  %
  % properties:
  %   - metricTensor: metric tensor of the manifold (function handle to
  %     symbolic function)
  %  
  % varargin:  
  %   - dim {2}: dimension of the manifold
  %   - title {''}: title of the manifold
  %   - description{''}: description of the manifold
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  properties (GetAccess=protected,SetAccess=protected)
    g
    dim
    title
    description
  end
  methods (Access=public)
    function this = rmSymb(metricTensor,varargin)
        defaults.dim = 2;
        defaults.description = '';
        defaults.title = '';
        params = setDefaultParameters(defaults,varargin);
        this.g = metricTensor;
        this.dim = params.dim;
        this.description = params.description;
        this.title = params.title;
    end
  end
  methods (Access=protected)
    
  end
  methods (Access=private)
    
  end
  
end