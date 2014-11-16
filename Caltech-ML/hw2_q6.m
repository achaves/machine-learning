clear all ;

N = input( 'Enter no. of training points N : ' ) ;

total_errors = 0;
for i = 1 : 1000
    [X, Y, alpha] = generate_data(N);

    % run the linear regression algorithm to calculate the line
    X = [ones(1, N)', X];

    [w, errors] = linear_regression(X, Y);
    total_errors += errors;
end;

% Percentage of disagreement with the original points
total_errors / 1000 / N

total_errors = 0;
for i = 1 : 1000
    % get 1000 uniform random points on the interval [ -1 1 ] x [ -1 1 ]
    total_errors += errors_new_dataset(alpha, w);
end;

% Percentage of disagreement
total_errors / 1000 / 1000