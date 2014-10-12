function [w, errors] = linear_regression(X,Y)

w = (inv(X'*X))*X'*Y;

diff = sign(X * w) ~= Y;
errors = sum(diff(:)!=0);



