function [P] = computeAndSaveP( T_OriginalData, T_ShuffledData,resultFolder)
% [P] = computeAndSaveP( T_OriginalData, T_ShuffledData,resultFolder)
% Input
%  T_OriginalData: a (gbindex x 1) matrix
%  T_ShuffledData: a (1 x nReplicates) cell array
%                  each cell contains a (gbindex x 1) matrix
% resultFolder
% Output
%  P: a (gbindex x 1) matrix
%

P = ComputeP(T_OriginalData, T_ShuffledData);

writePValueToFile(P, resultFolder);

end