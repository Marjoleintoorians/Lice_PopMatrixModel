function [F] = Fecundity(T)
% Fecundity function from Samsing 2016

Tc = 10;
F = exp(5.6 - 0.43*log(T/Tc) - 0.78*(log(T/Tc)).^2);
F = F/15;   % 1 string produced every 15 days


% NOTE
% multiplication 0.5 is left out in the matrix, because this function only
% describes the number of eggs per string. A louse gives 2 strings, so
% there is no need to account for x0.5 in the matrix.

end

