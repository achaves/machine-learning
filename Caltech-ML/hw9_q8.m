clear all ;

train = dlmread('features.train');
XTrain = hw9_transform(train(:, 2:3));

    
test = dlmread('features.test');
XTest = hw9_transform(test(:, 2:3));
    
for i = 0:9
    YTrain = train(:, 1);
    YTrain(YTrain ~= i) = -1;
    YTrain(YTrain == i) = 1;  

    %
    % Run linear regression 
    %
    [w errors_train] = linear_regression_with_reg(XTrain, YTrain, 1);
    
    
    %
    % Number of misclassifications for test set
    %    
    YTest = test(:, 1);
    YTest(YTest ~= i) = -1;
    YTest(YTest == i) = 1; 

    diff = sign(XTest * w) ~= YTest;
    errors_test = sum(diff(:)!=0);
    
    fprintf('%d %f %f\n', i, errors_train / length(XTrain), errors_test / length(XTest));
end
 



