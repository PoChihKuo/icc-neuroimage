function [P] = computeP( T_OriginalData, T_ShuffledData,tail)
% [P] = computeP( T_OriginalData, T_ShuffledData)
% Input
%  T_OriginalData: a (gbindex x 1) matrix
%  T_ShuffledData: a (1 x nReplicates) cell array
%                  each cell contains a (gbindex x 1) matrix
% Output
%  P: a (gbindex x 1) matrix
%
if nargin<3
   tail = projectSettings('tail');
end
    
P = zeros(size(T_OriginalData));
hypo = cell2mat(T_ShuffledData);
hypo = hypo(:)'; % force to a row vector


if tail==2, % two-tail
 hypo = abs(hypo);
 T_OriginalData = abs(T_OriginalData); 
end


N = length(hypo);
for i = 1:length(P)
    if(isnan(T_OriginalData(i)))   %Bruce 2016/09/22
    P(i) = NaN; 
    else
    P(i) = sum(hypo > T_OriginalData(i)) / N;
    end
end

% if tail==1,
%     toDiscard = find(T_OriginalData < 0);
%     P(toDiscard) = NaN; 
% end


end