function J = getJacobian(fun,vars)
  % Constructs Jacobian of a function
  %
  % properties:
  %   - fun: functions
  %   - vars: variables
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  J = sym(zeros(length(fun),length(vars)));
  for k=1:length(fun)
    for p=1:length(vars)      
      J(k,p) = diff(fun(k),vars(p));
    end
  end  
end