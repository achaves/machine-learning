function Z = hw9_transform(X)
  X1_Squared = X(:, 1).^2;
  X2_Squared = X(:, 2).^2;
  X1TimesX2 = X(:, 1).*X(:,2);

  Z = [ones(size(X, 1), 1) X X1TimesX2 X1_Squared X2_Squared];
