alpha = 0.4;
n = 0.6;
sigma_IP = 0.2;  % sigma_IP^2
sigma_ID = 0.5;
sigma_PI = 0.2;
sigma_KD = 0.5;
teta = 0.8;
no = 4;
pp = 1
T = 1;
r0 = 1;
gamma_0 = 2^(2*r0 / (1-alpha)*T) - 1;
sigma_j1 = 0.2;
nj1 = no + pp*sigma_j1;
gamma_I1 = 1 / nj1;
lambda_1 = gamma_0 / teta;
dn = 1;
b = 2*alpha*n / 1-alpha;
gamma_I1_values = linspace(-10,30,100);

% Calculate the range limit
m_limit = 2^abs(dn) - 1;
A7 = 4 / b*sigma_PI*gamma_I1;
A6 = sqrt(gamma_I1*A7 / sigma_IP) * besseli(1,sqrt(gamma_I1*A7 / sigma_IP)) - sqrt(A7 * sum(gamma_I1/sigma_IP + lambda_1/sigma_ID)) * besseli(1, sqrt(A7 * sum(gamma_I1/sigma_IP + lambda_1/sigma_ID)));  % epsilon7
A9 = sum((1 / sigma_IP) + (lambda_1 / gamma_I1 * sigma_IP));
% Initialize the sum
totalsum1 = 0;
totalsum2 = 0;
% Perform the summation
for m = 1:m_limit
    totalsum1 = totalsum1 + (-1)^dn * A6 / sigma_ID;
end
for m = 0:m_limit
    totalsum2 = totalsum2 + (-1)^dn * A6 / sigma_IP * sigma_KD;
end

  
   
% Loop through different gamma_I1 values
for i = 1:length(gamma_I1_values)  
    % Calculate expressions
    expression1 = sqrt(gamma_I1_values(i)*A7 / sigma_IP) * besseli(1,sqrt(gamma_I1_values(i) * A7 / sigma_IP));
    expression2 = sigma_IP^(-2) * sqrt(gamma_I1_values(i)*A7 / A9) * besseli(1,sqrt(A7 * A9 * gamma_I1_values(i))) ;
    expression3 = totalsum1 * sqrt(gamma_I1_values(i) * A7) * besseli(1,sqrt(gamma_I1_values(i) * A7))  ;;
    expression4 = totalsum2 * sqrt(gamma_I1_values(i) * A7 / sigma_IP + lambda_1 * A7 / A6) * besseli(1,sqrt(gamma_I1_values(i)* A7 / sigma_IP + lambda_1*A7 / A6));;
   
    % Calculate power NEAR scheme
    P_NEAR_OUT_1_2 = expression1 - expression2 + expression3 - expression4;
    P_NEAR_OUT_1_2_values(i) = P_NEAR_OUT_1_2;
end

% Display results
disp(['P_NEAR_OUT_1_2: ' num2str(P_NEAR_OUT_1_2)]);

% Plot the results using semilogy
semilogy(gamma_I1_values, P_NEAR_OUT_1_2_values);
xlabel('gamma_I1 (dB)');
ylabel('P_NEAR_OUT_1_2');
title('Variation between gamma and P NEAR');
grid on;