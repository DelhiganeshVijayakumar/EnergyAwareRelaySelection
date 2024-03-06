clf();
alpha = 0.4;
eta = 0.6;
theta=0.8;
gamma_I1=0.1 ;
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

lambda_0 = 0.4;
a = (alpha * eta) / (1 - alpha); 
b = 2 * alpha * eta /(1-alpha);
 


gamma_p_values = 0:1:30;
outage_probabilities_of_DC = zeros(size(gamma_p_values));
outage_probabilities_of_NEAR = zeros(size(gamma_p_values));

for i = 1:length(gamma_p_values)

    gamma_p1 = gamma_p_values(i);
    outage_probabilities_of_DC(i) = calculate_Outage_Probability_Of_DC(gamma_p1, gamma_I1,sigma_ps,a,lambda_0,sigma_sd,sigma_sp);
    outage_probabilities_of_NEAR(i) = calculate_Outage_Probability_Of_NEAR(gamma_I1, lambda_0, gamma_p1,b);
    
end

semilogy(gamma_p_values, outage_probabilities_of_DC, 'LineWidth', 2,Marker='o');

hold on;
semilogy(gamma_p_values,outage_probabilities_of_NEAR,'LineWidth',2,Marker='+');
xlabel('\gamma_{p} (dB)');
ylabel('Outage Probability');
title('Outage Probability vs SNR');
grid on;

function outage_probabilities_of_DC = calculate_Outage_Probability_Of_DC(gamma_p1, gamma_I1,sigma_ps,a,lambda_0,sigma_sd,sigma_sp)
    epsilon_1 = 4/(a*gamma_p1*sigma_ps);
    epsilon_2 = (lambda_0/sigma_sd)+(gamma_I1/sigma_sp); 
    outage_probabilities_of_DC = 1 - sqrt(epsilon_1*lambda_0/sigma_sd) * besselk(1, sqrt(epsilon_1*lambda_0/sigma_sd)) - (gamma_I1*sigma_sp)*sqrt(epsilon_1/epsilon_2) * besselk(1, sqrt(epsilon_1*epsilon_2))+(sqrt(epsilon_1*epsilon_2)*besselk(1,sqrt(epsilon_1*epsilon_2)));

end

    

function outage_probabilities_of_NEAR = calculate_Outage_Probability_Of_NEAR(gamma_I1, lambda_0, gamma_p1,b)
Dn = [5 6 7 10];
DN = length(Dn);
sigma_id = 0.5;
sigma_ip = 0.1;
sigma_p1=0.1 ;
sigma_kd=0.2;
sigma_pi=0.2;
lambda_1=lambda_0;

A5 = 4/(b*gamma_p1*sigma_id*sigma_p1);

A6 =  1/(1/sigma_id + 1/sigma_kd);

A7 =  4/(b*gamma_p1*sigma_p1);

A8 =  (sigma_id * gamma_I1 * A5 /sigma_ip) + (4*lambda_1/(b*gamma_p1*sigma_p1*A6));

A9 = 1/sigma_ip + (lambda_1 / (gamma_I1 * sigma_id));
    
term_1 = 1 - (sqrt(A5*lambda_1)*besselk(1,sqrt(A5*lambda_1))) - (sqrt(gamma_I1*A7/sigma_ip)*besselk(1,sqrt(gamma_I1*A7/sigma_ip))) + (sqrt(A7*(gamma_I1/sigma_ip + lambda_1/sigma_id))*besselk(1,sqrt(A7*(gamma_I1/sigma_ip + lambda_1/sigma_id))));

term_5 = (sqrt(gamma_I1*A7/sigma_ip)*besselk(1,sqrt(gamma_I1*A7/sigma_ip))) - (1/sigma_ip)*(sqrt(gamma_I1*A7/A9)*besselk(1,gamma_I1*A7*A9));

term_2=0;term_3=0;term_4=0;term_6=0;term_7=0;

for m=1:DN

term_2 = term_2 + ((-1)^abs(Dn(m)))*A6/sigma_id * (1-(sqrt(4*lambda_1/(b*gamma_p1*A6*sigma_pi))*besselk(1,sqrt(4*lambda_1/(b*gamma_p1*A6*sigma_pi)))));

term_3 = term_3 + ((-1)^abs(Dn(m)))*A6/sigma_id * (sqrt(gamma_I1*A5)*besselk(1,gamma_I1*A5));

term_4 = term_4 + ((-1)^abs(Dn(m)))*A6/sigma_id * (sqrt(A8)*besselk(1,A8));

term_6 = term_6 + ((-1)^abs(Dn(m)))*A6/sigma_id * (sqrt(gamma_I1*A7)*besselk(1,gamma_I1*A7));

term_7 = term_7 + ((-1)^abs(Dn(m)))*A6/(sigma_id*sigma_ip) * (sqrt((gamma_I1*A7/sigma_ip)+(lambda_1*A7/A6))*besselk(1,sqrt((gamma_I1*A7/sigma_ip)+(lambda_1*A7/A6))));

end

outage_probabilities_of_NEAR = term_1 + term_2 + term_3 + term_4 + term_5 + term_6 + term_7;

end 
