N = 1000000;

% get N uniform random points on the interval [ -1 1 ] x [ -1 1 ]
e1 = rand( N , 1 );
e2 = rand( N , 1 );
e = min(e1, e2);
sum(e) / N
mean(e)


