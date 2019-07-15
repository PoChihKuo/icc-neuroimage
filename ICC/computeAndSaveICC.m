function [ICC_value ICC_variance] = computeAndSaveICC(brainData,resultFolder)
% [ICC_value ICC_variance] = computeAndSaveICC(brainData,resultFolder)
% Input 
%  brainData: (number of time points, number of runs, number of brain voxels)
% Output
%  ICC_value: (nBrainVoxels x 1) column vector
%  ICC_variance: (nBrainVoxels x 1) column vector
%  ICC: (nBrainVoxels x 1) column vector
%
% 2014/08/14, JDLee, created

[ICC_value ICC_variance] = computeICC(brainData);

writeICCResultToFile(ICC_value, ICC_variance, resultFolder);

end
