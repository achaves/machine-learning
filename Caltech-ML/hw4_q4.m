clear all ;

total_variance = 0;
total_m = 0;
for i = 1 : 100000
    % get 2  random points on the interval [ -1 1 ] x [ -1 1 ]
    x = ( rand( 2 , 1 ) .- 0.5 ) .* 2;  
    y = sin(pi .* x); %( rand( 2 , 1 ) .- 0.5 ) .* 2 ;

    % run the linear regression algorithm to calculate the line
    m = sum(x.*y)/sum(x.^2);
    total_m += m;
    total_variance += (m - 1.4274)^2;
end;

m = total_m / 100000
total_variance / 100000

