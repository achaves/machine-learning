function perceptron0 = perceptron0(numPoints, runs)
  iters = 0;
 
  for i = 1:runs
    errors = 2;
    points = genPoints(numPoints);
    gWeights = [0 0 0];
    [fWeights,a,b] = genTarget;
    while errors > 0
      errors = 0;
      for i = 1:size(points,1)
        if g(points(i, :), gWeights) ~= f(points(i, :), fWeights)
          iters = iters + 1;
          errors = errors + 1;
          gWeights = f(points(i, :),fWeights) * points(i, :) + gWeights;
        end
      end
      %displayPerceptronState(points,fWeights,gWeights,a(2:3),b(2:3))
    end
    %printf("Target Function Vector")
    %disp(fWeights/norm(fWeights));
    %printf("G Function Vector")
    %disp(gWeights/norm(gWeights));
  end
  perceptron0 = iters/runs
endfunction
 
function displayPerceptronState( points, fWeights, gWeights, az, bz )
%DISPLAYPERCEPTRONSTATE
 
    hFig = figure( 1 );
    clf;
    set( hFig,                        ...
        'NumberTitle', 'off',         ...
        'Name',         mfilename,    ...
        'MenuBar',      'none',       ...
        'Color',        [1.0 1.0 1.0] );
    axis([-1 1 -1 1]);
 
    % ---------------------------------------------------------------------
    % Plot data points from the two classes
    %
 
          scatter(points(:,2), points(:,3));
 
    % ---------------------------------------------------------------------
    % Display parameters for separating hyperplane in title
    %
 
 
    % ---------------------------------------------------------------------
    % Plot separating hyperplane
    %
 
    hAx = subplot( 1, 1, 1 );
    axis('equal');
    set( hAx,                                  ...
        'Box',      'on',                      ...
        'NextPlot', 'add',                     ...
        'xgrid',    'on',                      ...
        'ygrid',    'on',                      ...
        'xlim',     [-1 1], ... % Bounds suitable for Z-scored data
        'ylim',     [-1 1]  );
 
  hold on;
  if gWeights(3) ~= 0
    x = -1:1;
    y1 = x * -fWeights(2) / fWeights(3) - fWeights(1) / fWeights(3);
    y2 = x * -gWeights(2) / gWeights(3) - gWeights(1) / gWeights(3);
    plot( hAx, x, y1, 'k-', 'linewidth', 0, 'color', 'blue' );
    plot( hAx, x, y2, 'k-', 'linewidth', 0, 'color', 'red' );
  end
 
    pause(0.1);
 
end % DISPLAYPERCEPTRONSTATE
 
function adjusted = adjustWeights(point, weights)
  adjusted = weights + point;
endfunction;
 
function g0 = g(point, weights)
  if dot(point,weights) > 0
    g0 = 1;
    return
  elseif dot(point,weights) == 0
    g0 = 0;
    return
  else
    g0 = -1;
    return
  endif
endfunction;
 
function f0 = f(point,weights)
  if dot(point,weights) > 0
    f0 = 1;
    return
  elseif dot(point,weights) == 0
    f0 = 0;
    return
  else
    f0 = -1;
    return 
  end
endfunction;
 
function [genTarget0,a,b] = genTarget
  a = genPoint();
  b = genPoint();
 
  slope = (a-b)(3) / (a-b)(2);
  intercept = a(3) - slope * a(2);
  genTarget0 = [intercept slope 1];
endfunction;
 
function genPoints0 = genPoints(n)
  genPoints0 = [];
  for i = 1:n
    genPoints0 = [genPoints0; genPoint()];
  end
endfunction;
 
function genPoint0 = genPoint()
  genPoint0 = [1 (rand(1,2) -0.5) * 2];
endfunction;