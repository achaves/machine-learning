function perceptron_visualize(x_axis, y_axis, x_axis_1, y_axis_1, labels, yEst, X, ytag)

% visualise the points

[ i_plus j ] = find( labels == 1 ) ; % get index for +1
[ i_minus j ] = find( labels == -1 ) ; % get index for -1

clf ;
plot( x_axis(i_plus) , y_axis(i_plus) , 'x' ) ; % plot +1 points as blue x

hold on ;

plot( x_axis_1, y_axis_1 , "@12"  ) ; % plot separating points as green +
plot( x_axis , yEst , 'g' ) ;         % plot the separating line 

plot( x_axis(i_minus) , y_axis(i_minus) , "@11" ) ; % plot -1 points as red +

plot(X(1,ytag<0),X(2,ytag<0),'bo')
plot(X(1,ytag>0),X(2,ytag>0),'ro')
legend('class -1','class +1','pred -1','pred +1')

hold off