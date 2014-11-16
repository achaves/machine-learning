function Z = hw7_transform(X, model)
  X1_Squared = X(:, 1).^2;
  X2_Squared = X(:, 2).^2;
  X1TimesX2 = X(:, 1).*X(:,2);
  AbsX1MinusX2 = abs(X(:, 1) - X(:,2));
  AbsX1PlusX2 = abs(X(:, 1) + X(:,2));

  Z = [ones(size(X, 1), 1) X X1_Squared X2_Squared X1TimesX2 AbsX1MinusX2 AbsX1PlusX2];
  Z = Z(:, 1:model+1);