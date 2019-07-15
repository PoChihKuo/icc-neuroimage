% readme.txt for ICC/ICC* functions.
% ==================================

var_cov_mtx.m
% mtx = var_cov_mtx(m), generate a m-by-m var-cov-matrix.

vech.m
% vech_mtx = vech(mtx), note that vec(mtx) = mtx(:).

rr_icc_val.m
% icc = rr_icc_val(mtx), evaluate the icc index of mtx.

rr_icc_star_val.m
% icc_star = rr_icc_star_val(mtx), evaluate the icc* index of mtx.

icc_partial.m
% d_prime = icc_partial(mtx), calculate d' = dICC/dvech'(mtx).

icc_star_partial.m
% d_prime_star = icc_star_partial(mtx), d*' = dICC*/dvech'(mtx).

vecG.m
% Gm = vecG(m), generate Gm matrix for a m-by-m symmetric matrix.
% Also note that Hm = inv(Gm'*Gm)*Gm' = (Gm'*Gm)\Gm'.

varGaussian.m
% var = varGaussian(mtx, tp, flag), calculate the variance.
% tp = # of time points, and using ICC if flag = 0, ICC* if flag = 1.