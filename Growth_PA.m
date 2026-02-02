function [G_PA] = Growth_PA(T)

% gives time in day for growth from this stage to next 
% data from Stien et al. (2005)

B1 = 67.47;
B2 = 0.177;
S = size(T);
G_PA = zeros(1,S(2));

for i = 1:S(2)
    
    % Belehradek, min time in stage
    gpa = (B1/(T(i)-10+B1*B2))^2;
    gch = (74.70/(T(i)-10+74.70*0.246))^2;
    G = gpa-gch;                %%% AAAAAAAAAARRRRRRRRRGGHHHHHHH
    
    % add the development time to next stage
    % QUADRATIC
    dev_PA = 134.21 - 26.07*T(i) + 1.29*T(i)^2;
    % LINEAR
    %dev = 12.8747 - 1.0615*T(i);
    %dev_PA = max(1,dev);
    % CONSTANT
    %dev_PA = 1;
    
    G_PA(i) = G + dev_PA;
    % Growth values (1/G = rate)
    G_PA(i) = 1/G_PA(i);
    
end

%standard deviations?

end