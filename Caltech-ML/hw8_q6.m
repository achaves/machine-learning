clear all ;

% train
train = dlmread('./features.train');
XTrain = train(:, 2:3);
YTrain = train(:, 1);
    
ones = YTrain == 1;
fives = YTrain == 5;

XTrain = [XTrain(ones, :); XTrain(fives, :)];
YTrain = [YTrain(ones, :); YTrain(fives, :)];

YTrain(YTrain ~= 1) = -1;
YTrain(YTrain == 1) = 1;
    
% test    
test = dlmread('features.test');
XTest = test(:, 2:3);
YTest = test(:, 1);
    
ones = (YTest == 1);
fives = (YTest == 5);

XTest = [XTest(ones, :); XTest(fives, :)];
YTest = [YTest(ones, :); YTest(fives, :)];

YTest(YTest ~= 1) = -1;
YTest(YTest == 1) = 1;

length(XTrain)
length(YTrain)
length(XTest)
length(YTest)

for i = 0:4    
   for q = 2:5
      C = 0.0001 * (10^i);
      opt = sprintf('-s 0 -t 1 -d %d -g 1 -r 1 -h 0 -c %f -q', q, C);
      
      %
      % Run SVM 
      %
      model = svmtrain(YTrain, XTrain, opt);
      
      %
      % Number of misclassifications for SVM (training set)
      %    
      [predict_label, accuracy, prob_estimates] = svmpredict(YTrain, XTrain, model, '-b 0 -q');
      diff = YTrain ~= sign(predict_label);
      errors_train = sum(diff(:) ~= 0);
      

      %
      % Number of misclassifications for SVM (test set)
      %    
      [predict_label, accuracy, prob_estimates] = svmpredict(YTest, XTest, model, '-b 0 -q');
      diff = YTest ~= sign(predict_label);
      errors_test = sum(diff(:) ~= 0);

      fprintf('%d %f %f %f %d\n', q, C, errors_train / length(XTrain), errors_test / length(XTest), model.totalSV);
  end
  fprintf("\n");
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

