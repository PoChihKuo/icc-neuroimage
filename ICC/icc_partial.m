function [d_prime] = icc_partial(mtx)
% d' = dICC/dvech'(phi)
m = length(mtx);
Id_m = eye(m);
one_p = ones(1, m);
temp = sum(sum(mtx));
G_m = vecG(m);
d_prime = (-temp*Id_m(:)' + trace(mtx)*kron(one_p, one_p))*G_m*m/((m-1)*temp*temp);
