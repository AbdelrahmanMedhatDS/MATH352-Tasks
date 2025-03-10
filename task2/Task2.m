clc; clear; close all;

% Given parameters
t0 = 0;
tf = 2;
y0 = 1;
h = 0.04;

t = t0:h:tf;
n = length(t);

f = @(t, y) -50*y + sin(t);

% Runge-Kutta 4th Order Method
y_rk4 = zeros(1, n);
y_rk4(1) = y0;
for i = 1:n-1
    k1 = h * f(t(i), y_rk4(i));
    k2 = h * f(t(i) + h/2, y_rk4(i) + k1/2);
    k3 = h * f(t(i) + h/2, y_rk4(i) + k2/2);
    k4 = h * f(t(i) + h, y_rk4(i) + k3);
    y_rk4(i+1) = y_rk4(i) + (k1 + 2*k2 + 2*k3 + k4) / 6;
end

% Adams-Bashforth
y_ab2 = zeros(1, n);
y_ab2(1) = y0;
y_ab2(2) = y_rk4(2);
for i = 2:n-1
    y_ab2(i+1) = y_ab2(i) + h * (3*f(t(i), y_ab2(i)) - f(t(i-1), y_ab2(i-1))) / 2;
end

% Adams-Moulton
y_am2 = zeros(1, n);
y_am2(1) = y0;
y_am2(2) = y_rk4(2);
for i = 2:n-1
    predictor = y_am2(i) + h * (3*f(t(i), y_am2(i)) - f(t(i-1), y_am2(i-1))) / 2;
    y_am2(i+1) = y_am2(i) + h * (f(t(i+1), predictor) + f(t(i), y_am2(i))) / 2;
end

% Plot results
figure;
plot(t, y_rk4, 'b-', 'LineWidth', 1.5); hold on;
plot(t, y_ab2, 'r--', 'LineWidth', 1.5);
plot(t, y_am2, 'g-.', 'LineWidth', 1.5);
legend('Runge-Kutta 4', 'Adams-Bashforth 2', 'Adams-Moulton 2');
xlabel('Time t'); ylabel('Solution y(t)');
title('Comparison of Numerical Methods for Solving ODE');
grid on;
