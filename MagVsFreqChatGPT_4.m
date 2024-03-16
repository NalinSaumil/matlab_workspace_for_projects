%% Define the system parameters

m_sprung = 170;     % Sprung mass (kg)
k_sprung = 18140;   % Sprung stiffness (N/m)
c_sprung = 717;     % Sprung damping (N.s/m)
m_unsprung = 15;    % Unsprung mass (kg)
k_unsprung = 256000;% Unsprung stiffness (N/m)
c_unsprung = 0;     % Unsprung damping (N.s/m)
aero_gain = 1;      % Aero gain
s = tf('s');        % Laplace variable

%% Define the road and maneuvering inputs

% Road inputs
road_input_1 = tf(1, [1 0]);    % Unit step
road_input_2 = tf(1, [1 0.2]);  % Step with 0.2 Hz natural frequency
road_input_3 = tf(1, [1 1 1]);  % Step with 1 Hz natural frequency

% Maneuvering inputs
man_input_1 = tf([1 0], [1]);  % Ramp input
man_input_2 = tf([1 0.2], [1]);% Ramp with 0.2 Hz natural frequency
man_input_3 = tf([1 1 1], [1]);% Ramp with 1 Hz natural frequency

%% Define the system transfer functions

% With unsprung mass
G_unsprung = aero_gain*(m_sprung*s.^2 + c_sprung*s + k_sprung).*(m_unsprung*s.^2 + k_unsprung)./(m_sprung*m_unsprung*s.^4 + (m_sprung*c_unsprung + m_unsprung*c_sprung + k_sprung + k_unsprung)*s.^3 + (c_sprung*c_unsprung + k_sprung*c_unsprung + m_sprung*k_unsprung)*s.^2 + (k_sprung*k_unsprung + c_sprung*k_unsprung)*s + k_sprung*k_unsprung);

% With sprung mass only
G_sprung = aero_gain*(m_sprung*s.^2 + c_sprung*s + k_sprung)./(m_sprung*s.^2 + c_sprung*s + k_sprung);

%% Compute the frequency responses

% Compute the frequency responses for the unsprung mass system
Y_unsprung_1 = squeeze(freqresp(G_unsprung, s, road_input_1));
Y_unsprung_2 = squeeze(freqresp(G_unsprung, s, road_input_2));
Y_unsprung_3 = squeeze(freqresp(G_unsprung, s, road_input_3));

% Compute the frequency responses for the sprung mass system
Y_sprung_1 = squeeze(freqresp(G_sprung, s, road_input_1));
Y_sprung_2 = squeeze(freqresp(G_sprung, s, road_input_2));
Y_sprung_3 = squeeze(freqresp(G_sprung, s, road_input_3));

%% Plot the magnitude vs frequency

% Plotting results
figure;
semilogx(w/(2*pi), 20*log10(abs(Y_sprung_1)), 'r', w/(2*pi), 20*log10(abs(Y_unsprung_1)), 'b');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Magnitude vs Frequency Response for Input 1');
legend('Sprung Mass', 'Unsprung Mass');

figure;
semilogx(w/(2*pi), 20*log10(abs(Y_sprung_2)), 'r', w/(2*pi), 20*log10(abs(Y_unsprung_2)), 'b');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Magnitude vs Frequency Response for Input 2');
legend('Sprung Mass', 'Unsprung Mass');
