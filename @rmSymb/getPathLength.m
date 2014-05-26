function l = getPathLength(this,path)
  % Integrate path length
  %
  %
  % varargin:
  %   - fun {false}: get as matlabFunction for evaluation
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  g = matlabFunction(this.g,'vars',this.s);  
  l = 0;
 simplify(this.g)
  for k=1:(length(path)-1)
    tan = diff(path(k:k+1,:))';
    mid = num2cell(mean(path(k:k+1,:)));      
    l = l + sqrt(tan'*g(mid{:})*tan);
  end