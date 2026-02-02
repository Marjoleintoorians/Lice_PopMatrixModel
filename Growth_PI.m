function [G_PI] = Growth_PI(T)

% gives time in day for growth from this stage to next 
% data from Stien (2005) for Belehadrek
% data from Johnson and ALbright (1991) for development time
B1 = 24.97;
B2 = 0.525;
S = size(T);
G_PI = zeros(1,S(2));

for i = 1:S(2)
    
    % Belehradek, min time in stage
    G = (B1/(T(i)-10+B1*B2))^2;
    
    % Add the development time to next stage
    % QUADRATIC
    dev_PI = 19 - 2.34*T(i) + 0.08*T(i)^2;
    % LINEAR
    %dev = 12.333 - 0.74*T(i);
    %dev_PI = max(1,dev);
    % CONSTANT
    %dev_PI = 1;
    
    G_PI(i) = G + dev_PI;
    % Growth values (1/G = rate)
    G_PI(i) = 1/G_PI(i);
    
end
%standard deviations?

end