X = [1 0; 0 1; 0 -1; -1 0; 0 2; 0 -2; -2 0];
Y = [-1 -1 -1 1 1 1 1]';

Z1 = X(:, 2:2) .^ 2 - X(:, 1:1) .* 2 .- 1;
Z2 = X(:, 1:1) .^ 2 - X(:, 2:2) .* 2 .+ 1;

%
% Run SVM 
%
C = 10^10;
opt = sprintf('-s 0 -t 1 -d 2 -g 1 -r 1 -h 0 -c %f -q', C);
model = svmtrain(Y, X, opt);
model.totalSV
      
      
%axis auto;     
XMinus = [1 0; 0 1; 0 -1];
ZMinus1 = XMinus(:, 2:2) .^ 2 - XMinus(:, 1:1) .* 2 .- 1;
ZMinus2 = XMinus(:, 1:1) .^ 2 - XMinus(:, 2:2) .* 2 .+ 1;

XPlus = [-1 0; 0 2; 0 -2; -2 0];
ZPlus1 = XPlus(:, 2:2) .^ 2 - XPlus(:, 1:1) .* 2 .- 1;
ZPlus2 = XPlus(:, 1:1) .^ 2 - XPlus(:, 2:2) .* 2 .+ 1;
 
plot(ZPlus1, ZPlus2, '+');
 hold on;
plot(ZMinus1, ZMinus2, '*');

hold on;
plot([-10 10], [9.5 10.5]);
hold on;
plot([-10 10], [-10.5 9.5]);
hold on;
plot([0.5 0.5], [-10 20]);
hold on;
plot([-10 20], [0.5 0.5]);
hold on;
%plot(Z1, Z2)



