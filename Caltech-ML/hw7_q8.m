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
    [X, Y, alpha] = generate_data(N);
    XWithOnes = [ones(1, N)' X];
    if (abs(sum(Y)) == size(Y))
        continue;
    end;
    valid_runs = valid_runs + 1;
    
    %
    % Run PLA
    %
    errors = 1;
    w_pla = [0, 0, 0];

    while errors > 0 
       [w_pla, errors] = perceptron(XWithOnes, Y, w_pla);
    end
    
    %
    % Run SVM 
    %
    svmStruct = svmtrain(X, Y, 'method', 'QP', 'boxconstraint', 10^10, 'autoscale', false);
    
    %
    % Compare performance on out sample
    %    
    [XTest, YTest] = generate_data_with_line(10000, alpha);
    
    %
    % Number of misclassifications for PLA
    %
    diff = sign([ones(1, 10000)', XTest] * w_pla') ~= YTest;
    errors_pla = sum(diff(:)~=0);

    %
    % Number of misclassifications for SVM
    %    
    C = svmclassify(svmStruct, XTest);
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


