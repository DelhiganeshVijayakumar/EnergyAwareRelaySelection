clf();
alpha = 0.4;
eta = 0.6;
gamma_I2 = 20;
sigma_sp = 0.2;
sigma_ps = 0.2;
sigma_sd = 0.5;
lambda_s = 0.5;
a = (alpha * eta) / (1 - alpha);
b = 2 * alpha * eta /(1-alpha);
Nv = 4;

theta = 0:0.05:1;
intercept_probabilities = zeros(size(theta));
intercept_probabilities_of_EAR = zeros(size(theta));
gamma_p1= 10^(5/10);
for i = 1:length(theta)

    
    intercept_probabilities(i) = calculateInterceptProbability(gamma_I2, sigma_sp, sigma_ps, lambda_s, a, gamma_p1, Nv);
    intercept_probabilities_of_EAR(i) =calculate_Intercept_Probability_Of_EAR(gamma_I2, a, theta(i), gamma_p, Nv,b);

end

semilogy(theta, intercept_probabilities, 'LineWidth', 2,Marker='>');
hold on;
semilogy(theta, intercept_probabilities_of_EAR, 'LineWidth', 2,Marker='+');
xlabel('\theta_{} ');
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
 

function intercept_probabilities_of_EAR = calculate_Intercept_Probability_Of_EAR(gamma_I2, a, theta, gamma_p, Nv,b)
    lambda_2 = 0.4/theta;
    sigma_ie = 0.2;
    sigma_pi = 0.2;
    sigma_ip = 0.2;
    A3 = lambda_2/(b*gamma_p*sigma_ie);
    A5 = lambda_2/(gamma_I2*sigma_ie);
    A7 = gamma_I2/(a*gamma_p);
    intercept_probabilities_of_EAR = 0;

    for m = 0:(Nv - 1)
        intercept_probabilities_of_EAR = intercept_probabilities_of_EAR + (((2*(A3)^m/(factorial(m)*sigma_pi))*((A3*sigma_pi)^((1-m)/2))*besselk(1-m,2*sqrt(A3*(1/sigma_pi)))) ...
            -((2*(A3)^m/(factorial(m)*sigma_pi))*(((A3+(A7*(sigma_ie)^-1))*sigma_pi)^((1-m)/2))*besselk(1-m,2*sqrt((A3+(A7*(sigma_ie)^-1))*(1/sigma_pi)))) ...
            + ((2*(A5)^m/(factorial(m)*sigma_pi))*(((A5+sigma_ip^-1)*A7*sigma_pi)^((1+m)/2))*besselk(1+m,2*sqrt((A5+(1/sigma_ip)*A7)*(1/sigma_pi)))));
    end
end