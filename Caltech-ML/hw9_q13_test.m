clear all;

N = 4;
K = 2;

% Parameters for svmtrain
gamma = 1.5
C = 10^100;
opt = sprintf('-t 2 -g %f -c %f -s 0 -q', gamma, C)

% Counts
separatable = 0;
regular_wins = 0;
rbf_zero_ein_count = 0;

for i = 1:1
    x1 = [1; 3; 5; 7];
    x2 = [2; 4; 6; 8];
    x  = [x1 x2];

    
    % compute y
    y  = sign(x2 - x1 + 0.25 * sin(pi * x1));

    %
    % Run SVM 
    %
    model = svmtrain(y, [ones(N, 1) x], opt);
    
    % See if data was separatable (Ein = 0)
    [predict_label, accuracy, prob_estimates] = svmpredict(y, [ones(N, 1) x], model, '-b 0 -q');
    diff = y ~= sign(predict_label);
    rbf_kernel_ein = sum(diff(:) ~= 0);
    
    if (rbf_kernel_ein == 0) 
       separatable = separatable + 1;
    end
    
    % Manual RBF
    mu =[2 3; 6 7];
    %[idx, mu] = kmeans(x, K);
    
    phi = zeros(N, K);
    for i = 1:N,
       for j = 1:K,
          normSquared = norm(x(i,:) - mu(j,:)) ^ 2;
          phi(i,j) = exp(-gamma * normSquared);
       endfor;
    endfor;
    phi = [ones(N, 1) phi]
    
    w = pinv(phi) * y
    
    % Compute Ein
    diff = y ~= sign(phi * w);
    rbf_ein = sum(diff(:) ~= 0)
    if (rbf_ein == 0) 
       rbf_zero_ein_count = rbf_zero_ein_count + 1;
    end
    
end
     



