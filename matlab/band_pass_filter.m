% Component values for band-pass filter
R1 = 8e3; % 8 kOhms
C1 = 0.1e-6; % 0.1 uF
R2 = 8e3; % 8 kOhms
C2 = 0.01e-6; % 0.01 uF

% High-pass filter transfer function
num_hpf = [R1*C1, 0];
den_hpf = [R1*C1, 1];
sys_hpf = tf(num_hpf, den_hpf);

% Low-pass filter transfer function
num_lpf = [1];
den_lpf = [R2*C2, 1];
sys_lpf = tf(num_lpf, den_lpf);

% Band-pass filter is series combination of HPF and LPF
sys_bpf = series(sys_hpf, sys_lpf);

% Bode Plot of the Band-Pass Filter
figure;
bode(sys_bpf);
title('Bode Plot of RC Band-Pass Filter');
grid on;

% Check stability of the Band-Pass Filter
[GM_bpf, PM_bpf, wcg_bpf, wcp_bpf] = margin(sys_bpf);
fprintf('Band-Pass Filter Stability Analysis:\n');
fprintf('  Gain Margin: %.2f dB\n', 20*log10(GM_bpf));
fprintf('  Phase Margin: %.2f degrees\n', PM_bpf);
fprintf('  Gain Crossover Frequency: %.2f rad/s\n', wcg_bpf);
fprintf('  Phase Crossover Frequency: %.2f rad/s\n', wcp_bpf);
