%% FSAE Car Magnitude vs Frequency Plot
% Define constants
m = 250; % kg, total mass of the car
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

% Define road input signals
x_r1 = 0.01*sin(2*pi*10*t); % m, road input 1
x_r2 = 0.02*sin(2*pi*20*t); % m, road input 2
x_r3 = 0.005*sin(2*pi*5*t); % m, road input 3

% Define maneuvering input signals
x_m1 = 0.1*sin(2*pi*1.5*t); % rad, maneuvering input 1
x_m2 = 0.2*sin(2*pi*2.5*t); % rad, maneuvering input 2
x_m3 = 0.15*sin(2*pi*3.5*t); % rad, maneuvering input 3

% Calculate transfer function without unsprung mass
s = 2*pi*f*1i; % rad/s, complex frequency vector
k_t = m*(s.^2) + c*s + k_s; % N/m, transfer function denominator
G = 1./k_t; % m/N, transfer function numerator
H = 1./(A*Cd*s.^2 + c*s + k_s); % m/N, transfer function due to aerodynamic forces
G_sprung = G.*H; % m/N, total transfer function without unsprung mass
G_mag_sprung = abs(G_sprung); % magnitude of transfer function

% Calculate transfer function with unsprung mass
k_u = k_s + m*h^2/((1/3)*m + I_u/h^2); % N/m, effective spring constant with unsprung mass
k_t = m*(s.^2) + c*s + k_s + k_u; % N/m, transfer function denominator
G = 1./k_t; % m/N, transfer function numerator
H = 1./(A*Cd*s.^2 + c*s + k_s + k_u); % m/N, transfer function due to aerodynamic forces
G_unsprung = G.*H; % m/N, total transfer function with unsprung mass
G_mag_unsprung = abs(G_unsprung); % magnitude of transfer function

% Calculate frequency response for each road input and maneuvering input
for i = 1:length(x_r1)
    x_r = [x_r1(i) x_r2(i) x_r3(i)];
    x_m = [x_m1(i) x_m2(i) x_m3(i)];

% Calculate frequency response without unsprung mass
    Y_sprung = G_sprung.*(m*s.^2 + k_u)./(s.*(m*s.^2 + c*s + k_s + k_u) + k_u);

% Calculate frequency response with unsprung mass
Y_unsprung = G_unsprung.*(m*s.^2 + k_u)./(s.*(m*s.^2 + c*s + k_s + k_u) + k_u);

% Calculate frequency response magnitude
Y_mag_sprung = abs(Y_sprung);
Y_mag_unsprung = abs(Y_unsprung);

% Plot frequency response magnitude vs frequency for each input signal
figure;
subplot(2,1,1);
semilogy(f, Y_mag_sprung);
title('Sprung Mass Frequency Response');
xlabel('Frequency (Hz)');
ylabel('Magnitude (m/N)');
legend(sprintf('Road Input 1'), sprintf('Road Input 2'), sprintf('Road Input 3'));
subplot(2,1,2);
semilogy(f, Y_mag_unsprung);
title('Unsprung Mass Frequency Response');
xlabel('Frequency (Hz)');
ylabel('Magnitude (m/N)');
legend(sprintf('Road Input 1'), sprintf('Road Input 2'), sprintf('Road Input 3'));

end
