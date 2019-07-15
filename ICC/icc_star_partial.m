function [d_prime_star] = icc_star_partial(mtx)
% d*' = dICC*/dvech'(phi)
m = length(mtx);
Id_m = eye(m);
one_p = ones(1, m);
temp = sum(sum(mtx));
temp2 = sum(sum(mtx*mtx));
G_m = vecG(m);
d_prime_star = ((-temp*Id_m(:)' + trace(mtx)*kron(one_p, one_p))/(temp*temp - temp2))...
    + (1 - trace(mtx)/temp)*(temp/(temp*temp - temp2))*(temp/(temp*temp - temp2))*...
    (kron(one_p, one_p)*(kron(Id_m, mtx) + kron(mtx, Id_m)) - 2*temp2*kron(one_p, one_p)/temp);
d_prime_star = d_prime_star*G_m;