clear all ;

N = input( 'Enter no. of training points N : ' ) ;

total_errors = 0;
total_w = [0; 0; 0; 0; 0; 0];
for runs =  1: 1000
  % get N uniform random points on the interval [ -1 1 ] x [ -1 1 ]
  x_axis = ( rand( N , 1 ) .- 0.5 ) .* 2 ; 
  y_axis = ( rand( N , 1 ) .- 0.5 ) .* 2 ;

  % calculate Y according to the function and introduce 10% noise
  Y = sign(x_axis .^ 2 .+ y_axis .^ 2 - 0.6);
  noise = randperm(N, N / 10);
  Y(noise) = Y(noise) * -1;

  % run the linear regression algorithm to calculate the line
  X = [ones(1, N)', x_axis, y_axis, x_axis .* y_axis, x_axis .^ 2, y_axis .^2];

  [w, errors] = linear_regression(X, Y);
  total_errors += errors;
  total_w = total_w .+ w;
end;

% Percentage of disagreement with the original points
total_errors / N / 1000
w
w = total_w ./ 1000

% Generate differnt 1000 points and calculate the error
total_errors = 0;
for i = 1 : 1000
    %  % get N uniform random points on the interval [ -1 1 ] x [ -1 1 ]
    x_axis = ( rand( N , 1 ) .- 0.5 ) .* 2 ; 
    y_axis = ( rand( N , 1 ) .- 0.5 ) .* 2 ;

    % calculate Y according to the function and introduce 10% noise
    Y = sign(x_axis .^ 2 .+ y_axis .^ 2 - 0.6);
    noise = randperm(N, N / 10);
    Y(noise) = Y(noise) * -1;
    
    % calculate new Y with weights calculated above
    w_Y = sign(w(1) .+ (w(2) .* x_axis) .+ 
              (w(3) .* y_axis) .+ 
              (w(4) .* x_axis .* y_axis) .+
              (w(5) .* x_axis .^ 2) .+
              (w(6) .* y_axis .^ 2));
              
    % number of disagreements
    diff = Y .- w_Y;
    errors = sum(diff(:)!=0);

    total_errors = total_errors + errors;
end;

% Percentage of disagreement
total_errors / 1000 / 1000