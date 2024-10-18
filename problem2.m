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

[t, x_ode45] = ode45(f_vector, [start_time end_time], x(1,:),options);
plot(t,x_ode45(:,1)) %Plotting

legend("RK2", "Analytical Solution", "ODE45") %Legend because pretty 
title("Comparing ODE Methods Part 2.2")
xlabel("t")
ylabel("x")
hold off
%End of 2.2
%%%%%%%%%%%%%%%%%

%Start of 2.3 
clc
clear 
figure(2)

%This code is just copied from the above part

omega = 2; 
sigma = .05; 
omegad = omega * sqrt(1-sigma^2);
T0 = 1;

f = @(t,x_rk2) [x_rk2(:,2),1 - 4* x_rk2(:,1) - .2 * x_rk2(:,2)];
error = zeros([1,4]);
iter = 0; %Used to access error matrix within the loop

%{
Essentially all that's happening here is that we're running the code from 
2.2, except throwing it all into a for loop and change the step size every
time. At the end of every iteration of the outer loop, we find the norm
of the error, which is the matrix subtraction of x_rk2 from the analytical
values. 
%}


for h = [.1 .05 .025 .0125] %Looping through different step sizes
    iter = iter + 1; %Used to count iterations to index into error matrix
    x_rk2 = [0,0];
    times = 0:h:8;
    x_exact = T0/omega^2 - exp(-omega*sigma.*times) .* (cos(omegad .* times) ...
    / omega^2 +sigma/(omega .* omegad) * sin(omegad .* times));
    for t = 0:h:8-h 
        element = round(t/h + 1); %Index to use for current element
        next = element + 1; %Index to use for next element (prediction)
        k1 = f(t, x_rk2(element,:)); %k1 from RK2
        k2 = f(t + h/2, x_rk2(element,:) + h/2 * k1); %k2 from RK2
        x_rk2(next, :) = x_rk2(element, :) + h * k2; %Next values
    end
    error(iter) = norm(x_exact - x_rk2(:,1)'); %Finding the norm of the differences
end
loglog([.1 .05 .025 .0125], error)
xlabel("Step size")
ylabel("Error")
legend("Error of RK2")
title("Error of RK2 wrt Analytical, 2.3")
