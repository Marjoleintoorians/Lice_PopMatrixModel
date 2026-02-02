%%% Multiple site model, gradient plots

EIvalues = 0:0.01:0.5;
TVEC = 6:0.1:14;
SI = 0.02;
sig = [1, 1, 1, 0.95, 0.95, 0.95, 0.9];
n = 7;


% Time series
TotT = 201;                           % total number of time steps

sitesvec = [2,3,5,10];

for b = 1:length(sitesvec)
    
    sites = sitesvec(b);
    

% 3D matrix
MX = zeros(7,sites,TotT);
MX(1,:,1) = 100;            % initial conditions


grad = zeros(length(EIvalues),length(TVEC));
AA = zeros(TotT,sites);


% EI iteration
for i = 1:length(EIvalues)
    
    EI = EIvalues(i);
    
    % Temperature iteration
    for j = 1:length(TVEC)
        
        T = TVEC(j);
        
        % Create matrix
        LHM = MakeMatrix2_mulSites(T,SI,n,sig,1);

        % Loop for vector iteration for time series
        for t = 1:(TotT-1)
           for s = 1:sites

               % Iteration timeseries
               old_vec = MX(:,s,t);
               new_vec= LHM*old_vec;
               MX(:,s,t+1) = new_vec; 

               %%%% Calculate EI per site
               EI_tot = zeros(1,(sites));

               % Sum up all different EI values per site
               for f = 1:(sites)            % f = infecting site, s = receiving site

                   EI_tot(f) = Fecundity(T)*sig(7)*MX(7,f,t)*EI;   % ????

                    if f == s
                        EI_tot(f) = 0;      % No external infection from site to itself
                    end

               end

               %Total EI
               SUM_EI = sum(EI_tot);

               % Add EI to existing number of eggs
               MX(1,s,t+1) = MX(1,s,t+1) + SUM_EI;

           end
        end

        %%% Save number of adults
        for p = 1:TotT
            for q = 1:sites

            AA(p,q) = MX(7,q,p);    

            end
        end

        %plot(log(AA))

        % gradient (between t = 200 and 300 days)
        delt = 100;
        % Number of lice
        % (use site 1, but doesn't matter, all sites the same)
        AA200 = log(AA(200,1));
        AA100 = log(AA(100,1));       
        delL = AA200-AA100;
        grad(i,j) = delL/delt;
    end
end

% EI limit
EImax = (1-SI)/(sites-1);

subplot(2,2,b)
[H,h] = contour(grad);
if b ~= 1
    hold on
    plot([0 80],[EImax*100 EImax*100],':r',"LineWidth",2)
    hold off
end
xlabel("Temperature in degrees Celsius")
ylabel("EI")
title(["S= " num2str(sites)])
clabel(H,h)
yticklabels({'0.1','0.2','0.3','0.4','0.5'})
xticklabels({'6','8','10','12','14'})


end
