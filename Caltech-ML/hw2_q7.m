clear all ;

N = input( 'Enter no. of training points N : ' ) ;
runs = input( 'Enter no. of runs for PLA : ' ) ;

[X, Y, alpha] = generate_data(N);

% run the linear regression algorithm to calculate the line
X = [ones(1, N)', X];

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