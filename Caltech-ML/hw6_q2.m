clear all ;

in = dlmread('in.dta');

X = in(:, 1:2);
Y = in(:, 3:3);
Z = hw6_transform(X);

[w, errors] = linear_regression(Z, Y);
in_errors = errors / size(X, 1)

out = dlmread('out.dta');
X = out(:, 1:2);
Y = out(:, 3:3);
Z = hw6_transform(X);

[w, errors] = linear_regression(Z, Y);
out_errors = errors / size(X, 1)

norm([0.03 0.08] - [in_errors out_errors])
norm([0.03 0.10] - [in_errors out_errors])
norm([0.04 0.09] - [in_errors out_errors])
norm([0.04 0.11] - [in_errors out_errors])
norm([0.05 0.10] - [in_errors out_errors])