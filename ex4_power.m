signal_length_sec = 0.6;
sampling_rate = 36000;
A = 0.2;
f = 14000;

signal_length_pt = signal_length_sec * sampling_rate;
t = ((1:signal_length_pt) - 1) / sampling_rate;

x = A * sin(2 * pi * f * t)';

X = fft(x)/length(x);
XPow = abs(X).^2;

f_k = linspace(0,24000/2,1+signal_length_pt/2);
f_k(end) = [];

XPow((2+signal_length_pt/2) : end) = [];
f_k = linspace(0,24000/2,1+signal_length_pt/2);

XPow_dB = 10 * log10(XPow);

plot(f_k,XPow_dB)
xlabel('frequency[Hz]')
ylabel('Power[dB]')

