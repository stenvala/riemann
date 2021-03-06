classdef rmSymb < dmSymb
  % Class for perfoming symbolic operation on Riemannian manifold
  %
  % properties:
  %   - metricTensor: metric tensor of the manifold (function handle to
  %     symbolic function)
  %   - symVars: symbolic variables (cell array) i.e. coordinates
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  properties (GetAccess=protected,SetAccess=protected)
    g
    % s: this comes from dmSymb
    % dim: this comes from dmSymb     
  end
  properties (GetAccess=private,SetAccess=private)
    myPers
  end
  methods (Access=public)
    %% Constructors
    function this = rmSymb(metricTensor,symVars)      
        this = this@dmSymb(symVars);        
        this.g = metricTensor;        
    end
    %% Getters
    G = getChristoffelSymbols(this,varargin); 
    S = getRicciScalar(this,varargin);
    Ri = getRicciTensor(this,varargin);
    R = getRiemannCurvature(this,varargin);
    g = getInverseMetric(this,varargin);      
    l = getPathLength(this,path);
    %% Solvers    
    geodesic = solveGeodesic(this,point,tangent,varargin);
    geodesic = solveGeodesicBVP(this,p0,p1,varargin);    
  end
  methods (Access=protected)
    
  end
  methods (Access=private)
    dqdt = geodesicOdeFun(this,t,q);    
  end
  methods (Static)
    g = getMetricFromHeight(h,x,y);   
    g = getPullBackMetric(domain,codomain,g);
    K = getGaussianCurvature(h,x,y);
  end  
end