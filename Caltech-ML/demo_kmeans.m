## Generate a two-cluster problem
C1 = randn (100, 2) + 1;
C2 = randn (100, 2) - 1;
data = [C1; C2];

## Perform clustering
[idx, centers] = kmeans (data, 2);

## Plot the result
plot (data (idx==1, 1), data (idx==1, 2), 'ro');
hold on
plot (data (idx==2, 1), data (idx==2, 2), 'bs');
plot (centers (:, 1), centers (:, 2), 'kv', 'markersize', 10);
hold off