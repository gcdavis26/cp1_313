clc 
clear

%x''+.2x'+4x = 1
x = [0,0]; %Initial values. x(:,1) are x, x(:,2) are x'
f = @(t,x) [x(:,2),1 - 4* x(:,1) - .2 * x(:,2)]; %Explained below
%{
This is the derivative function of x vector, aka x' and x''.
x' is just x(:,2), as mentioned above. By rearranging the differential
equation, we can solve for x'' in terms of x and x', aka x(:,1) and 
x(:,2). All this does is break down a 2nd order ODE into 2 first order 
ODEs.
%}
start_time = 0; %t = 0 to start
end_time = 8; %Last evaluated at t = 8
h = .1; %Step size
%In the for loop below, we will be predicting future terms, which is why
%the bounds are from 0 to 8-h: Predicting 2nd term, to predicting the last
%term
for t = 0:h:8-h 
    element = round(t/h + 1); %Index to use for current element
    next = element + 1; %Index to use for next element (prediction)
    k1 = f(t, x(element,:)); %k1 from RK2
    k2 = f(t + h/2, x(element,:) + h/2 * k1); %k2 from RK2
    x(next, :) = x(element, :) + h * k2; %Next values
end

times = (0:h:8); %Time on x axis
plot(times, x(:,1)') %Plotting RK2
hold on %Allowing more plots
%End of RK2
%%%%%%%%%%%%%%%%%

%Analytic
omega = 2; %Givens 
sigma = .05; 
omegad = omega * sqrt(1-sigma^2);
T0 = 1;

%This is just my analytic solution, subbing stuff in 
x_exact = T0/omega^2 - exp(-omega*sigma.*times) .* (cos(omegad .* times) ...
    / omega^2 +sigma/(omega .* omegad) * sin(omegad .* times));
plot(times, x_exact) %Plotting 
%End of Analytic
%%%%%%%%%%%%%%%%

%ODE45
options = odeset(RelTol=1e-3, AbsTol=1e-6); %Setting tolerances

f_vector = @(t,y) [y(2,:);1 - 4*y(1,:) - .2 * y(2,:)]; 
% Original f function was using row vectors, which isn't compatible 

[t, x_ode45] = ode45(f_vector, [start_time end_time], x(1,:),options)
plot(t,x_ode45(:,1)) %Plotting

legend("RK2", "Analytical Solution", "ODE45") %Legend because pretty 

%End of 2.2
%%%%%%%%%%%%%%%%%

%Start of 2.3 