%% FSAE Car Magnitude vs Frequency Plot
% Define constants
m = 300; % kg, total mass of the car
k_s = 40000; % N/m, spring constant of the suspension system
c = 1000; % N*s/m, damping coefficient of the suspension system
I_u = 2.5; % kg*m^2, moment of inertia of the unsprung mass
A = 1; % m^2, frontal area of the car
Cd = 0.5; % drag coefficient of the car

% Define variables
h = 0.2; % m, ride height of the car
v = 25; % m/s, velocity of the car
t = 0:0.001:10; % s, time vector
f = 0:0.1:100; % Hz, frequency vector
x_r = 0.01*sin(2*pi*10*t); % m, road input
x_m = 0.1*sin(2*pi*1.5*t); % rad, maneuvering input

% Calculate transfer function without unsprung mass
s = 2*pi*f*1i; % rad/s, complex frequency vector
k_t = m*(s.^2) + c*s + k_s; % N/m, transfer function denominator
G = 1./k_t; % m/N, transfer function numerator
H = 1./(A*Cd*s.^2 + c*s + k_s); % m/N, transfer function due to aerodynamic forces
G = G.*H; % m/N, total transfer function without unsprung mass
G_mag = abs(G); % magnitude of transfer function
G_mag_db = 20*log10(G_mag); % magnitude of transfer function in decibels

% Calculate transfer function with unsprung mass
k_u = k_s + m*h^2/((1/3)*m + I_u/h^2); % N/m, effective spring constant with unsprung mass
k_t = m*(s.^2) + c*s + k_s + k_u; % N/m, transfer function denominator
G = 1./k_t; % m/N, transfer function numerator
H = 1./(A*Cd*s.^2 + c*s + k_s + k_u); % m/N, transfer function due to aerodynamic forces
G = G.*H; % m/N, total transfer function with unsprung mass
G_mag = abs(G); % magnitude of transfer function
G_mag_db_u = 20*log10(G_mag); % magnitude of transfer function in decibels

% Plot magnitude vs frequency
figure;
semilogx(f,G_mag_db,'b',f,G_mag_db_u,'r');
title('Magnitude vs Frequency');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
legend('Without Unsprung Mass','With Unsprung Mass');
grid on;
