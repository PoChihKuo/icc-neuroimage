function writeTAllValueToFile(T_all, resultFolder)
% writeTAllValueToFile(T_all, resultFolder)
%
% 2014/09/15,JDLee

if ~exist(resultFolder,'dir'), mkdir(resultFolder); end

save(fullfile(resultFolder,'T_all.mat'), 'T_all');

end