function [ICC_value ICC_variance ICC] = computeICC(brainData)
% [ICC_value ICC_variance ICC] = computeICC(brainData)
% Input
%  brainData: (number of time points, number of runs, number of brain voxels)
% Output
%  ICC_value: (nBrainVoxels x 1) column vector
%  ICC_variance: (nBrainVoxels x 1) column vector
%  ICC: (nBrainVoxels x 1) column vector

[Tp nRuns nBrainVoxels] = size(brainData);

% ----------------------------------------------------------
% variance-covariance matrix
% ----------------------------------------------------------
tmatrix = zeros(nRuns, nRuns, nBrainVoxels);
% vmatrix = zeros(Tp, Tp, nBrainVoxels);
    for v = 1:nBrainVoxels,
        tmatrix(:,:,v) = cov(brainData(:,:,v));
        %vmatrix(:,:,v) = cov(brainData(:,:,v)');
    end

% ----------------------------------------------------------
% ICC_value
% ----------------------------------------------------------

ICC_value = zeros(nBrainVoxels,1);


for v = 1:nBrainVoxels,
	vmatrix = cov(brainData(:,:,v)');
	ICC_value(v) = rr_icc_one_val(tmatrix(:,:,v), vmatrix, Tp);
 
    
% ----------------------------------------------------------
% ICC_variance
% ----------------------------------------------------------
ICC_variance = zeros(nBrainVoxels,1);

for v = 1:nBrainVoxels,
	vmatrix = cov(brainData(:,:,v)');
	ICC_variance(v) = varGaussian(tmatrix(:,:,v), vmatrix, Tp);
end

% ----------------------------------------------------------
% ICC
% ----------------------------------------------------------

if nargout >= 3,
    ICC = ICC_value ./ sqrt(ICC_variance);
end

end
