function [w, errors] = perceptron(X,Y,w_init)

w = w_init;
diff = sign(X * w') ~= Y;
errors = sum(diff(:)!=0);

if (errors > 0)
   selected_error = randperm(errors, 1);

   error = 0;
   for  i = 1 : size(X,1) 
      if diff(i)
         error++;
         if (error == selected_error)
             w = w + X(i, :) * Y(i);  
         end
       end
    end
end



% pick one mismatched point (if any) and update w


%  for ii = 1 : size(X,1)         %cycle through training set
%    if sign(X(ii, :) * w') ~= Y(ii) %wrong decision?
%      errors++;
%      w = w + X(ii, :) * Y(ii);   %then add (or subtract) this point to w
%    end
    
%    if (errors > 0) 
%       return; 
%    end
%  end

