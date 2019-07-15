function [var] = varGaussian(mtx, v, tp, flag)
% var = varGaussian(mtx, tp, flag), calculate the variance.
% tp = # of time points, and using ICC if flag = 0, ICC* if flag = 1.

m = length(mtx);
G_m = vecG(m);
H_m = (G_m'*G_m)\G_m';
yeta = (sum(v(:))/(tp^2)) / (sum(mtx(:))/(m^2));
coef = (m - 1)/(m - 1 + yeta);

if flag == 1
    d_prime = icc_partial(mtx);
    var = 2*d_prime*H_m*kron(mtx, mtx)*H_m'*d_prime'/tp;
    var = var * (coef^2);
elseif flag == 2
    d_prime = icc_partial(mtx);
    var = 2*d_prime*H_m*kron(mtx, mtx)*H_m'*d_prime'/tp;
elseif flag == 3
    d_prime_star = icc_star_partial(mtx);
    var = 2*d_prime_star*H_m*kron(mtx, mtx)*H_m'*d_prime_star'/tp;
end