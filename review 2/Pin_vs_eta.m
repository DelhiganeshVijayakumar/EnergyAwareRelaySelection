clf();
alpha = 0.4;
eta = 0:0.05:1;
gamma_I2 = 100;
sigma_sp = 0.2;
sigma_ps = 0.2;
sigma_sd = 0.5;
lambda_s = 0.5;
  
Nv = 4;

intercept_probabilities = zeros(size(eta));
intercept_probabilities_of_EAR = zeros(size(eta));
gamma_p= 10^(5/10);
for i = 1:length(eta)
    a = (alpha * eta(i)) / (1 - alpha);
    b = 2 * alpha * eta(i) /(1-alpha);

    
    intercept_probabilities(i) = calculateInterceptProbability(gamma_I2, sigma_sp, sigma_ps, lambda_s, a, gamma_p, Nv);
    intercept_probabilities_of_EAR(i) = calculate_Intercept_Probability_Of_EAR(gamma_I2, lambda_s, a, gamma_p, Nv,b);
end
 
semilogy(eta, intercept_probabilities, 'LineWidth', 2,Marker='>');
hold on;
semilogy(eta, intercept_probabilities_of_EAR, 'LineWidth', 2,Marker='+');
xlabel('\eta_{}');
ylabel('Intercept Probability');
title('Intercept Probability vs energy conversion efficiency');
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

function intercept_probabilities_of_EAR = calculate_Intercept_Probability_Of_EAR(gamma_I2, lambda_s, a, gamma_p, Nv,b)
    
    sigma_ie = 0.2;
    sigma_pi = 0.2;
    sigma_ip = 0.5;
    A3 = lambda_s/(b*gamma_p*sigma_ie);
    A5 = lambda_s/(gamma_I2*sigma_ie);
    A7 = gamma_I2/(a*gamma_p);
    intercept_probabilities_of_EAR = 0;

    for m = 0:(Nv - 1)
        intercept_probabilities_of_EAR = intercept_probabilities_of_EAR + (((2*(A3)^m/(factorial(m)*sigma_pi))*((A3*sigma_pi)^((1-m)/2))*besselk(1-m,2*sqrt(A3*(1/sigma_pi)))) ...
            -((2*(A3)^m/(factorial(m)*sigma_pi))*(((A3+(A7*(sigma_ie)^-1))*sigma_pi)^((1-m)/2))*besselk(1-m,2*sqrt((A3+(A7*(sigma_ie)^-1))*(1/sigma_pi)))) ...
            + ((2*(A5)^m/(factorial(m)*sigma_pi))*(((A5+sigma_ip^-1)*A7*sigma_pi)^((1+m)/2))*besselk(1+m,2*sqrt((A5+(1/sigma_ip)*A7)*(1/sigma_pi)))));
    end
end
 