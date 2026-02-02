function [sig_eggs] = Survival_eggs(T)


% linear
% X = 0.5658 + 0.02769*T;
% sig_eggs = min(X,1);    %no more than 100% survival
sz = size(T);
S = sz(2);

for i = 1:S

sig_eggs(i) = 0.9607 - 18.26/(T(i)^3);

end

end