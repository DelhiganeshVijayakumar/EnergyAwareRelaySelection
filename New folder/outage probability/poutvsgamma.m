clf();
alpha = 0.4;
eta = 0.6;
theta=0.8;
gamma_I1=20;
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

lambda_0 = 0.2;
a = (alpha * eta) / (1 - alpha); 
b = 2 * alpha * eta /(1-alpha);
 


gamma_p_values = 0:1:30;
outage_probabilities_of_DC = zeros(size(gamma_p_values));
% intercept_probabilities_of_EAR = zeros(size(gamma_p_values));

for i = 1:length(gamma_p_values)

    gamma_p1 = gamma_p_values(i);
    outage_probabilities_of_DC(i) = calculate_Outage_Probability_Of_DC(gamma_p1, gamma_I1,sigma_ps,a,lambda_0,sigma_sd,sigma_sp);
%     intercept_probabilities_of_EAR(i) = calculate_Intercept_Probability_Of_EAR(gamma_I2, lambda_s, a, gamma_p1, Nv,b);
end

semilogy(gamma_p_values, outage_probabilities_of_DC, 'LineWidth', 2,Marker='o');
% hold on;
% semilogy(gamma_p_values,intercept_probabilities_of_EAR,'LineWidth',2,Marker='+');
xlabel('\gamma_{p} (dB)');
ylabel('Intercept Probability');
title('Intercept Probability for Direct Communication in Semilog Scale');
grid on;

function outage_probabilities_of_DC = calculate_Outage_Probability_Of_DC(gamma_p1, gamma_I1,sigma_ps,a,lambda_0,sigma_sd,sigma_sp)
    epsilon_1 = 4/(a*gamma_p1*sigma_ps);
    epsilon_2 = (lambda_0/sigma_sd)+(gamma_I1/sigma_sp); 
    outage_probabilities_of_DC = 1 - (sqrt(epsilon_1*lambda_0/sigma_sd) * besseli(1, sqrt(epsilon_1*lambda_0/sigma_sd))) - ((gamma_I1*sigma_sp)*sqrt(epsilon_1/epsilon_2) * besseli(1, sqrt(epsilon_1*epsilon_2)))+(sqrt(epsilon_1*epsilon_2)*besseli(1,sqrt(epsilon_1*epsilon_2)));

end

% 
% function intercept_probabilities_of_EAR = calculate_Intercept_Probability_Of_EAR(gamma_I2, lambda_s, a, gamma_p, Nv,b)
%     
%     sigma_ie = 0.2;
%     sigma_pi = 0.2;
%     sigma_ip = 0.2;
%     A3 = lambda_s/(b*gamma_p*sigma_ie);
%     A5 = lambda_s/(gamma_I2*sigma_ie);
%     A7 = gamma_I2/(a*gamma_p);
%     intercept_probabilities_of_EAR = 0;
% 
%     for m = 0:(Nv - 1)
%         intercept_probabilities_of_EAR = intercept_probabilities_of_EAR + (((2*(A3)^m/(factorial(m)*sigma_pi))*((A3*sigma_pi)^((1-m)/2))*besselk(1-m,2*sqrt(A3*(1/sigma_pi)))) ...
%             -((2*(A3)^m/(factorial(m)*sigma_pi))*(((A3+(A7*(sigma_ie)^-1))*sigma_pi)^((1-m)/2))*besselk(1-m,2*sqrt((A3+(A7*(sigma_ie)^-1))*(1/sigma_pi)))) ...
%             + ((2*(A5)^m/(factorial(m)*sigma_pi))*(((A5+sigma_ip^-1)*A7*sigma_pi)^((1+m)/2))*besselk(1+m,2*sqrt((A5+(1/sigma_ip)*A7)*(1/sigma_pi)))));
%     end
% end
