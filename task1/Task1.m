clc; clear; close all;

% Parameters
t0 = 0; tf = 2; y0 = 1; h = 0.04;
t = t0:h:tf;
n = length(t);

% Function definition
dy = @(t, y) -50*y + sin(t);

% Forward Euler Method
y_FE = zeros(1, n); y_FE(1) = y0;
for i = 1:n-1
    y_FE(i+1) = y_FE(i) + h * dy(t(i), y_FE(i));
end

% Modified Euler Method (Heun's Method)
y_ME = zeros(1, n); y_ME(1) = y0;
for i = 1:n-1
    y_pred = y_ME(i) + h * dy(t(i), y_ME(i));
    y_ME(i+1) = y_ME(i) + (h/2) * (dy(t(i), y_ME(i)) + dy(t(i+1), y_pred));
end

% Backward Euler Method
y_BE = zeros(1, n); y_BE(1) = y0;
for i = 1:n-1
    y_BE(i+1) = (y_BE(i) + h * sin(t(i+1))) / (1 + 50*h);
end

% Plot the results
figure; hold on;
plot(t, y_FE, 'r', 'LineWidth', 1.5);
plot(t, y_ME, 'b', 'LineWidth', 1.5);
plot(t, y_BE, 'g', 'LineWidth', 1.5);
legend('Forward Euler', 'Modified Euler', 'Backward Euler');
xlabel('Time (t)'); ylabel('y(t)');
title('Comparison of Euler Methods');
grid on;

