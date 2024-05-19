% Define ECG signal parameters
ecg_amplitude = 1; % mV (typical range: 0.5 - 2 mV)
ecg_frequency = 5; % Hz (typical range: 0.5 - 100 Hz)

% Choose an appropriate sampling rate based on ECG frequency content
% (consider Nyquist theorem: sampling rate >= 2*highest frequency)
f_max_ecg = 100; % Hz (example: assume highest ECG frequency)
desired_sampling_rate = 2 * f_max_ecg; % Sampling rate based on Nyquist criterion

% Create time vector with chosen sampling rate
dt = 1 / desired_sampling_rate; % Time step between samples
t = 0:dt:2; % Time vector

% Generate ECG signal
ecg_signal = ecg_amplitude * sin(2*pi*ecg_frequency*t);

% Define INA121 gain (consult datasheet for actual value)
ina_gain = 1000; % (typical range: 1 - 10000)

% Define filter parameters (adjust these values)
% LPF - Low Pass Filter
f_cutoff_LPF = 100; % Hz (cut-off frequency for LPF)
C1 = 1e-6; % Capacitor for LPF (adjust for desired cut-off)

% HPF - High Pass Filter
f_cutoff_HPF = 0.1; % Hz (cut-off frequency for HPF)
R2 = 1 / (2*pi*f_cutoff_HPF*C1); % Resistor for HPF (adjust for desired cut-off)

% Calculate time constants for filters
tau_LPF = 1 / (2*pi*f_cutoff_LPF*C1); % Time constant for LPF
tau_HPF = R2*C1; % Time constant for HPF

% Add high-frequency noise (adjustable parameters)
noise_power = 0.005; % Adjust for desired noise level (power)
noise_std = sqrt(noise_power); % Standard deviation of noise
f_noise = 100; % Hz (example: frequency of high-frequency noise)
noise = noise_std * sin(2*pi*f_noise*t) + randn(size(ecg_signal)); % Combine sine wave and random noise

% Filtering with cascaded 1st-order RC filters
filtered_ecg = ecg_signal + noise; % Add noise to ECG signal

% Apply LPF filtering (assuming filtering before amplification)
filtered_ecg = filtered_ecg + (filtered_ecg - ecg_signal) .* exp(-t/tau_LPF);

% Apply INA gain
amplified_ecg = ina_gain * filtered_ecg;

% Apply HPF filtering
filtered_ecg = amplified_ecg;
filtered_ecg = filtered_ecg + (amplified_ecg - filtered_ecg) .* exp(-t/tau_HPF);

% Plot results (optional)
figure;
subplot(4,1,1);
plot(t, ecg_signal);
title('Raw ECG Signal');
xlabel('Time (s)');
ylabel('Amplitude (mV)');

subplot(4,1,2);
plot(t, noise);
title('High-Frequency Noise');
xlabel('Time (s)');
ylabel('Amplitude (mV)');

subplot(4,1,3);
plot(t, ecg_signal + noise);
title('ECG with Noise (Added)');
xlabel('Time (s)');
ylabel('Amplitude (mV)');

subplot(4,1,4);
plot(t, filtered_ecg);
title('Filtered ECG (Band-Pass Filter)');
xlabel('Time (s)');
ylabel('Amplitude (mV)');
