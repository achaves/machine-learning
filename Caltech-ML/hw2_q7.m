clear all ;

N = input( 'Enter no. of training points N : ' ) ;
runs = input( 'Enter no. of runs for PLA : ' ) ;

[x_axis, y_axis, minus_one, plus_one, alpha] = generate_data(N);

% run the linear regression algorithm to calculate the line
X = [ones(1, N)', x_axis, y_axis];
Y = (minus_one .+ plus_one);

[w, errors] = linear_regression(X, Y);
w = w';

% Percentage of disagreement with the original points
errors / N
w
% use weights as initial weights for perceptron learning algorithm
iterations = 0;
for runs = 1: runs
    errors = 1;

    while errors > 0 
       iterations++;
       [w, errors] = perceptron(X, Y, w);
    end
end
w
iterations / runs