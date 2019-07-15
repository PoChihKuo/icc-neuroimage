function writeTValueToFile(T_value, resultFolder)
% writeTValueToFile(T_value, resultFolder)
%
% 2014/08/14,JDLee, modified

if ~exist(resultFolder,'dir'), mkdir(resultFolder); end

save(fullfile(resultFolder,'T_value.mat'), 'T_value');

end