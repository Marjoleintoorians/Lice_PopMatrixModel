%%% 9/12/19: New version Marjolein

sig = [1, 1, 1, 0.99, 0.95, 0.98, 0.98];

TVEC = 4:18;                  % temperature vector
    sizeTVEC = length(TVEC);


SIVEC = 0:0.01:0.1;
sizeSIVEC = length(SIVEC);

C = zeros(sizeSIVEC,sizeTVEC);

for s = 1:sizeSIVEC
    
    SI = SIVEC(s);
    
    for b = 1:sizeTVEC
        T = TVEC(b);

        % Create matrix
        %LHM = MakeMatrix(T); % 7 stage version of model
        LHM = MakeMatrix2(T,SI,0,0); % 7 stage version of model with more flexibility
        %LHM = MakeMatrix3(T,SI,0,0); % 5 stage version of model

        % Fertility values (only gravid female, stage 5, can create eggs)
        % Function from Samsing 2016
        %LHM(1,n) = Fecundity(T)*sig(n)*SI;      % multiply with surival of adult


        % Calculating eigenvalues
        [W,D] = eig(LHM);
        L_V = diag(D);                      % vector with all eigenvalues
        q = find(L_V==max(L_V));            % find index q for max eigenvalue
        l = L_V(q);                         % max eigenvalue of matrix LHM

        % Save for contourplot
        C(s,b) = l;
        
    end

end

% These lines are a better way to get the axis labels, so they vary according
% to the data values.
[plotX,plotY] = meshgrid(TVEC,SIVEC);
[H,h] = contour(plotX,plotY,C);
%[H,h] = contour(C);

xlabel("Temperature in degrees Celsius")
ylabel("SI")
title(["Maximum eigenvalues of matrixes dependent on";"self-infection rate (SI) and temperature - 5 stages"])
clabel(H,h)

%yticklabels({'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1'})
%xticklabels({'6','8','10','12','14','16','18','20'})

%print('-painters','-dpng','-r600','lambda_T_SI_5stage.png')





%%% Only plot SI=1 to compare Model 1 and 2 with same value of SI
% plot(TVEC,LV)
% xlabel("Temperature")
% ylabel("Maximum eigenvalue")
% title(["Model 2: SI = 1"])



