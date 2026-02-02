function [G_CH] = Growth_CH(T)

% gives time in day for growth from this stage to next 
% data from Stien(2005)
B1 = 74.70;
B2 = 0.246;
S = size(T);
G_CH = zeros(1,S(2));

for i = 1:S(2)
    
    % Belehradek, min time in stage
    G = (B1/(T(i)-10+B1*B2))^2;
    
    % Add the development time to next stage
    % QUADRATIC
    dev_CH = 421.819 - 84.714*T(i) + 4.286*T(i)^2;
    % LINEAR
    %dev = 3.0679 - 0.1846*T(i);
    %dev_CH = max(1,dev);
    % CONSTANT
    %dev_CH = 1;
    
    G_CH(i) = G + dev_CH;
    
    % Growth values (1/G = rate)
    G_CH(i) = 1/G_CH(i);
end


end