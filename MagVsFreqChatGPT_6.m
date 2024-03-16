% Define constants
zeta = .7;
w_s = 2.65;
m_u_f = 25;
m_u_r = 28;
m_s_f = 141.78;
m_s_r = 136.22;
k_s_f = 102.15;
k_s_r = 132.46;
k_t = 750;
k_st_f = k_s_f/k_t;

% Define the coefficients of the differential equation
a0 = 1;
a1 = (2*zeta)/w_s;
a2 = (1+k_st_f)/(w_s^2);
a3 = ((2*zeta)/(w_s^3))*k_st_f;
a4 = 0;
b0 = 1;
b1 = (2*zeta)/w_s;
b2 = 0;
b3 = 0;

% Define the transfer function
s = tf('s');
G = (b3*s^3 + b2*s^2 + b1*s + b0) / (a4*s^4 + a3*s^3 + a2*s^2 + a1*s + a0);

% Plot the frequency response using bode
bode(G);
grid on;
title('Frequency Response of Fourth-Order System');

% Find the resonance frequency and peak gain
[mag, idx] = max(mag2db(abs(squeeze(freqresp(G)))));
freqs = (freqresp(G,'Hz')).';
res_freq = freqs(idx);
peak_gain = mag(idx);
fprintf('Resonance frequency: %g Hz\nPeak gain: %g dB\n', res_freq, peak_gain);