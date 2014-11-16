function [X, Y] = generate_data_with_line(N, alpha)

% get N uniform random points on the interval [ -1 1 ] x [ -1 1 ]
x_axis = ( rand( N , 1 ) - 0.5 ) .* 2 ; 
y_axis = ( rand( N , 1 ) - 0.5 ) .* 2 ;

% construct a straight line
yEst = alpha(1) .* x_axis + alpha(2) ;

% allocate points on or above line +1
plus_one = ( y_axis >= yEst );

% and below -1
minus_one = ( y_axis < yEst ) .* -1 ; 

% classification labels
Y = plus_one + minus_one ;

X = [x_axis y_axis];

