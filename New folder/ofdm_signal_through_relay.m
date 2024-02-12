% Number of relay nodes
num_relays = 5;

% Generate random channel gains for each relay
channel_gains = rand(1, num_relays);

% Transmit OFDM signal from source to relays
source_signal = randi([0, 1], 1, 1024);  % Example OFDM signal, replace with your own
disp('Source Signal:')
disp(source_signal)

% Initialize variables to store received signals at relays
relay_received_signals = zeros(num_relays, length(source_signal));

% Simulate transmission to relay nodes
for i = 1:num_relays
    % Simulate channel effects (you can customize this based on your scenario)
    received_signal = source_signal * sqrt(channel_gains(i));
    relay_received_signals(i, :) = received_signal;
end

% Source selects optimal relay based on maximum received signal strength
[optimal_gain, optimal_relay_index] = max(channel_gains);

% Display information about the optimal relay
disp('Optimal Relay Information:')
disp(['Optimal Relay Index: ' num2str(optimal_relay_index)]);
disp(['Optimal Relay Gain: ' num2str(optimal_gain)]);

% Display received signals at each relay (for illustration purposes)
disp('Received Signals at Relays:')
disp(relay_received_signals)

% Simulate transmission from optimal relay to destination
destination_received_signal = relay_received_signals(optimal_relay_index, :);

% Display received signal at destination (for illustration purposes)
disp('Received Signal at Destination:')
disp(destination_received_signal)

% Plot the received signals at each relay
figure;
subplot(num_relays + 1, 1, 1);
plot(source_signal, 'b', 'LineWidth', 1.5);
title('Source Signal');
xlabel('Time (milliseconds)');
ylabel('Amplitude');

for i = 1:num_relays
    subplot(num_relays + 1, 1, i + 1);
    plot(relay_received_signals(i, :), 'r', 'LineWidth', 1.5);
    title(['Received Signal at Relay ' num2str(i)]);
    xlabel('Time (milliseconds)');
    ylabel('Amplitude');
end

% Plot the received signal at the destination
figure;
plot(destination_received_signal, 'g', 'LineWidth', 1.5);
title('Received Signal at Destination');
xlabel('Time (milliseconds)');
ylabel('Amplitude');
