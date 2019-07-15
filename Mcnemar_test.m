
function [midp] = Mcnemar_test(Pa,Pb,Pc,Pd)
%Concordance analysis

% Input
% The observed joint probability in each classification category 
% --------
% Pa | Pb
% --------
% Pc | Pd
% --------

% Output
%   Fisher¡¦s mid-p test


N=Pa+Pb+Pc+Pd;   
P=[Pa Pb ;Pc Pd];
    
b=Pb;
c=Pc;
k=Pb+Pc;    
toSub=nchoosek(k,min([b c]))*(0.5)^k;    
p_value=0;

for x=0:min([b c])
  p_value=p_value+nchoosek(k,x)*(0.5)^k;        
end

p_value=p_value*2;    
midp=p_value-toSub;