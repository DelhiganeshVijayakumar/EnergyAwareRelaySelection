
%parameters
alpha = 0.4;        % Time allocated ratio
eta = 0.6;          % Energy conversion efficiency
Pp = 10 ;             % Transmit power of PT (in Watts)
N0 = 0.1;           % Variance of the thermal noise (in Watts)
hps = 0.7;          % Channel gain of the main channel from PT to CS
hsp = 0.6;          % Channel gain of the main channel from CS to PD 
hsd = 0.5;          % Channel gain of the main channel from CS to CD
I = (10^(20/10))*N0;           % Interference power (in Watts)
T = 1;              % Total time for communication (in seconds)
Nv = 2;             % Number of eavesdroppers
hse = [0.9, 0.7];   % channel gain of the channel from CS-Ee
sigma_j1_sq=0.2;   %Noise variance (in Watts) from PT to Cs
sigma_j2_sq=0.2;   %Noise variance (in Watts) from PT to Ee

% Energy harvesting phase
Edc_s = alpha * eta * T * Pp * abs(hps)^2; % Energy harvested at CS (in Joules)

% Information transmitting phase
a = alpha * eta / (1 - alpha);
Pdc_s = min(a * Pp * abs(hps)^2, I / abs(hsp)^2); % Transmit power of CS (in Watts)

% Shannon capacity
Nj1=N0 + Pp*(sigma_j1_sq);
C_d = (1 - alpha) * T * log2(1 + Pdc_s * abs(hsd)^2 / Nj1 ); % Shannon capacity (in bits/s)

% Capacity of wireless channel from CS to Ee
Nj2=N0 + Pp*(sigma_j2_sq);  % Noise variance at Ee (in Watts)
Cse = (1 - alpha) * T * log2(1 + Pdc_s * abs(hse(1))^2 / Nj2); % Capacity of wireless channel from CS to Ee (in bits/s)

% Overall capacity of wiretap channels
Cetotal = 0;
for e = 1:Nv
    Cetotal = Cetotal + (1 - alpha) * T * log2(1 + Pdc_s * abs(hse(e))^2 / Nj2); % Overall capacity of wiretap channels (in bits/s)
end

% Display the results
disp(['Energy harvested at CS: ' num2str(Edc_s) ' J']);
disp(['Transmit power of CS: ' num2str(Pdc_s) ' W']);
disp(['Shannon capacity: ' num2str(C_d) ' bits/s']);
disp(['Capacity of wireless channel from CS to Ee: ' num2str(Cse) ' bits/s']);
disp(['Overall capacity of wiretap channels: ' num2str(Cetotal) ' bits/s']);