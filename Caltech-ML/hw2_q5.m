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

total_errors / 1000 / N