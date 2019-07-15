function [icc] = rr_icc_val(s)
% ICC index of fMRI data.
% 
k = length(s);
icc = (1 - trace(s)/sum(s(:)))*k/(k - 1);