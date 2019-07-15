function [mtx] = var_cov_mtx(n)
% generate an n-by-n variance-covariance matrix randomly.
mtx = zeros(n);
mtx = triu((rand(n) - .5).*2, 1)/(n - 1);
mtx = diag(ones(n, 1)) + mtx + mtx';
