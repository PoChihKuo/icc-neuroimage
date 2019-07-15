function [ICC_value ICC_variance ICC] = computeICC(brainData)
% [ICC_value ICC_variance ICC] = computeICC(brainData)
% Input
%  brainData: (number of time points, number of runs, number of brain voxels)
% Output
%  ICC_value: (nBrainVoxels x 1) column vector
%  ICC_variance: (nBrainVoxels x 1) column vector
%  ICC: (nBrainVoxels x 1) column vector

% 2014/08/06, JDLee, created
% 2014/08/12, JDLee, use parfor to speed up

[Tp nRuns nBrainVoxels] = size(brainData);

if projectSettings('displayTime'), tic; end
parallelMethod = projectSettings('computeICCParallelMethod');

% ----------------------------------------------------------
% variance-covariance matrix
% ----------------------------------------------------------
tmatrix = zeros(nRuns, nRuns, nBrainVoxels);

if parallelMethod == 0,
    for v = 1:nBrainVoxels,
        tmatrix(:,:,v) = cov(brainData(:,:,v));
    end    
else
    % use parfor to speed up
    parfor v = 1:nBrainVoxels,
        tmatrix(:,:,v) = cov(brainData(:,:,v));
    end
end
if projectSettings('displayTime'),toc; end

% ----------------------------------------------------------
% ICC_value
% ----------------------------------------------------------
if projectSettings('displayTime'),tic; end

if parallelMethod == 0,
    ICC_value = zeros(nBrainVoxels,1);
    for v = 1:nBrainVoxels,
        ICC_value(v) = rr_icc_val(tmatrix(:,:,v));
    end
elseif parallelMethod == 1,
    % use parfor to speed up
    ICC_value = zeros(nBrainVoxels,1);
    parfor v = 1:nBrainVoxels,
        ICC_value(v) = rr_icc_val(tmatrix(:,:,v));
    end
    if projectSettings('displayTime'),toc; end
elseif parallelMethod == 2,
    % remove for-loop
    diagIdx = diag(reshape([1:nRuns*nRuns],[nRuns nRuns]));
    
    tmatrix = reshape(tmatrix,[nRuns*nRuns nBrainVoxels]);
    ICC_value = (1-sum(tmatrix(diagIdx,:))./sum(tmatrix,1))*nRuns/(nRuns-1);
    ICC_value = ICC_value';
    tmatrix = reshape(tmatrix,[nRuns nRuns nBrainVoxels]);
    if projectSettings('displayTime'),toc; end
end

% ----------------------------------------------------------
% ICC_variance
% ----------------------------------------------------------
if projectSettings('displayTime'),tic; end
ICC_variance = zeros(nBrainVoxels,1);
if parallelMethod == 0,
    for v = 1:nBrainVoxels,
        ICC_variance(v) = varGaussian(tmatrix(:,:,v), Tp, 0);
    end    
else
    % use parfor to speed up    
    parfor v = 1:nBrainVoxels,
        ICC_variance(v) = varGaussian(tmatrix(:,:,v), Tp, 0);
    end
end
if projectSettings('displayTime'),toc; end

% ----------------------------------------------------------
% ICC
% ----------------------------------------------------------

if nargout >= 3,
    ICC = ICC_value ./ sqrt(ICC_variance);
end

end
