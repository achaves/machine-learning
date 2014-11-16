clear all ;

N = input( 'Enter no. of training points N : ' ) ;
runs = 1000;
svm_is_better = 0;
valid_runs = 0;
total_sv = 0;
while valid_runs < runs
    %
    % Generate N points between -1 and 1
    %
    [x_axis, y_axis, minus_one, plus_one, alpha] = generate_data(N);
    X = [ones(1, N)', x_axis, y_axis];
    Y = (minus_one + plus_one);
    if (sum(minus_one) == 0 || sum(plus_one) == 0)
        continue;
    end;
    valid_runs = valid_runs + 1;
    
    %
    % Run PLA
    %
    errors = 1;
    w_pla = [0, 0, 0];

    while errors > 0 
       [w_pla, errors] = perceptron(X, Y, w_pla);
    end
    
    %
    % Run SVM 
    %
    svmStruct = svmtrain([x_axis, y_axis], Y, 'method', 'QP', 'boxconstraint', 10^10, 'autoscale', false);
    
    %
    % Compare performance on out sample
    %    
    % get 10000 uniform random points on the interval [ -1 1 ] x [ -1 1 ]
    x_test = ( rand( 10000 , 1 ) - 0.5 ) .* 2 ; 
    y_test = ( rand( 10000 , 1 ) - 0.5 ) .* 2 ;

    % calculate f for new points
    yEst_f = alpha(1) .* x_test + alpha(2) ;

    % compute XTest and YTest
    plus_one_f = ( y_test >= yEst_f );
    minus_one_f = ( y_test < yEst_f ) .* -1 ; 
    
    XTest = [ones(1, 10000)', x_test, y_test];
    YTest = (minus_one_f + plus_one_f);
    
    %
    % Number of misclassifications for PLA
    %
    diff = sign(XTest * w_pla') ~= YTest;
    errors_pla = sum(diff(:)~=0);

    %
    % Number of misclassifications for SVM
    %    
    C = svmclassify(svmStruct, [x_test, y_test]);
    diff = YTest ~= sign(C);
    errors_svm = sum(diff(:) ~= 0); 
    
    if (errors_svm < errors_pla)
       svm_is_better = svm_is_better + 1;
    end
    
    [m,n] = size(svmStruct.SupportVectors);
    total_sv = total_sv + m;
end 

svm_is_better
total_sv / runs


