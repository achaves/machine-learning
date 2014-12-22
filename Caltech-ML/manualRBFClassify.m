function [ein] = manualRBFClassify (x, y, K, gamma, mu)
    N = length(x);
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
    ein = sum(diff(:) ~= 0);