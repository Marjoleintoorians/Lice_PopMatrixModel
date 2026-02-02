%%% 9/12/19: New version Marjolein

TotT = 500;                   % total number of time steps
SI = 0.1;                   % Self-infection rate - TOM changed thiss
n = 7;
sig = [1, 1, 1, 0.99, 0.95, 0.98, 0.98];
TVEC = 2:0.1:18;              % temp vector
Tlength = length(TVEC);
lambda = zeros(1,Tlength);    % Empty vector for lambda values

% Iterate over different temperatures

for k = 1:Tlength
    T = TVEC(k);

    % Create matrix
    LHM = MakeMatrix2(T,SI,1,1);

    % Fertility values
    %LHM(1,n) = Fecundity(T)*sig(n)*SI;    % multiply with self-infection rate

    % Calculating eigenvalues
    [W,D] = eig(LHM);
    L_V = diag(D);                      % vector with all eigenvalues
    q = find(L_V==max(L_V));            % find index q for max eigenvalue
    lambda(k) = L_V(q);                 % max eigenvalue of matrix LHM

    % Calculating eigenvector (right)
    Right_EV = W(:,q);                  %q-th column is corresponding eigevector


end % end temperature loop
    
% Plot temperature vs lambda vector
plot(TVEC,lambda,'r','LineWidth',1.8)
xlabel("Temperature")
ylabel("lambda")

