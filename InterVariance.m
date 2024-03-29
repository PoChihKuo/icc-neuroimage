function [var] = InterVariance(mtx, v, tp)
% var = varGaussian(mtx, tp, flag), calculate the variance.
% tp = # of time points, and using ICC if flag = 0, ICC* if flag = 1.

m = length(mtx);
G_m = vecG(m);
H_m = (G_m'*G_m)\G_m';
yeta = (sum(v(:))/(tp^2)) / (sum(mtx(:))/(m^2));
coef = (m - 1)/(m - 1 + yeta);

d_prime = icc_partial(mtx);
var = 2*d_prime*H_m*kron(mtx, mtx)*H_m'*d_prime'/tp;
var = var * (coef^2);
