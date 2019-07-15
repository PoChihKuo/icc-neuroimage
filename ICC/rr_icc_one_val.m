function [icc] = rr_icc_one_val(s, v, tp)
% ICC index of fMRI data.
% 
k = length(s);
yeta = (sum(v(:))/(tp^2)) / (sum(s(:))/(k^2));
coef = (k - 1)/(k - 1 + yeta);
icc = (1 - trace(s)/sum(s(:)))*k/(k - 1);
icc = icc*coef;