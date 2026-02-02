%%% 9/12/19: New version Marjolein


T = 20;                       % one value for temp (instead of vector)
TotT = 500;                           % total number of time steps
SI = 0.02;                    % Self-infection rate - TOM changed this
n = 7;
sig = [1, 1, 1, 0.99, 0.95, 0.98, 0.98];

% Create matrix
LHM = MakeMatrix2(T,SI,n,sig);

% Fertility values
LHM(1,n) = Fecundity(T)*sig(n)*SI;    % multiply with self-infection rate
% TOM plotted this function - looks sensible
% temp=5:1:18;
% plot(temp,Fecundity(temp))

% Time series
%vec = [0.1,0.1,0.1,0.1,0.1,0.1,0.1];  % starting vector
vec = [10,0,0,0,0,0,0]; % TOM starting vector to check propagation of density in TS matrix; should gradually start from smallest class

TS = zeros(7,TotT);                   % empty matrix for values time series
TS(:,1) = vec;


for t = 1:(TotT-1)
    
   new_vec = vec*LHM'; % TOM added transpose here to make density propagate correctly through matrix TS 
   % TOM (obviously this has no effect on eigenvalue, but the calculated
   % stage densities are quite different)
    
   TS(:,(t+1)) = new_vec; 
   vec = new_vec;
   
end

% plot rows
E = TS(1,:);
PI = TS(2,:);
I = TS(3,:);
CH = TS(4,:);
PA = TS(5,:);
A = TS(6,:);

tv = 1:(TotT);                      % timevector
%plot(tv,log10(TS))
plot(tv,TS)
legend("E","PI","I","CH","PA","A_{I}","A_{A}")
xlabel("Time (in days)")
ylabel("Number of L. salmonis individuals")
title("Single site model")


