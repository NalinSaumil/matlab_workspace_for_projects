% Define system parameters
m = 160; % Sprung mass (kg)
k_s = 20000; % Spring constant (N/m)
c = 1000; % Damping coefficient (Ns/m)
k_u = 50000; % Unsprung mass spring constant (N/m)
x_m = 0.05; % Unsprung mass displacement (m)

% Define transfer function for sprung mass system
G_sprung = tf(1, [m, c, k_s]);

% Define transfer function for unsprung mass system
G_unsprung = tf(1, [m, c, k_s + k_u]);

% Define frequency range
f = logspace(0, 4, 1000);

% Define Laplace variable
s = 2*pi*f*1i;

% Define input signals
t = linspace(0, 10, 10000);
road_input_1 = 0.005*sin(2*pi*10*t);
road_input_2 = 0.01*sin(2*pi*20*t);
road_input_3 = 0.02*sin(2*pi*30*t);
maneuver_input = 0.1*sin(2*pi*1*t);

% Calculate frequency response for each input signal
Y_sprung_1 = squeeze(freqresp(G_sprung, s, road_input_1));
Y_sprung_2 = squeeze(freqresp(G_sprung, s, road_input_2));
Y_sprung_3 = squeeze(freqresp(G_sprung, s, road_input_3));
Y_sprung_maneuver = squeeze(freqresp(G_sprung, s, maneuver_input));
Y_unsprung_1 = G_unsprung.*(m*s.^2 + k_u)./(s.*(m*s.^2 + c*s + k_s + k_u) + k_u);
Y_unsprung_2 = G_unsprung.*(m*s.^2 + k_u)./(s.*(m*s.^2 + c*s + k_s + k_u) + k_u);
Y_unsprung_3 = G_unsprung.*(m*s.^2 + k_u)./(s.*(m*s.^2 + c*s + k_s + k_u) + k_u);
Y_unsprung_maneuver = G_unsprung.*(x_m*s)./(s.*(m*s.^2 + c*s + k_s + k_u) + k_u);

% Calculate frequency response magnitude
Y_mag_sprung_1 = abs(Y_sprung_1);
Y_mag_sprung_2 = abs(Y_sprung_2);
Y_mag_sprung_3 = abs(Y_sprung_3);
Y_mag_sprung_maneuver = abs(Y_sprung_maneuver);
Y_mag_unsprung_1 = abs(Y_unsprung_1);
Y_mag_unsprung_2 = abs(Y_unsprung_2);
Y_mag_unsprung_3 = abs(Y_unsprung_3);
Y_mag_unsprung_maneuver = abs(Y_unsprung_maneuver);

% Plot frequency response magnitude vs frequency for each input signal
figure;
subplot(2,2,1);
semilogy(f, Y_mag_sprung_1);
title('Sprung Mass Frequency Response - Road Input 1');
xlabel('Frequency (Hz)');
ylabel('Magnitude (m/N)');
subplot(2,2,2);
semilogy(f, Y_mag_sprung_2);
title('Sprung Mass Frequency Response - Road Input 2');
xlabel('Frequency (Hz)');
ylabel('Magnitude (m/N)');
subplot