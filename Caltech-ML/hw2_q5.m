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

total_errors / 1000 / N