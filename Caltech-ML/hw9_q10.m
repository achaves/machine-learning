clear all ;

firstSample = 1;
secondSample = 5;

% train
train = dlmread('features.train');
XTrain = train(:, 2:3);
YTrain = train(:, 1);
    
first = YTrain == firstSample;
second = YTrain == secondSample;

XTrain = [XTrain(first, :); XTrain(second, :)];
XTrain = hw9_transform(XTrain);

YTrain = [YTrain(first, :); YTrain(second, :)];
YTrain(YTrain ~= firstSample) = -1;
YTrain(YTrain == firstSample) = 1;
    
% test    
test = dlmread('features.test');
XTest = test(:, 2:3);
YTest = test(:, 1);
    
first = (YTest == firstSample);
second = (YTest == secondSample);

XTest = [XTest(first, :); XTest(second, :)];
XTest = hw9_transform(XTest);

YTest = [YTest(first, :); YTest(second, :)];
YTest(YTest ~= firstSample) = -1;
YTest(YTest == firstSample) = 1;

    
for i = 0:1
    lambda = 0.01 * (10 ^ (i * 2));
    %
    % Run linear regression 
    %
    [w errors_train] = linear_regression_with_reg(XTrain, YTrain, lambda);
    
    
    %
    % Number of misclassifications for test set
    %    
    diff = sign(XTest * w) ~= YTest;
    errors_test = sum(diff(:)!=0);
    
    fprintf('%f %f %f\n', lambda, errors_train / length(XTrain), errors_test / length(XTest));
end
 



