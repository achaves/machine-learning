clear all;

N = 100;
K = 9
results = zeros(5, 1);
for i = 1:30
    % get N uniform random points on the interval [ -1 1 ] x [ -1 1 ]
    x1 = ( rand( N , 1 ) - 0.5 ) .* 2 ; 
    x2 = ( rand( N , 1 ) - 0.5 ) .* 2 ;
    x = [x1 x2];
    
    % compute y
    y  = sign(x2 - x1 + 0.25 * sin(pi * x1));

    
    % Manual RBF
    [mu15, ein15] = manualRBF(x, y, K, 1.5);
    [mu20, ein20] = manualRBF(x, y, K, 2.0);
    
    %
    % Test dataset
    %
    % get N uniform random points on the interval [ -1 1 ] x [ -1 1 ]
    x1test = ( rand( N * 10, 1 ) - 0.5 ) .* 2 ; 
    x2test = ( rand( N * 10, 1 ) - 0.5 ) .* 2 ;
    xtest = [x1test x2test];
    
    % compute y
    ytest  = sign(x2test - x1test + 0.25 * sin(pi * x1test));
    

    [eout15] = manualRBFClassify(xtest, ytest, K, 1.5, mu15);
    [eout20] = manualRBFClassify(xtest, ytest, K, 2.0, mu20);
    
    if (ein15 > ein20 && eout15 < eout20)
       results(1) = results(1) + 1;
     end

    if (ein15 < ein20 && eout15 > eout20)
       results(2) = results(2) + 1;
    end
    
    if (ein15 < ein20 && eout15 < eout20)
       results(3) = results(3) + 1;
    end
    
    if (ein15 > ein20 && eout15 > eout20)
       results(4) = results(5) + 1;
    end
    
    if (ein15 == ein20 && eout15 == eout20)
       results(5) = results(5) + 1;
    end
       
end

results
      

      



