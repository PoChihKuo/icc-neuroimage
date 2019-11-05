function [meta_ICC_value meta_ICC_variance] = iccMetaAnalysis(cICC_value_all, cICC_variance_all)
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

%merge cell data into matrix
for s = 1:nSubj
    mICC_value_all(s,:) = cICC_value_all{s}';
    mICC_variance_all(s,:) = cICC_variance_all{s}';
end

%Bruce 2016/10/13, check NaN

[r,c]=find(isnan(mICC_variance_all));

for ci=1:length(c)   
    tmp=mICC_variance_all(:,c(ci));    
    mICC_variance_all(r(ci),c(ci))=mean(tmp(~isnan(tmp)));
end
[r,c]=find(isnan(mICC_value_all));

for ci=1:length(c)   
    tmp=mICC_value_all(:,c(ci));    
    mICC_value_all(r(ci),c(ci))=mean(tmp(~isnan(tmp)));
end



H = sum(1./mICC_variance_all,1); %row vector of size (1,nGlobalVoxels)
invH = 1./H; %row vector of size (1,nGlobalVoxels)
W = (1./mICC_variance_all).*repmat(invH,nSubj,1);%matrix of size (nSubj, nGlobalVoxels)

meta_ICC_value = sum(W.*mICC_value_all,1)';%column vector of size (nGlobalVoxels,1)
meta_ICC_variance = invH';%column vector of size (nGlobalVoxels,1)

end
