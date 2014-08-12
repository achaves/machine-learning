function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta






% =============================================================
s = sigmoid(X * theta);
cost_reg = lambda / (2 * m) * sum(theta(2:end) .^ 2);

J = -1/m * (log(s)' * y + log(1 - s)' * (1 - y)) + cost_reg;

% for all js
%grad = 1/m * (X' * (s - y)) + lambda/m * theta(2:end);

% redo for j = 0 (we don't want to regularize for theta0)
%grad(1) = 1/m * (X(1)') * (s(1) - y(1));


%do this for the rest of the terms...
grad = (1/m) * (X' * (s - y)) + (lambda / m * theta);

%do this for theta 0
grad(1) = (1/m) * (X(:,1)' * (sigmoid(X * theta(:,1)) - y));
end
