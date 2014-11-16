clear all ;

in = dlmread('in.dta');

X = in(:, 1:2);
Y = in(:, 3:3);
Z = hw6_transform(X);

[w_2, errors] = linear_regression_with_reg(Z, Y, 10^2);
[w_1, errors] = linear_regression_with_reg(Z, Y, 10^1);
[w_0, errors] = linear_regression_with_reg(Z, Y, 10^0);
[w_Minus1, errors] = linear_regression_with_reg(Z, Y, 10^-1);
[w_Minus2, errors] = linear_regression_with_reg(Z, Y, 10^-2);


out = dlmread('out.dta');
X = out(:, 1:2);
Y = out(:, 3:3);
Z = hw6_transform(X);

diff = sign(Z * w_2) ~= Y;
errors = sum(diff(:)!=0);
out_errors = errors / size(Z, 1)

diff = sign(Z * w_1) ~= Y;
errors = sum(diff(:)!=0);
out_errors = errors / size(Z, 1)

diff = sign(Z * w_0) ~= Y;
errors = sum(diff(:)!=0);
out_errors = errors / size(Z, 1)

diff = sign(Z * w_Minus1) ~= Y;
errors = sum(diff(:)!=0);
out_errors = errors / size(Z, 1)

diff = sign(Z * w_Minus2) ~= Y;
errors = sum(diff(:)!=0);
out_errors = errors / size(Z, 1)




