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
winners = [0 0 0 0 0];
for runs = 1:30
   % shuffle data
   idx = randperm(length(XTrain));
   XTrain = XTrain(idx, :);
   YTrain = YTrain(idx);
   
   accuracy = 0;
   winner = 0;
   for i = 0:4    
      C = 0.0001 * (10^i);
      opt = sprintf('-s 0 -t 1 -d %d -g 1 -r 1 -h 0 -c %f -v 10 -q ', q, C);
      
      %
      % Run SVM 
      %
      model = svmtrain(YTrain, XTrain, opt);
      
      %
      % Number of misclassifications for SVM (training set)
      %    
      %[predict_label, accuracy, prob_estimates] = svmpredict(YTrain, XTrain, model, '-b 0 -q');
      %diff = YTrain ~= sign(predict_label);
      %errors_train = sum(diff(:) ~= 0);
      

      %
      % Number of misclassifications for SVM (test set)
      %    
      %[predict_label, accuracy, prob_estimates] = svmpredict(YTest, XTest, model, '-b 0 -q');
      %diff = YTest ~= sign(predict_label);
      %errors_test = sum(diff(:) ~= 0);
      
      if (model > accuracy) 
         accuracy = model;
         winner = i;
      end

      fprintf('%d %f %f\n', q, C, 100 - model);
  end
  winners(winner+1) = winners(winner+1) + 1;
  fprintf("\n");
end

winners 


