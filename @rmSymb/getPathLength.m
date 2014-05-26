function l = getPathLength(this,path)
  % Integrate path length piecewise
  %
  % varargin:
  %   - fun {false}: get as matlabFunction for evaluation
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  gFun = matlabFunction(this.g,'vars',this.s);  
  l = 0;
 
  for k=1:(length(path)-1)
    tan = diff(path(k:k+1,:))';
    mid = num2cell(mean(path(k:k+1,:)));      
    l = l + sqrt(tan'*gFun(mid{:})*tan);
  end
  
end
