function [errors] = errors_new_dataset(alpha, w)
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
end;
