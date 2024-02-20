Nr = 4; % Number of relays
gamma_p = 5; % SNR threshold
alpha = 0.4;
eta = 0.6;
theta = 0.8;
gamma_I = 20;
sigma_sd = 0.5;
sigma_si = 0.5;
sigma_id = 0.5;
sigma_ps = 0.2;
sigma_pi = 0.2;
sigma_ip = 0.2;
sigma_sp = 0.2;
sigma_ie = 0.1;
sigma_se = 0.1;
sigma_J1 = 0.4;
sigma_J2 = 0.4;
sigma_Ji = 0.4;
T = 1;
Nv = 1;

% Calculation of Outage Probability for NEARS with average interference
lambda_0 = 2 * (1 - alpha) * T * (gamma_p^2) - 1;
R0 = (lambda_0 + 1) / (2 * (1 - alpha) * T);

% Implement Equations (47) and (48) for NEARS
P_NEARS_int = 0; % Initialize the outage probability for NEARS with average interference

for n = 1:Nr
    % Calculation of P_NEARS_int for each relay n based on Equation (50)
    P_NEARS_int_n = 1;
    for i = 1:Nr
        if i ~= n
            % Calculate the probability term P_NEARS_int_I 1 for relay i
            P_NEARS_int_I1 = 1 - normcdf(sqrt(gamma_p^2) / sqrt(sigma_ip^2 + sigma_sp^2), 0, 1);
            
            % Calculate the probability term P_NEARS_int_I 2 for relay i
            P_NEARS_int_I2 = normcdf(sqrt(gamma_I^2) / sqrt(sigma_id^2), 0, 1) - normcdf(sqrt(gamma_p^2) / sqrt(sigma_ip^2), 0, 1);
            
            % Update P_NEARS_int_n based on Equations (50) and (48)
            P_NEARS_int_n = P_NEARS_int_n * (1 - P_NEARS_int_I1) * P_NEARS_int_I2;
        end
    end
    
    % Update the overall outage probability for NEARS with average interference
    P_NEARS_int = P_NEARS_int + P_NEARS_int_n;
end

% Display the calculated Outage Probability for NEARS with average interference
disp(['Outage Probability for NEARS with average interference: ', num2str(P_NEARS_int)]);

 