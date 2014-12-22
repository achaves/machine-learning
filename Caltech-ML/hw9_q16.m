clear all;

N = 100;
results = zeros(5, 1);
for i = 1:1000
    % get N uniform random points on the interval [ -1 1 ] x [ -1 1 ]
    x1 = ( rand( N , 1 ) - 0.5 ) .* 2 ; 
    x2 = ( rand( N , 1 ) - 0.5 ) .* 2 ;
    x = [x1 x2];
    
    % compute y
    y  = sign(x2 - x1 + 0.25 * sin(pi * x1));

    
    % Manual RBF
    [mu_k9, ein_k9] = manualRBF(x, y, 9, 1.5);
    [mu_k12, ein_k12] = manualRBF(x, y, 12, 1.5);
    
    %
    % Test dataset
    %
    % get N uniform random points on the interval [ -1 1 ] x [ -1 1 ]
    x1test = ( rand( N * 10, 1 ) - 0.5 ) .* 2 ; 
    x2test = ( rand( N * 10, 1 ) - 0.5 ) .* 2 ;
    xtest = [x1test x2test];
    
    % compute y
    ytest  = sign(x2test - x1test + 0.25 * sin(pi * x1test));
    

    [eout_k9] = manualRBFClassify(xtest, ytest, 9, 1.5, mu_k9);
    [eout_k12] = manualRBFClassify(xtest, ytest, 12, 1.5, mu_k12);
    
    if (ein_k9 > ein_k12 && eout_k9 < eout_k12)
       results(1) = results(1) + 1;
     end

    if (ein_k9 < ein_k12 && eout_k9 > eout_k12)
       results(2) = results(2) + 1;
    end
    
    if (ein_k9 < ein_k12 && eout_k9 < eout_k12)
       results(3) = results(3) + 1;
    end
    
    if (ein_k9 > ein_k12 && eout_k9 > eout_k12)
       results(4) = results(4) + 1;
    end
    
    if (ein_k9 == ein_k12 && eout_k9 == eout_k12)
       results(5) = results(5) + 1;
    end
       
end

results
      

      



