%% Stoch Project 2: Theo Song, Leon Fang
%% Scenario 1 
clc; clear all; close all;
% Implement the Bayes MMSE and Linear MMSE estimators from examples 8.5 and 8.6. 
% Simulate this system by random draws of Y and W, and then estimating Y from the observations X = Y + W. 
% Verify that your simulation is correct by comparing theoretical and empirical values of the MSE. Report your results in a table.

% Example 8.5
N = 10000;
% Creating Y and W which are uniformly distributed 
% Y ~ U(-1,1)
% W ~ U(-2,2)
Y = randi([-10000, 10000], 1, N) / 10000;
W = randi([-20000, 20000], 1, N) / 10000;
% X is the observation
X = Y + W;

MMSE_Bayes = zeros(1,N);

for i = 1:N
    MMSE_Bayes(i) = estimator(X(i));
end

MSE_empirical = mean((Y-MMSE_Bayes).^2);
% given from the notes
MSE_theoretical = 1/4;

% Example 8.6
LMMSE = X/5;
LMSE_empirical = mean((Y-LMMSE).^2);
% given from the notes
LMSE_theoretical = 4/15;

% MSE value when using the expected value of Y as the estimator
% given from the notes
MSE_EY = 1/3;

T = table(MSE_EY, MSE_empirical, MSE_theoretical, LMSE_empirical, LMSE_theoretical)
% As could be seen from the table, by using the Bayes MMSE and Linear MMSE 
% estimators, the MSE improved, compared to the MSE, when purely using the
% expected value of Y. Although the implemenation of the LMMSE was easier 
% than the Bayes MMSE, the Bayes MMSE method showed a better MSE. 

% And both method's theoretical and empirical values seemed to match more 
% as the number of iteration increased.



%% Scenario 2
clc; clear all; close all;
% Implement the linear estimator for multiple noisy observations, similar to example 8.8 from the notes. 
% Extend this example so that it works for an arbitrary number of observations. 
% Use Gaussian random variables for Y and R. Set μy = 1. Experiment with a few different variances for both Y and R. 
% On one plot, show the mean squared error of your simulation compared to the theoretical values for at least 2 different pairs of variances.

N = 100000;    %number of iteration
Obv = 50;      %number of observation starting from 2

% making empty array for plotting
Obv_plot = zeros(1,Obv);
MSE_multi_empirical = zeros(1,Obv);
MSE_multi_theoretical = zeros(1,Obv);

figure;
% Creating different pairs of variance for Y and R
for j = 1:4
    if j == 1
        Y_variance = 0.1;
        R_variance = 0.1;
    elseif j == 2
        Y_variance = 0.1;
        R_variance = 0.9;
    elseif j == 3
        Y_variance = 0.9;
        R_variance = 0.1;
    else
        Y_variance = 0.9;
        R_variance = 0.9;
    end
    % Normal distribution which is the same as Gaussian distribution
    % mean of 1 for Y
    Y_mean = 1;
    % Generating Y with given variance
    Y = Y_variance.*randn(1,N);

    for i = 2:1:Obv
        % i stand for number of observation
        % zero mean for R
        R = R_variance.*randn(i,N);

        % 1 column represents 1 itertation of the simulation
        % number of rows represents the number of observation in one simulation
        % X is the observation
        X = R + Y;

        % Generalized linear estimator formula for multiple observations
        Y_hat = (1/((i*Y_variance)+R_variance))*((R_variance*Y_mean)+Y_variance*sum(X));

        Obv_plot(i) = i;
        % Computing the MSE for both theoretical and empirical
        MSE_multi_empirical(i) = mean((Y-Y_hat).^2);
        MSE_multi_theoretical(i) = (Y_variance*R_variance)/((i*Y_variance)+(R_variance));
    end

    hold on;
    plot(Obv_plot(2:end), MSE_multi_theoretical(2:end))
    hold on;
    plot(Obv_plot(2:end), MSE_multi_empirical(2:end))
    
end

% By looking at the for different pairs of variance, we could see that as
% the variance of the signal(Y) increases, the MSE of the theoretical and
% empirical value tended to match even with a small number of observation.
% And as the variance of the Noise(R) increased, the value of MSE of both
% theoretical and empirical increased generally throughout different number
% of observations

legend('theoreitcal var(Y):0.1 var(R):0.1', 'empirical var(Y):0.1 var(R):0.1', 'theoreitcal var(Y):0.1 var(R):0.9', 'empirical var(Y):0.1 var(R):0.9', 'theoreitcal var(Y):0.9 var(R):0.1', 'empirical var(Y):0.9 var(R):0.1', 'theoreitcal var(Y):0.9 var(R):0.9', 'empirical var(Y):0.9 var(R):0.9');
ylim([0 0.5]);
title('LMSE for Multiple Observations');
xlabel('Number of Observation');
ylabel('MSE');


%% Bayes MMSE estimator function for each value of X
function result = estimator(x)
    if x < -1
        result = 1/2 + (1/2)*x;
    elseif x >= 1 
        result = -1/2 + (1/2)*x;
    else
        result = 0;
    end
end