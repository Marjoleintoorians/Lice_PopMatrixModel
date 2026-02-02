function [G_e] = Growth_eggs(T)

% gives time in day for growth from this stage to next 

B1 = 41.98;
B2 = 0.338;
S = size(T);
G_e = zeros(1,S(2));

for i = 1:S(2)
    
    % Belehradek, min time in stage
    G = (B1/(T(i)-10+B1*B2))^2;
    
    % Add the development time to next stage
    % QUADRATIC
    dev_e = 32.2 - 3.52*T(i) + 0.116*T(i)^2; 
    % LINEAR
    %dev = 22.5333 - 1.2*T(i);
    %dev_e = max(1,dev);
    % CONSTANT
    %dev_e = 1;
    
    G_e(i) = G + dev_e;
    % Growth values (1/G = rate)
    G_e(i) = 1/G_e(i);
    
end

%standard deviations?

end