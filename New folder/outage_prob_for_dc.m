gamma_p_values = -10:0.1:30; % Range of gamma_p values
outage_probabilities = zeros(size(gamma_p_values));

% Calculate the outage probability for direct communication for each gamma_p value
for i = 1:length(gamma_p_values)
    gamma_p = gamma_p_values(i);
    % Replace the following line with the actual calculation using equation 30
    outage_probabilities(i) = calculateOutageProbability(gamma_p); % Replace with the actual calculation
end

% Plot the outage probability for direct communication in semilog scale
semilogy(gamma_p_values, outage_probabilities, 'LineWidth', 2);
xlabel('\gamma_{p} (dB)');
ylabel('Outage Probability');
title('Outage Probability for Direct Communication in Semilog Scale');
grid on;

function outage_probability = calculateOutageProbability(gamma_p1)
    % Define the parameters
    % Replace these with the actual values from your problem

    alpha = 0.4;
    eta = 0.6;
    gamma_I1 = 20;
    sigma_sp = 0.2;
    sigma_ps = 0.2;
    sigma_sd = 0.5;
    lambda_0 = 0.5;
    a = (alpha*eta)/( 1-alpha );
    epsilon_1 = 4/(a*gamma_p1*sigma_ps);
    epsilon_2 = (lambda_0/sigma_sd)+(gamma_I1/sigma_sp);

    % Calculate the outage probability using equation 30
    outage_probability = 1 - (sqrt(epsilon_1*lambda_0/sigma_sd) * besseli(2, sqrt(epsilon_1*lambda_0/sigma_sd))) - ((gamma_I1*sigma_sp)*sqrt(epsilon_1/epsilon_2) * besseli(2, sqrt(epsilon_1*epsilon_2)))+(sqrt(epsilon_1*epsilon_2)*besseli(2,sqrt(epsilon_1*epsilon_2)));
end

