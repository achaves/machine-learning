clear all ;

N = input( 'Enter no. of training points N : ' ) ;

total_errors = 0;
for i = 1 : 1000
    [x_axis, y_axis, minus_one, plus_one, alpha] = generate_data(N);

    % run the linear regression algorithm to calculate the line
    X = [ones(1, N)', x_axis, y_axis];
    Y = (minus_one .+ plus_one);

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