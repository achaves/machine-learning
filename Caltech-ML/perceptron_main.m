clear all ;

N = input( 'Enter no. of training points N : ' ) ;
runs = input( 'Enter no. of runs : ' ) ;

% get N uniform random points on the interval [ -1 1 ] x [ -1 1 ]
x_axis = ( rand( N , 1 ) .- 0.5 ) .* 2 ; 
y_axis = ( rand( N , 1 ) .- 0.5 ) .* 2 ;

% randomly choose two more points for separating line
x_axis_1 = ( rand( 2 , 1 ) .- 0.5 ) .* 2 ; 
y_axis_1 = ( rand( 2 , 1 ) .- 0.5 ) .* 2 ;

% ensure the separating line is not vertical for ease of label classification
if ( x_axis_1(1) == x_axis_1(2) )
   x_axis_1(1) = x_axis_1(1) * 0.5 ;
end

% fit a straight line to these two separating points

% Formulating a matrix for solving for least squares estimate
X = [ x_axis_1 ones( 2 , 1 ) ] ;
alpha = inv( X' * X ) * X' * y_axis_1 ; % solving for m and c

% construct a straight line
yEst = alpha(1) .* x_axis .+ alpha(2) ;

% allocate points on or above line +1
plus_one = ( y_axis >= yEst );

% and below -1
minus_one = ( y_axis < yEst ) .* -1 ; 

% classification labels
labels = plus_one .+ minus_one ;

% run the perceptron algorithm to calculate the line
X = [ones(1, N)', x_axis, y_axis];
Y = (minus_one .+ plus_one);
iterations = 0;

    
for runs = 1: runs
    errors = 1;
    w = [0, 0, 0];

    while errors > 0 %sum(sign(X*w')~=Y)/size(X,1) != 0  % misclassification rate
       iterations++;
       [w, errors] = perceptron(X, Y, w);
    end
end    

iterations / runs
w
%ytag=X * w';
%perceptron_visualize(x_axis, y_axis, x_axis_1, y_axis_1, labels, yEst, X, ytag);

% get 1000 uniform random points on the interval [ -1 1 ] x [ -1 1 ]
x_test = ( rand( 1000 , 1 ) .- 0.5 ) .* 2 ; 
y_test = ( rand( 1000 , 1 ) .- 0.5 ) .* 2 ;

% calculate f for new points
yEst_f = alpha(1) .* x_test .+ alpha(2) ;

% compute f for new points - above line = +1 and below = -1
plus_one_f = ( y_test >= yEst_f );
minus_one_f = ( y_test < yEst_f ) .* -1 ; 
result_f = plus_one_f .+ minus_one_f;

% calculate g for new points
yEst_g = (-w(2) / w(3)) .* x_test .+ (-w(1) / w(3));

% compute g for new points - above line = +1 and below = -1
plus_one_g = ( y_test >= yEst_g );
minus_one_g = ( y_test < yEst_g ) .* -1 ; 
result_g = plus_one_g .+ minus_one_g;

% number of disagreements
diff = result_f - result_g;
errors = sum(diff(:)!=0);

% Percentage of disagreement
errors / 1000
