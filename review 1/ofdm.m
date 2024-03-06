  % Parameters
num_symbols = 1000;        % Number of OFDM symbols
num_subcarriers = 64;      % Number of subcarriers in OFDM
snr_dB = 20;               % Signal-to-noise ratio in dB

% Generate random data for transmission
data = randi([0, 1], num_symbols, num_subcarriers);

% OFDM modulation
ofdm_symbols = ifft(data, [], 2);

% Relay
relay_gain = 0.5; % Gain of the relay channel
relay_symbols = relay_gain * ofdm_symbols;

% Add noise manually
noise_power = 10^(-snr_dB/10);
noise = sqrt(noise_power/2) * (randn(size(relay_symbols)) + 1i * randn(size(relay_symbols)));
received_symbols = relay_symbols + noise;

% OFDM demodulation at receiver
received_data = fft(received_symbols, [], 2);

% Display results
time_axis = (1:size(ofdm_symbols, 2)) / num_subcarriers;  % Time axis for visualization

figure;

subplot(3, 1, 1);
plot(time_axis, real(ofdm_symbols(1, :)));
title('OFDM Symbols at Sender');
xlabel('Time');
ylabel('Amplitude');

subplot(3, 1, 2);
plot(time_axis, real(relay_symbols(1, :)));
title('Relayed Symbols');
xlabel('Time');
ylabel('Amplitude');

subplot(3, 1, 3);
plot(time_axis, real(received_data(1, :)));
title('Received Symbols at Receiver');
xlabel('Time');
ylabel('Amplitude');

% BER calculation
ber = sum(sum(data ~= round(received_data))) / (num_symbols * num_subcarriers);
fprintf('Bit Error Rate (BER): %.4f\n', ber);
