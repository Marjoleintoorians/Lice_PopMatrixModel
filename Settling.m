function settleRate = Settling(T)
    % Settling rate from Tucker 2002 (a proportion is calculated here)
    settleRate = (4.2*T - 17)/100;

    for i = 1:length(settleRate)
        if settleRate(i) < 0
            settleRate(i) = 0;
        end
    end
end