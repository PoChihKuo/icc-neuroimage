function [meta_ICC_variance] = IntraVariance(cICC_variance_all)
%[meta_ICC_value meta_ICC_variance] = iccMetaAnalysis(ICC_value_all, ICC_variance_all)
% Input
%   cICC_variance_all: same as ICC_value_all but each cell contains
%                      ICC_variance, c means cell
% Output
%  meta_ICC_variance: a (gbindex x 1) matrix

nGlobalVoxels = size(cICC_value_all{1},1);
nSubj = length(cICC_value_all);

mICC_variance_all = zeros(nSubj, nGlobalVoxels);  %each column represents a voxel, m means matrix


H = sum(1./mICC_variance_all,1); %row vector of size (1,nGlobalVoxels)
invH = 1./H; %row vector of size (1,nGlobalVoxels)
W = (1./mICC_variance_all).*repmat(invH,nSubj,1);%matrix of size (nSubj, nGlobalVoxels)

meta_ICC_variance = invH';%column vector of size (nGlobalVoxels,1)

end
