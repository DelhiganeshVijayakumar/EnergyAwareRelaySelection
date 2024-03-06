
alpha = 0.4; % Fading coefficient
T = 1; % Time slot duration
Nr = 4; % Number of relays
N0 = 1; % Noise power
Pp = 10; % Transmit power of the primary transmitter
sigma_sqJ1 = 0.5; % Noise power at the destination
sigma_sqJ2 = 0.6; % Noise power at the eavesdroppers
eta = 0.6;          % Energy conversion efficiency
theta = 0.8; % Remaining ratio of total harvested energy for transmitting information
I = 0.3; % Interference power (in Watts)

% Channel gains
h_ps = 0.8; % Channel gain of PT-CS
h_sp = 0.8; % Channel gain of CS-PT
h_pi = [0.9, 0.7, 0.6, 0.5]; % Channel gains of PT-CRi (assuming 4 relays)
h_id = 0.8; % Channel gain of CRi-CD
h_ie = [0.9, 0.7, 0.6]; % Channel gains of CRi-Ee (assuming 3 eavesdroppers)
h_ip = 0.8;  % Channel Gain of CRi=PD
h_si = 0.8 ; %Channel gain of CS-CRi

% Energy harvested by CS and CRi
Es = alpha * eta * T * Pp * abs(h_ps)^2;
Ei = alpha * eta * T * Pp * sum(abs(h_pi).^2);

% Transmit powers of CS and CRi 
b=2*alpha*eta/(1-alpha);
Ps = min(b * Pp * abs(h_ps)^2, I / abs(h_sp)^2);
Pi = theta * min(b * Pp * sum(abs(h_pi).^2), I / abs(h_ip)^2);

% Capacity of the CS-CRi channel
N_J1 = N0+Pp* sigma_sqJ1;
C_si = (1 - alpha) * T / 2 * log2(1 + Ps*abs(h_si)^2 / N_J1);

% Capacity of the CRi-CD channel 
C_id = (1 - alpha) * T / 2 * log2(1 + Pi * abs(h_id)^2 / N_J1);

% Capacity of the CRi-Ee channel 
N_J2 = N0+Pp* sigma_sqJ2;
C_ie = (1 - alpha) * T / 2 * log2(1 + Pi * sum(abs(h_ie).^2) / N_J2);

% Display the results
disp(['Energy harvested by CS: ' num2str(Es)]);
disp(['Energy harvested by CRi: ' num2str(Ei)]);
disp(['Transmit power of CS: ' num2str(Ps)]);
disp(['Transmit power of CRi: ' num2str(Pi)]);
disp(['Capacity of the CS-CRi channel: ' num2str(C_si)]);
disp(['Capacity of the CRi-CD channel: ' num2str(C_id)]);
disp(['Capacity of the CRi-Ee channel: ' num2str(C_ie)]);