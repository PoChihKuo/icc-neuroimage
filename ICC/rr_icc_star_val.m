function [icc_star] = rr_icc_star_val(s)
% ICC* index of fMRI data.
% 
k = length(s);
icc_star = (1 - trace(s)/sum(s(:)))/(1 - sum(sum(s*s))/(sum(s(:)))^2);