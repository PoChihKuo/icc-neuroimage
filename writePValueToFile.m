function writePValueToFile(P, resultFolder)
% writeTValueToFile(P, resultFolder)
%
% 2014/08/14,JDLee, modified

if ~exist(resultFolder,'dir'), mkdir(resultFolder); end

save(fullfile(resultFolder,'P.mat'), 'P');

end