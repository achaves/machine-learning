clear all ;

train = dlmread('./features.train');
XTrain = train(:, 2:3);
    
test = dlmread('features.test');
XTest = test(:, 2:3);
    
for i = 0:9
    YTrain = train(:, 1);
    YTrain(YTrain ~= i) = -1;
    YTrain(YTrain == i) = 1;  

    %
    % Run SVM 
    %
    model = svmtrain(YTrain, XTrain, '-s 0 -t 1 -d 2 -g 1 -r 1 -c 0.01 -h 0 -q');
    %svmStruct = svmtrain(XTrain, YTrain, 'boxconstraint', 0.01, 'kernel_function', 'polynomial' ,'polyorder', 2, 'autoscale', true);
    %svmStruct = fitcsvm(XTrain,YTrain,'BoxConstraint',0.01,'KernelFunction','polynomial' ,'PolynomialOrder',2); 
    
    %
    % Number of misclassifications for SVM (training set)
    %    
    %C = svmclassify(svmStruct, XTrain);
    %diff = YTrain ~= sign(C);
    %errors_train = sum(diff(:) ~= 0); 
    %[m,n] = size(svmStruct.SupportVectors);
    
    [predict_label, accuracy, prob_estimates] = svmpredict(YTrain, XTrain, model, '-b 0 -q');
    diff = YTrain ~= sign(predict_label);
    errors_train = sum(diff(:) ~= 0);
    

    %
    % Number of misclassifications for SVM (test set)
    %    
    YTest = test(:, 1);
    YTest(YTest ~= i) = -1;
    YTest(YTest == i) = 1; 

    [predict_label, accuracy, prob_estimates] = svmpredict(YTest, XTest, model, '-b 0 -q');
    diff = YTest ~= sign(predict_label);
    errors_test = sum(diff(:) ~= 0);
    %errors_test / length(XTest)
    %accuracy

    %C = svmclassify(svmStruct, XTest);
    %diff = YTest ~= sign(C);
    %errors_test = sum(diff(:) ~= 0); 

    fprintf('%d %f %f %d\n', i, errors_train / length(XTrain), errors_test / length(XTest), model.totalSV);
end
 
%0.0219233
%0.0732436
%0.079721
%0.0827105
%0.0827105
%0.0847035
%0.0881913
%0.0986547
%0.0996512
%0.111609

%0 0.105884 0.111609
%1 0.014401 0.021923
%2 0.100261 0.098655
%3 0.090248 0.082711
%4 0.089425 0.099651
%5 0.076258 0.079721
%6 0.091071 0.084704
%7 0.088465 0.073244
%8 0.074338 0.082711
%9 0.088328 0.088191



