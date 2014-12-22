clear all;

N = 100;
K = 9

% Parameters for svmtrain
gamma = 1.5
C = 10^100;
opt = sprintf('-t 2 -g %f -c %f -s 0 -q', gamma, C)

% Counts
separatable = 0;
regular_wins = 0;
rbf_zero_ein_count = 0;

for i = 1:1000
    % get N uniform random points on the interval [ -1 1 ] x [ -1 1 ]
    x1 = ( rand( N , 1 ) - 0.5 ) .* 2 ; 
    x2 = ( rand( N , 1 ) - 0.5 ) .* 2 ;
    x = [x1 x2];
    
    % compute y
    y  = sign(x2 - x1 + 0.25 * sin(pi * x1));

    %
    % Run SVM 
    %
    model = svmtrain(y, [ones(N, 1) x], opt);
    %model.totalSV
    
    % See if data was separatable (Ein = 0)
    [predict_label, accuracy, prob_estimates] = svmpredict(y, [ones(N, 1) x], model, '-b 0 -q');
    diff = y ~= sign(predict_label);
    rbf_kernel_ein = sum(diff(:) ~= 0);
    
    if (rbf_kernel_ein == 0) 
       separatable = separatable + 1;
    end
    
    % Manual RBF
    [idx, mu] = kmeans1(x, K);
    
    phi = zeros(N, K);
    for i = 1:N,
       for j = 1:K,
          normSquared = norm(x(i,:) - mu(j,:)) ^ 2;
          phi(i,j) = exp(-gamma * normSquared);
       endfor;
    endfor;
    phi = [ones(N, 1) phi];
    
    w = pinv(phi) * y;
    
    % Compute Ein
    diff = y ~= sign(phi * w);
    rbf_ein = sum(diff(:) ~= 0);
    if (rbf_ein == 0) 
       rbf_zero_ein_count = rbf_zero_ein_count + 1;
    end
    
    %
    % Test dataset
    %
    % get N uniform random points on the interval [ -1 1 ] x [ -1 1 ]
    x1test = ( rand( N * 10, 1 ) - 0.5 ) .* 2 ; 
    x2test = ( rand( N * 10, 1 ) - 0.5 ) .* 2 ;
    xtest = [x1test x2test];
    
    % compute y
    ytest  = sign(x2test - x1test + 0.25 * sin(pi * x1test));
    
    % classification error (RBF kernel)
    [predict_label, accuracy, prob_estimates] = svmpredict(ytest, [ones(N * 10, 1) xtest], model, '-b 0 -q');
    diff = ytest ~= sign(predict_label);
    errors_rbf_kernel = sum(diff(:) ~= 0);
    
    % classification error (regular RBF) 
    phi = zeros(N * 10, K);
    for i = 1:N * 10,
       for j = 1:K,
          norma = norm(xtest(i,:) - mu(j,:));
          phi(i,j) = exp(-gamma * (norma^2));
       endfor;
    endfor;
        
    phi = [ones(N * 10, 1) phi];
        
    yrbf = phi * w;
    diff = ytest ~= sign(yrbf);
    errors_rbf = sum(diff(:) ~= 0);
    
    if (errors_rbf_kernel > errors_rbf) 
       regular_wins + regular_wins + 1;
    end
end
      
separatable
regular_wins
rbf_zero_ein_count
      



