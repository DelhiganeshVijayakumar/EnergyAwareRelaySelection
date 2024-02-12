% Define parameters
lambda_1 = 0.1;
gamma_I1 = 20;
sigma_IP = 0.2;  % sigma_IP^2
sigma_ID = 0.5;
sigma_PI = 0.2;
sigma_KD = 0.5;
K1 = 1;
Dn = 1;
gamma_I1_values = linspace(0, 30, 100); 

A7 = 4 / sigma_PI * gamma_I1_values;  % epsilon7
A9 = 1 ./ (sigma_IP + lambda_1 ./ gamma_I1_values * sigma_IP);
A6 = 1 ./ (1 / sigma_ID + sum(1 ./ sigma_KD));

% Loop through different gamma_I1 values
for i = 1:length(gamma_I1_values) 
    % Calculate expressions
    expression1 = sqrt(gamma_I1_values(i) * A7(i) / sigma_IP) * K1 * sqrt(gamma_I1_values(i) * A7(i) / sigma_IP);
    expression2 = sigma_IP^(-2) * sqrt(gamma_I1_values(i) * A7(i) / A9(i)) * sqrt(A7(i) * A9(i) * gamma_I1_values(i)) * K1;
    expression3 = sum((-1).^Dn * A6 / sigma_ID) * sqrt(gamma_I1_values(i) * A7(i)) * sqrt(gamma_I1_values(i) * A7(i)) * K1;
    expression4 = sum((-1).^Dn * A6 / sigma_IP * sigma_IP);
    expression5 = sqrt(gamma_I1_values(i) * A7(i) / sigma_IP + lambda_1 * A7(i) / A6) * K1; 
    expression6 = sqrt(gamma_I1_values(i) * A7(i) / sigma_IP + lambda_1 * A7(i) / A6);
   
    % Calculate power NEAR scheme
    P_NEAR_OUT_1_2 = expression1 - expression2 + expression3 + expression4 * expression5 * expression6;
    P_NEAR_OUT_1_2_values(i) = P_NEAR_OUT_1_2;
end

% Display results
disp(['P_NEAR_OUT_1_2: ' num2str(P_NEAR_OUT_1_2)]);

% Plot the results using semilogy
semilogy(gamma_I1_values, P_NEAR_OUT_1_2_values, 'LineWidth', 2);
xlabel('gamma_I1 (dB)');
ylabel('P_NEAR_OUT_1_2');
title('Variation between gamma and P NEAR');
grid on; 