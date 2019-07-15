function [meta_ICC_value meta_ICC_variance] = iccMetaAnalysis_method1(cICC_value_all, cICC_variance_all)
%[meta_ICC_value meta_ICC_variance] = iccMetaAnalysis(ICC_value_all, ICC_variance_all)
% Input
%   cICC_value_all: a (1 x nSubj) cell array. Each cell contains ICC_value
%                   of size (gbindex,1), c means cell
%   cICC_variance_all: same as ICC_value_all but each cell contains
%                      ICC_variance, c means cell
% Output
%  meta_ICC_value: a (gbindex x 1) matrix
%  meta_ICC_variance: a (gbindex x 1) matrix

nGlobalVoxels = size(cICC_value_all{1},1);
nSubj = length(cICC_value_all);

mICC_value_all = zeros(nSubj, nGlobalVoxels); %each column represents a voxel, m means matrix
mICC_variance_all = zeros(nSubj, nGlobalVoxels);  %each column represents a voxel, m means matrix

% merge cell data into matrix
for s = 1:nSubj
    mICC_value_all(s,:) = cICC_value_all{s}';
    mICC_variance_all(s,:) = cICC_variance_all{s}';
end

% shrink ICCj (according to ICCj, var(ICCj), ICC, var(ICC), where ICC is average ICCj)
tmpMeanICC_value=repmat(mean(mICC_value_all,1),[nSubj,1]); % ICC
tmpVarICC_value=repmat(var(mICC_value_all,1,1),[nSubj,1]); % var(ICC)
mICC_value_all_star=1./(1./tmpVarICC_value + 1./mICC_variance_all) .* ...  
                                    (tmpMeanICC_value./tmpVarICC_value + mICC_value_all./mICC_variance_all);   %ICCj* : shrunk ICCj
                                
% use ICCj* to compute meta_ICC_value  & meta_ICC_variance
meta_ICC_value = mean(mICC_value_all_star,1)';
meta_ICC_variance = var(mICC_value_all_star,1,1)';
