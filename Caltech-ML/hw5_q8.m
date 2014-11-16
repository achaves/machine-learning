clear all ;

N = input( 'Enter no. of training points N : ' ) ;


[x_axis, y_axis, minus_one, plus_one, alpha] = generate_data(N);

% run the logistic regression algorithm to calculate the line
X = [ones(1, N)', x_axis, y_axis];
Y = (minus_one .+ plus_one);


total_w = zeros(size(X, 2), 1);
total_iter = 0;
total_eout = 0;
for run = 1 : 100
    error = 0.01; %input( 'Enter tolered error : ' ) ;
    lambda = 0; %zeros(1, N);
    w = zeros(size(X, 2), 1);
    w_previous = ones(size(X, 2), 1);
    iter = 0;
    while norm(w_previous - w) >= error
         w_previous = w;
         
         data = [Y, X];
         data = data(randperm(size(data,1)),:);
         Y = data(:,1);
         X = data(:,2:end);

         for i = 1:N
            x = X(i,:); % Select one example
            y = Y(i,:);
            
            gradJ = -(x' * y) / (1 + exp(x * w * y)); 
            w = w - 0.01 * gradJ;
         end

         iter++;
    end

    total_w += w;
    total_iter += iter;
    
    % get 1000 uniform random points on the interval [ -1 1 ] x [ -1 1 ]
    x_test = ( rand( 1000 , 1 ) .- 0.5 ) .* 2 ; 
    y_test = ( rand( 1000 , 1 ) .- 0.5 ) .* 2 ;

    % calculate f for new points
    yEst_f = alpha(1) .* x_test .+ alpha(2) ;

    % compute f for new points - above line = +1 and below = -1
    plus_one_f = ( y_test >= yEst_f );
    minus_one_f = ( y_test < yEst_f ) .* -1 ; 
    
    XTest = [ones(1, 1000)', x_test, y_test];
    YTest = (minus_one_f .+ plus_one_f);
    
    % y = [1000 X 1]
    % w = [3 X 1]
    % x = [1000 X 3]
    eOut = 0;
    for i = 1:1000
        partial = log(1 + exp(-YTest(i) * w' * XTest(i,:)'));
        eOut = eOut + partial;
    end
    eOut = eOut / 1000;
    total_eout += eOut;
 end
total_w ./ 100
total_iter / 100
total_eout / 100