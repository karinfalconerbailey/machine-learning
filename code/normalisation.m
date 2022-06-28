function [X_norm, mu, sigma] = featureNormalize(X) % normalize the features in X
    X_norm = X;
    mu = zeros(1, size(X, 5)); % 5 is number of features
    sigma = zeros(1, size(X, 5));
    K = size(X, 5);

    for i=1:K
        mu(i) = mean(X(:, i));
        sigma(i) = std(X(:, i));
        X_norm(:, i) = (X(:, i)  - mu(i)) / sigma(i);
    end
end