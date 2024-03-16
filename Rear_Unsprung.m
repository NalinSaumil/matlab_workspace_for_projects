% Define constants
b_f = 168.4825;
b_r = 188.0576;
zeta = .7;
w_s_f = 2.65;
w_s_r = 3.08;
m_u_f = 25;
m_u_r = 28;
m_s_f = 141.78;
m_s_r = 136.22;
k_s_f = 102.15;
k_s_r = 132.46;
k_t = 750;
k_st_f = k_s_f/k_t;
k_st_r = k_s_r/k_t;
M_us_f = m_u_f/m_s_f;
M_us_r = m_u_r/m_s_r;

% Define the coefficients of the differential equation
a0 = 1;
a1 = (2*zeta)/w_s_r;
a2 = (1 + k_st_r + (M_us_r*k_st_r))/((w_s_r^2));
a3 = (2*zeta*(1 + M_us_r)*k_st_r)/(w_s_r^3);
a4 = (M_us_r*k_st_r)/(w_s_r^4);
b0 = 1;
b1 = (2*zeta)/w_s_r;
b2 = 0;
b3 = 0;

% Define the transfer function
s = tf('s');
%G = (b3*s^3 + b2*s^2 + b1*s + b0) / (a4*s^4 + a3*s^3 + a2*s^2 + a1*s + a0);
num1 = [b3 b2 b1 b0];
den1 = [a4 a3 a2 a1 a0];
G = tf({num1},{den1});

% Set the analysis options for bode plot
opts = bodeoptions('cstprefs');
opts.PhaseMatching = 'on';

% Plot the frequency response using bode
bode(G);
grid on;
title('Frequency Response of Rear Suspension with Unsprung Mass and no Downforce');

% Find the resonance frequency and peak gain
%[mag, idx] = max(mag2db(abs(squeeze(freqresp(G)))));
%freqs = (freqresp(G,'Hz')).';
%res_freq = freqs(idx);
%peak_gain = mag(idx);
%freqs = linspace(0, 100, 100000); % define a vector of frequencies from 0 Hz to 100 Hz
%freqs_resp = freqresp(G, freqs);
%[mag, idx] = max(mag2db(abs(squeeze(freqs_resp))));
%freqs = freqs.';
%res_freq = freqs(idx);
%peak_gain = mag(idx);
[mag, idx] = max(mag2db(abs(squeeze(freqresp(G(1,1))))));
freqs = (freqresp(G(1,1),'Hz')).';
res_freq = freqs(idx);
peak_gain = mag(idx);
fprintf('Resonance frequency: %g Hz\nPeak gain: %g dB\n', res_freq, peak_gain);