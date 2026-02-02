%%% 12/12/19: New version Marjolein
%%% Input connectivity matrix
%%% Simulatation
%%% No temperature ??


TVEC = 8:1:16; % temperature
sites = 12;
sig = [1, 1, 1, 0.99, 0.95, 0.98, 0.98];
n = 7;
TotT = 300;     
AAT= zeros(sites,length(TVEC));

% Input connectivity matrix here
C = [0.046088 0.00334 0.002078 0.00000613 0.00025 0.000292 0 0 0 0 0 0;
    0 0.096817 0.48847 0.000165 0.000508 0.00028 0.000852 0.003142 0 0 0 0;
    0 0.081718 0.47909 0.000162 0.000549 0.000103 0.002103 0.006893 0.00000158 0 0 0;
    0 0.0063344	0.035148 0.026561 0.11952 1.17E-05 0.0011785 0.0047337 0.01053 0.00016035 0	0;
    0 1.82E-06 5.26E-05	0.039914 0.31304 0 1.69E-05	0.00023564 0.00017792 0	0 0;
    0 0.017142 0.019872	0.017369 0.12862 0.044274 1.02E-05 0.0001149 0.00011516	0 0	0;
    0 0	0 0	0 0	0.045854 0.0025503 0 0 0 0;
    0 0.0037893	0.016284 0.0050487 0.0013789 0 0.034147	0.088602 0.0001827 5.93E-06 0 0;
    0 0.007876 0.040488	0.017361 0.015297 2.25E-06 0.0026001 0.0097546 0.1115 0.048968 0 0;
    0 0.00014167 0.0030283 0.0023393 0.00068977	0 5.56E-06 0.00011204 0.045354 0.29549 0 0;
    0 0 0 0 0 0 0 0 0 0 0.015953 0.0047137;
    0 0 0 0 0 2.16E-06 0 0 0 0 0.034038	0.046075]; 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TIME SERIES %%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for w = 1:length(TVEC)
        T = TVEC(w);
        
        % Calculating total influx per site
        total_in=zeros(length(TVEC),sites);
        for x=1:sites

            total_in(w,x) = sum(C(:,x));

        end

        % 3D matrix
        MX = zeros(7,sites,TotT);       

        % Initial conditions
        for a = 1:sites

            MX(1,a,1) = 10;

        end

        % Loop for vector iteration for time series
        for t = 1:(TotT-1)
           for i = 1:sites

               % SI values are on diagonal of matrix C
               SI = C(i,i);

               % Create matrix
               LHM = MakeMatrix2_mulSites(T,SI,n,sig,1,1);

               % Iteration
               old_vec = MX(:,i,t);
               new_vec= LHM*old_vec;
               MX(:,i,t+1) = new_vec; 

               %%%%% Calculate N_al per site  %%%%%
               % for loop is summation
               AL = zeros(1,sites);
               for j = 1:(sites)            % i = source, j = destination

                   AL(j) = Fecundity(T)*sig(7)*MX(7,j,t)*C(j,i);

               end
               N_al = sum(AL);

               % Add EI to existing number of eggs
               MX(1,i,t+1) = MX(1,i,t+1) + N_al;

           end % sites (i)
        
        end % time (t)     
        
        %%% Plot the simulation %%%

        % For 1 site, plot the timeseries. Site 1, active adults adults:
        AA_site1 = zeros(1,TotT);
        for x = 1:TotT
            AA_site1(x) = MX(7,1,x);
        end
    
        subplot(3,3,w)
        plot(AA_site1)
        xlabel("Time in days")
        ylabel("# Active Adults")
        title(["Temperature= " num2str(T)])
        
    end % temperature loop (w)

