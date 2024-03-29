%% Machine Learning - 
%
%     I think this file isn't working properly, remember to check before runnning it!
%
%     plotData.m
%     gradientDescent.m
%     computeCost.m
%     gradientDescentMulti.m
%     computeCostMulti.m
%     featureNormalize.m
%     normalEqn.m
%
%

%% Initialization

%% ================ Part 1: Feature Normalization ================

%% Clear and Close Figures
clear ; close all; clc

fprintf('Loading data ...\n');

%% Load Data
data = load('ex1data2.txt');
X = data(:, 1:2);
y = data(:, 3);
m = length(y);

% Print out some data points
fprintf('First 10 examples from the dataset: \n');
fprintf(' x = [%.0f %.0f], y = %.0f \n', [X(1:10,:) y(1:10,:)]');

fprintf('Program paused. Press enter to continue.\n');
pause;

% Scale features and set them to zero mean
fprintf('Normalizing Features ...\n');

[X mu sigma] = featureNormalize(X);

% Add intercept term to X
X = [ones(m, 1) X];


%% ================ Part 2: Gradient Descent ================

fprintf('Running gradient descent ...\n');

% Choose some alpha value
alpha = 0.01; 
num_iters = 100; 

% Init Theta and Run Gradient Descent 
theta = zeros(3, 1);
[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% Plot the convergence graph
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');

% Display gradient descent's result
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta);
fprintf('\n');

% Estimate the price of a 1650 sq-ft, 3 br house
price = [1 (1650-mu(1))/sigma(1) (3-mu(2))/sigma(2)]*theta; % You should change this

fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
         '(using gradient descent):\n $%f\n'], price);

fprintf('Program paused. Press enter to continue.\n');
pause;

% Plotting Training and regressioned data.
fprintf('Plotting Training and regressioned results by gradient descent.\n');
X = [ones(m, 1) data(:, 1:2)]; % denormalize features
figure;
plot3(X(:,2),X(:,3),y,"o");
xlabel('sq-ft of room');
ylabel('#bedroom');
zlabel('price');
grid;
hold on;
xx = linspace(0,5000,25);
yy = linspace(1,5,25);
zz = zeros(size(xx,2),size(yy,2));
for i=1:size(xx,2)
for j=1:size(yy,2)
  zz(i,j) = [1 (xx(i)-mu(1))/sigma(1) (yy(j)-mu(2))/sigma(2)]*theta;
end
end
mesh(xx,yy,zz);
title('Result of Gradient Descent');
legend('Training data', 'Linear regression');

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================ Part 3: Normal Equations ================

fprintf('Solving with normal equations...\n');

%% Load Data
data = csvread('ex1data2.txt');
X = data(:, 1:2);
y = data(:, 3);
m = length(y);

% Add intercept term to X
X = [ones(m, 1) X];

% Calculate the parameters from the normal equation
theta = normalEqn(X, y);

% Display normal equation's result
fprintf('Theta computed from the normal equations: \n');
fprintf(' %f \n', theta);
fprintf('\n');


% Estimate the price of a 1650 sq-ft, 3 br house
price = [1 1650 3]*theta; % You should change this


% ============================================================

fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
         '(using normal equations):\n $%f\n'], price);

fprintf('Program paused. Press enter to continue.\n');
pause;


% Plotting Training and regressioned data.
fprintf('Plotting Training and regressioned results by solving normal equation.\n');
figure;
plot3(X(:,2),X(:,3),y,"o");
xlabel('sq-ft of room');
ylabel('#bedroom');
zlabel('price');
grid;
hold on;
xx = linspace(0,5000,25);
yy = linspace(1,5,25);
zz = zeros(size(xx,2),size(yy,2));
for i=1:size(xx,2)
for j=1:size(yy,2)
  zz(i,j) = [1 xx(i) yy(j)]*theta;
end
end
mesh(xx,yy,zz);
title('Result of Solving Normal Equation');
legend('Training data', 'Linear regression');
