% Define constants
b_f = 168.4825;
b_r = 188.0576;
zeta = .7;
w_s_f = 2.65;
w_s_r = 3.08;
m_u_f = 25+7.5;
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
a1 = (2*zeta)/w_s_f;
a2 = (1 + k_st_f + (M_us_f*k_st_f))/((w_s_f^2));
a3 = (2*zeta*(1 + M_us_f)*k_st_f)/(w_s_f^3);
a4 = (M_us_f*k_st_f)/(w_s_f^4);
b0 = 1;
b1 = (2*zeta)/w_s_f;
b2 = 0;
b3 = 0;
c0 = (1 + k_st_f)/k_s_f;
c1 = (2*zeta*k_st_f)/(w_s_f*k_s_f);
c2 = (M_us_f*k_st_f)/((w_s_f^2)*k_s_f);
c3 = 0;

% Define the transfer function with two inputs
s = tf('s');
num1 = [b3 b2 b1 b0];
den1 = [a4 a3 a2 a1 a0];
num2 = [c3 c2 c1 c0];
den2 = [a4 a3 a2 a1 a0];
G = tf({num1,num2},{den1,den2});

% Set the analysis options for bode plot
opts = bodeoptions('cstprefs');
opts.PhaseMatching = 'off';

% Plot the frequency response using bode
bode(G, opts);
grid on;
title('Frequency Response of Front Suspension with Unsprung Mass and Downforce');

% Find the resonance frequency and peak gain
[mag, idx] = max(mag2db(abs(squeeze(freqresp(G(1,1),G(1,2),G(2,1),G(2,2))))));
freqs = (freqresp(G(1,1),G(1,2),G(2,1),G(2,2),'Hz')).';
res_freq = freqs(idx);
peak_gain = mag(idx);
fprintf('Resonance frequency: %g Hz\nPeak gain: %g dB\n', res_freq, peak_gain);
