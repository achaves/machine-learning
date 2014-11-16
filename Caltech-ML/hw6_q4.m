clear all ;

in = dlmread('in.dta');

X = in(:, 1:2)
Y = in(:, 3:3);
Z = hw6_transform(X)

[w, errors] = linear_regression_with_reg(Z, Y, 10^3);
in_errors = errors / size(Z, 1)

out = dlmread('out.dta');
X = out(:, 1:2);
Y = out(:, 3:3);
Z = hw6_transform(X);

%[w, errors] = linear_regression_with_reg(Z, Y, 10^3);
diff = sign(Z * w) ~= Y;
errors = sum(diff(:)!=0);
out_errors = errors / size(Z, 1)


norm([0.2 0.2] - [in_errors out_errors])
norm([0.2 0.3] - [in_errors out_errors])
norm([0.3 0.3] - [in_errors out_errors])
norm([0.3 0.4] - [in_errors out_errors])
norm([0.4 0.4] - [in_errors out_errors])