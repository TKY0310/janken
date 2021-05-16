signal_length_sec = 4;
sampling_rate = 16000;

A = 0.5;        % Amplitude
f_start = 400;  % Initial frequnecy [Hz]
f_end = 6000;   % Final frequency [Hz]

signal_length_pt = signal_length_sec * sampling_rate;
t =  ((1:signal_length_pt) - 1) / sampling_rate;

x = A * sin(2 * pi * (f_start .* t) + pi * (f_end-f_start)/signal_length_sec * t.^2 )';


%% �t���[���������i�[���l�ߏ����L��j
frame_len =  800;  % �p�����[�^�F�t���[����
fft_len   = 1024;  % �p�����[�^�FFFT��   <-- new!!

m = 1;        % ������̉��Ԗڂ��C��\���ϐ�
x_idx_st = 1; % x�̂ǂ����番������΂悢���C��\���ϐ�
x_idx_en = x_idx_st + frame_len - 1; % x�̂ǂ��܂łɕ�������΂悢���C��\���ϐ�

while x_idx_en <= length(x)
    w = hamming(frame_len);
    
    frame_x(:, m) = [ x(x_idx_st:x_idx_en); zeros(fft_len-frame_len, 1) ];   % Framing with Zero-padding   <-- update!!

    % ���̃��[�v�̏���
    m = m + 1;
    x_idx_st = x_idx_st + frame_len;
    x_idx_en = x_idx_st + frame_len - 1;
end

X = fft(frame_x, fft_len) / fft_len;

Pow_X = abs(X) .^ 2;

Pow_X((2+fft_len/2):end, :) = [];
Pow_X_dB = 10 * log10(Pow_X);

[f_num, t_num] = size(Pow_X_dB);

t_s = linspace(0, length(x)/sampling_rate, t_num);
f_s = linspace(0, sampling_rate/2, f_num);

imagesc(t_s,f_s,Pow_X_dB);
set(gca, 'YDir', 'normal');
caxis([-70 -20])
colorbar

xlabel('time[s]');
ylabel('Frequency[Hz]');
