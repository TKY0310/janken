disp('***** Say 1 *****')
record_oneshot(0.6, 'wav/voice3.wav');

disp('***** Say 2 *****')
record_oneshot(0.6, 'wav/voice4.wav');

[voice3(:, 1), Fs] = audioread('wav/voice3.wav');
voice4(:, 2) = audioread('wav/voice4.wav');

frame_len = 400;  
fft_len = 512;


frame_x = signal2frame(voice3(:, 1), frame_len, fft_len);
voice3_PowX_dB = calc_powerspec(frame_x, fft_len);


frame_x = signal2frame(voice4(:, 2), frame_len, fft_len);
voice4_PowX_dB = calc_powerspec(frame_x, fft_len);

x_len = 0.5;   

subplot(2, 3, 1);
  plot_spectrogram(voice3_PowX_dB, x_len, Fs);
  title('voice 1');

subplot(2, 3, 4);
  plot_spectrogram(voice4_PowX_dB, x_len, Fs);
  title('voice 1');