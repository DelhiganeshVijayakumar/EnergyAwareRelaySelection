alpha = 0.4;
eta = 0.6;
gamma_I2 = 20;
sigma_sp = 0.2;
sigma_ps = 0.2;
sigma_sd = 0.5;
lambda_s = 0.5;
a = (alpha * eta) / (1 - alpha); 
Nv = 4;

theta = 0:0.05:1;
intercept_probabilities = zeros(size(theta));
gamma_p1= 10^(5/10);
for i = 1:length(theta)

    
    intercept_probabilities(i) = calculateInterceptProbability(gamma_I2, sigma_sp, sigma_ps, lambda_s, a, gamma_p1, Nv);

end

semilogy(theta, intercept_probabilities, 'LineWidth', 2,Marker='>');
xlabel('\theta_{} (dB)');
ylabel('Intercept Probability');
title('Intercept Probability for Direct Communication in Semilog Scale');
grid on;

function intercept_probability = calculateInterceptProbability(gamma_I2, sigma_sp, sigma_ps, lambda_s, a, gamma_p1, Nv)
    sigma_se = 0.5;
    A1 = lambda_s / (a * gamma_p1 * sigma_se);
    A2 = gamma_I2 * (a * gamma_p1 * sigma_sp);
    A3 = lambda_s / (gamma_I2 * sigma_se);
    A4 = lambda_s / (a * gamma_p1 * sigma_ps);

    intercept_probability = 0;

    for g = 0:(Nv - 1)
        intercept_probability = intercept_probability + ((2 * (A1^g) * (A1 * sigma_ps)^((1 - g) / 2) / (factorial(g) * sigma_ps)) * besselk(1 - g, 2 * sqrt(A1 / sigma_ps)) - (2 * (A1^g) * ((A1 + A2) * sigma_ps)^((1 - g) / 2) / (factorial(g) * sigma_ps)) * besselk(1 - g, 2 * sqrt((A1 + A2) / sigma_ps)) + (2 * (A3^g) * (A4 / (A3 + 1 / sigma_sp))^((1 + g) / 2) / (factorial(g) * sigma_ps)) * besselk(1 + g, 2 * sqrt(A4 * (A3 + 1 / sigma_sp))));
    end
end
 