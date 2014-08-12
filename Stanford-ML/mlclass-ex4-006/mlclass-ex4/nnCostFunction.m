function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%
%cost_reg = lambda / (2 * m) * sum(theta(2:end) .^ 2);

% Create parameters to make algorithms more generic 
num_hidden_layers = 1;
weights{num_hidden_layers + 1} = [];
weights{1} = Theta1;
weights{2} = Theta2;

gradients{num_hidden_layers + 1} = [];
biased_values{num_hidden_layers + 1} = [];
layer_values{num_hidden_layers + 1} = [];
gradients{num_hidden_layers + 1} = [];

    
% Map output from 1..10 to a matrix where each row has a '1' where the label is and a '0' in all other columns
y = eye(num_labels)(y,:);


% Compute forward propogation, starting values being the inputs
layer_values{1} = X;

for i = 1:num_hidden_layers + 1,
    % Add in bias column
    [rows, cols] = size(layer_values{i});
    biased_values{i} = [ones(rows, 1) layer_values{i}]';
        
    % Compute next layer and store values
    sums{i} = (weights{i} * biased_values{i})';
    layer_values{i + 1} = sigmoid(sums{i});

    % Release memory
    layer_values{i} = [];
end

% Collect output at output layer
output = layer_values{end};

% Compute cost without regularization
cost = (-1/m) * sum(sum(y .* log(output) + (1-y) .* log(1 - output),2));

% Compute regularization cost - extract weights for all but the bias parameter, sum and square them
regularization_cost = 0;
for weight_matrix = weights,
   % Extract weights for all but the bias parameter, sum and square them
   regularization_cost = regularization_cost + lambda / (2 * m) * sum(sum(weight_matrix{1}(:, 2:end) .^ 2));
end

% Add regularization cost to overall cost
J = cost + regularization_cost;

% Compute gradient via back-propagation
 delta{num_hidden_layers + 1} = output - y;
 for i = num_hidden_layers:-1:1,
     % For back propogation, use weights without the bias parameter
     weights_no_bias = weights{i + 1}(:, 2:end);
        
     % Compute previous weight deltas
     delta{i} = delta{i + 1} * weights_no_bias  .* sigmoidGradient(sums{i});
 end

% Compute gradients
for i = 1:num_hidden_layers + 1,
    % Compute unregularized gradients
    gradients{i} = 1/ m * (biased_values{i} * delta{i})';

    % Add in gradient regularization, but don't regularize bias weight
    regularization_gradient = lambda / m * weights{i};
    regularization_gradient(:, 1) = 0;

    % Add regularization to unregularized gradient
    gradients{i} = gradients{i} + regularization_gradient;
end

% =========================================================================

% Unroll gradients
grad = [gradients{1}(:) ; gradients{2}(:)];


end
