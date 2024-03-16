% Define transfer function for unsprung mass
num_u = [m_unsprung, 0, k_u];
den_u = [m_sprung, c_sprung, k_sprung+k_u];
G_unsprung = tf(num_u, den_u);

% Define transfer function for sprung mass
num_s = [m_sprung, 0, k_sprung];
den_s = [m_sprung, c_sprung, k_sprung+k_u];
G_sprung = tf(num_s, den_s);

% Define frequency range
f = logspace(0, 3, 1000);
w = 2*pi*f;

% Define road inputs
road_input_1 = tf(1);
road_input_2 = tf([1 0], [1]);

% Define maneuvering inputs
maneuver_input_1 = tf(1);
maneuver_input_2 = tf([1 0], [1]);

% Calculate frequency response for unsprung mass
Y_unsprung_1 = squeeze(freqresp(G_unsprung, w, road_input_1));
Y_unsprung_2 = squeeze(freqresp(G_unsprung, w, road_input_2));

% Calculate frequency response for sprung mass
Y_sprung_1 = squeeze(freqresp(G_sprung, w, road_input_1));
Y_sprung_2 = squeeze(freqresp(G_sprung, w, road_input_2));

% Plot frequency response for unsprung mass
figure;
subplot(2,1,1);
semilogx(f, 20*log10(abs(Y_unsprung_1)), 'LineWidth', 2);
hold on;
semilogx(f, 20*log10(abs(Y_unsprung_2)), 'LineWidth', 2);
title('Frequency Response of Unsprung Mass');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
legend('Road Input 1', 'Road Input 2');

% Plot frequency response for sprung mass
subplot(2,1,2);
semilogx(f, 20*log10(abs(Y_sprung_1)), 'LineWidth', 2);
hold on;
semilogx(f, 20*log10(abs(Y_sprung_2)), 'LineWidth', 2);
title('Frequency Response of Sprung Mass');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
legend('Road Input 1', 'Road Input 2');