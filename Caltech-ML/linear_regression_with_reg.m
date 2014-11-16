function [w, errors] = linear_regression_with_reg(X, Y, lambda)

dim = size(X, 2);
w = inv(X' * X + (lambda * eye(dim))) * X' * Y;

diff = sign(X * w) ~= Y;
errors = sum(diff(:)!=0);



