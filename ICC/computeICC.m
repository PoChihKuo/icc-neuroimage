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
% 2014/10/06, Summit, add new methods for compute ICC

[Tp nRuns nBrainVoxels] = size(brainData);

parallelMethod = projectSettings('computeICCParallelMethod');
ICCMethod = projectSettings('ICCMethod'); % 'icc1';%'icc2','icc3'

% ----------------------------------------------------------
% variance-covariance matrix
% ----------------------------------------------------------
tmatrix = zeros(nRuns, nRuns, nBrainVoxels);
% vmatrix = zeros(Tp, Tp, nBrainVoxels);

if parallelMethod == 0,        
    for v = 1:nBrainVoxels,
        tmatrix(:,:,v) = cov(brainData(:,:,v));
        %vmatrix(:,:,v) = cov(brainData(:,:,v)');
    end
else
    % use parfor to speed up
    parfor v = 1:nBrainVoxels,
        tmatrix(:,:,v) = cov(brainData(:,:,v));
        %vmatrix(:,:,v) = cov(brainData(:,:,v)');
    end
end

% ----------------------------------------------------------
% ICC_value
% ----------------------------------------------------------

ICC_value = zeros(nBrainVoxels,1);

switch ICCMethod,
    case 'icc1',
        if parallelMethod == 0,
            for v = 1:nBrainVoxels,
                vmatrix = cov(brainData(:,:,v)');
                ICC_value(v) = rr_icc_one_val(tmatrix(:,:,v), vmatrix, Tp);
            end
        elseif parallelMethod == 1,
            % use parfor to speed up
            parfor v = 1:nBrainVoxels,
                vmatrix = cov(brainData(:,:,v)');
                ICC_value(v) = rr_icc_one_val(tmatrix(:,:,v), vmatrix, Tp);
            end
        end
    case 'icc2',
        if parallelMethod == 0,
            for v = 1:nBrainVoxels,
                ICC_value(v) = rr_icc_val(tmatrix(:,:,v));
            end
        elseif parallelMethod == 1,
            % use parfor to speed up
            parfor v = 1:nBrainVoxels,
                ICC_value(v) = rr_icc_val(tmatrix(:,:,v));
            end
        elseif parallelMethod == 2,
            % remove for-loop
            diagIdx = diag(reshape([1:nRuns*nRuns],[nRuns nRuns]));
            tmatrix = reshape(tmatrix,[nRuns*nRuns nBrainVoxels]);
            ICC_value = (1-sum(tmatrix(diagIdx,:))./sum(tmatrix,1))*nRuns/(nRuns-1);
            ICC_value = ICC_value';
            tmatrix = reshape(tmatrix,[nRuns nRuns nBrainVoxels]);
        end
    case 'icc3',
        if parallelMethod == 0,
            for v = 1:nBrainVoxels,
                ICC_value(v) = rr_icc_star_val(tmatrix(:,:,v));
            end
        elseif parallelMethod == 1,
            % use parfor to speed up
            parfor v = 1:nBrainVoxels,
                ICC_value(v) = rr_icc_star_val(tmatrix(:,:,v));
            end
        end
    otherwise,
        error('unknown ICCMethod');
end
    
% ----------------------------------------------------------
% ICC_variance
% ----------------------------------------------------------
ICC_variance = zeros(nBrainVoxels,1);

switch ICCMethod,
    case 'icc1',
        flag = 1;
    case 'icc2',
        flag = 2;
    case 'icc3',
        flag = 3;
    otherwise,
        error('unknown ICCMethod');
end

if parallelMethod == 0,
    for v = 1:nBrainVoxels,
        vmatrix = cov(brainData(:,:,v)');
        ICC_variance(v) = varGaussian(tmatrix(:,:,v), vmatrix, Tp, flag);
    end
else
    % use parfor to speed up
    parfor v = 1:nBrainVoxels,
        vmatrix = cov(brainData(:,:,v)');
        ICC_variance(v) = varGaussian(tmatrix(:,:,v), vmatrix, Tp, flag);
    end
end

% ----------------------------------------------------------
% ICC
% ----------------------------------------------------------

if nargout >= 3,
    ICC = ICC_value ./ sqrt(ICC_variance);
end

end
