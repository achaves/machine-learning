clear all ;

% train
train = dlmread('features.train');
XTrain = train(:, 2:3);
YTrain = train(:, 1);
    
ones = YTrain == 1;
fives = YTrain == 5;

XTrain = [XTrain(ones, :); XTrain(fives, :)];
YTrain = [YTrain(ones, :); YTrain(fives, :)];

YTrain(YTrain ~= 1) = -1;
YTrain(YTrain == 1) = 1;

q = 2;
C = 0.001;
total_errors = 0;
for runs = 1:100
    % shuffle data
    idx = randperm(length(XTrain));
    XTrain = XTrain(idx, :);
    YTrain = YTrain(idx);

    opt = sprintf('-s 0 -t 1 -d %d -g 1 -r 1 -h 0 -c %f -q ', q, C);
    
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
    
    total_errors = total_errors + errors_train;
end

  total_errors / 100 / length(YTrain)
 


