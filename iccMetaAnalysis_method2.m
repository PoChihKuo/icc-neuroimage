function T = iccMetaAnalysis_method2(cICC_value_all, cICC_variance_all)
%[meta_ICC_value meta_ICC_variance] = iccMetaAnalysis(ICC_value_all, ICC_variance_all)
% Input
%   cICC_value_all: a (1 x nSubj) cell array. Each cell contains ICC_value
%                   of size (gbindex,1), c means cell
%   cICC_variance_all: same as ICC_value_all but each cell contains
%                      ICC_variance, c means cell
% Output
%  T: a (gbindex x 1) matrix


nGlobalVoxels = size(cICC_value_all{1},1);
nSubj = length(cICC_value_all);

mICC_value_all = zeros(nSubj, nGlobalVoxels); %each column represents a voxel, m means matrix
mICC_variance_all = zeros(nSubj, nGlobalVoxels);  %each column represents a voxel, m means matrix

% merge cell data into matrix
for s = 1:nSubj
    mICC_value_all(s,:) = cICC_value_all{s}';
    mICC_variance_all(s,:) = cICC_variance_all{s}';
end

% compute Tj 
Tj= mICC_value_all./sqrt(mICC_variance_all);

%Bruce 2016/10/13, check NaN
% [r,c]=find(isnan(Tj));
% 
% for ci=1:length(c)   
%     tmp=Tj(:,c(ci));    
%     Tj(r(ci),c(ci))=mean(tmp(~isnan(tmp)));
% end
%Bruce Too much NaN, let the NaN still NaN 2017/12/15

% Tj(isnan(Tj))=mean(Tj(~isnan(Tj)),1);  

% compute mean(Tj) and var(Tj)

meanT = mean(Tj,1);
varT = var(Tj,1,1);

T=meanT./sqrt(varT/nSubj);
T=T';