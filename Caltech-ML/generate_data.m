function [X, Y, alpha] = generate_data(N)

% get N uniform random points on the interval [ -1 1 ] x [ -1 1 ]
x_axis = ( rand( N , 1 ) - 0.5 ) .* 2 ; 
y_axis = ( rand( N , 1 ) - 0.5 ) .* 2 ;

% randomly choose two more points for separating line
x_axis_1 = ( rand( 2 , 1 ) - 0.5 ) .* 2 ; 
y_axis_1 = ( rand( 2 , 1 ) - 0.5 ) .* 2 ;

% ensure the separating line is not vertical for ease of label classification
if ( x_axis_1(1) == x_axis_1(2) )
   x_axis_1(1) = x_axis_1(1) * 0.5 ;
end

% fit a straight line to these two separating points

% Formulating a matrix for solving for least squares estimate
X = [ x_axis_1 ones( 2 , 1 ) ] ;
alpha = inv( X' * X ) * X' * y_axis_1 ; % solving for m and c

% construct a straight line
yEst = alpha(1) .* x_axis + alpha(2) ;

% allocate points on or above line +1
plus_one = ( y_axis >= yEst );

% and below -1
minus_one = ( y_axis < yEst ) .* -1 ; 

% classification labels
Y = plus_one + minus_one ;

X = [x_axis y_axis];

