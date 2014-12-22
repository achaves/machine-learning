function [mu, ein] = manualRBF (x, y, K, gamma)
    % Manual RBF
    [idx, mu] = kmeans1(x, K);
    [ein] = manualRBFClassify(x, y, K, gamma, mu);
