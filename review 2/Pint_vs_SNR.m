clf();
alpha = 0.4;
eta = 0.6;
theta=0.8;
gamma_I=10^(20/10);
gamma_I2 = 10^(20/10);
sigma_sd = 0.5;
sigma_si = 0.5;
sigma_id = 0.5;
sigma_ps = 0.2;
sigma_j1 = 0.2;
sigma_j2 = 0.2;
sigma_ji = 0.2;
sigma_ip = 0.2;
sigma_sp = 0.2;
MER = 10^(10/10);
T = 1;
Nr = 4;
Nv = 4;

lambda_s = 0.7;
a = (alpha * eta) / (1 - alpha); 
b = 2 * alpha * eta /(1-alpha);
 


gamma_p_values = 0:2:30;
intercept_probabilities_of_DC = zeros(size(gamma_p_values));
intercept_probabilities_of_EAR = zeros(size(gamma_p_values));
intercept_probabilities_of_NEAR = zeros(size(gamma_p_values));

for i = 1:length(gamma_p_values)

    gamma_p1 = gamma_p_values(i);
    intercept_probabilities_of_DC(i) = calculate_Intercept_Probability_Of_DC(gamma_I2, sigma_sp, sigma_ps, lambda_s, a, gamma_p1, Nv);
    intercept_probabilities_of_EAR(i) = calculate_Intercept_Probability_Of_EAR(gamma_I2, lambda_s, a, gamma_p1, Nv,b);
    intercept_probabilities_of_NEAR(i) = calculate_Intercept_Probability_Of_NEAR(gamma_I2, lambda_s, a, gamma_p1, Nv,b);
end

semilogy(gamma_p_values, intercept_probabilities_of_DC, 'LineWidth', 2,Marker='o',DisplayName='Curve name for the legend');
hold on;
%semilogy(gamma_p_values,intercept_probabilities_of_EAR,'LineWidth',2,Marker='+');
semilogy(gamma_p_values,intercept_probabilities_of_NEAR,'LineWidth',2,Marker='square');
legend('IP(DC)','IP(EARS)','Location','east');
xlabel('\gamma_{p} (dB)');
ylabel('Intercept Probability');
title('Intercept Probability Vs SNR');
grid on;

function intercept_probabilities_of_DC = calculate_Intercept_Probability_Of_DC(gamma_I2, sigma_sp, sigma_ps, lambda_s, a, gamma_p, Nv)
    sigma_se = 0.3;
    A1 = lambda_s / (a * gamma_p * sigma_se);
    A2 = gamma_I2 * (a * gamma_p * sigma_sp);
    A3 = lambda_s / (gamma_I2 * sigma_se);
    A4 = lambda_s / (a * gamma_p * sigma_ps);

    intercept_probabilities_of_DC = 0;

    for g = 0:(Nv - 1)
        intercept_probabilities_of_DC = intercept_probabilities_of_DC + ((2 * (A1^g) * (A1 * sigma_ps)^((1 - g) / 2) / (factorial(g) * sigma_ps)) * besselk(1 - g, 2 * sqrt(A1 / sigma_ps)) - (2 * (A1^g) * ((A1 + A2) * sigma_ps)^((1 - g) / 2) / (factorial(g) * sigma_ps)) * besselk(1 - g, 2 * sqrt((A1 + A2) / sigma_ps)) + (2 * (A3^g) * (A4 / (A3 + 1 / sigma_sp))^((1 + g) / 2) / (factorial(g) * sigma_ps)) * besselk(1 + g, 2 * sqrt(A4 * (A3 + 1 / sigma_sp))));
    end
end

function intercept_probabilities_of_EAR = calculate_Intercept_Probability_Of_EAR(gamma_I2, lambda_s, a, gamma_p, Nv,b)
    
    sigma_ie = 0.1;
    sigma_pi = 0.2;
    sigma_ip = 0.2;
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

function intercept_probabilities_of_NEAR = calculate_Intercept_Probability_Of_NEAR(gamma_I2, lambda_s, a, gamma_p, Nv,b)
    
    sigma_ie = 0.09;
    sigma_pi = 0.2;
    sigma_ip = 0.2;
    A3 = lambda_s/(b*gamma_p*sigma_ie);
    A5 = lambda_s/(gamma_I2*sigma_ie);
    A7 = gamma_I2/(a*gamma_p);
    intercept_probabilities_of_NEAR = 0;

    for m = 0:(Nv - 1)
        intercept_probabilities_of_NEAR = intercept_probabilities_of_NEAR + (((2*(A3)^m/(factorial(m)*sigma_pi))*((A3*sigma_pi)^((1-m)/2))*besselk(1-m,2*sqrt(A3*(1/sigma_pi)))) -((2*(A3)^m/(factorial(m)*sigma_pi))*(((A3+(A7*(sigma_ie)^-1))*sigma_pi)^((1-m)/2))*besselk(1-m,2*sqrt((A3+(A7*(sigma_ie)^-1))*(1/sigma_pi)))) + ((2*(A5)^m/(factorial(m)*sigma_pi))*(((A5+sigma_ip^-1)*A7*sigma_pi)^((1+m)/2))*besselk(1+m,2*sqrt((A5+(1/sigma_ip)*A7)*(1/sigma_pi)))));
    end
end

