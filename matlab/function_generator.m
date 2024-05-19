% Define component values for Wien Bridge Oscillator
R_wien = 10e3;  % 10 kOhms
C_wien = 0.1e-6; % 0.1 uF

% Transfer function for Wien Bridge Oscillator
num_wien = 1;
den_wien = [R_wien^2 * C_wien^2, 3 * R_wien * C_wien, 1];
sys_wien = tf(num_wien, den_wien);

% Define time vector for simulation
t = 0:1e-4:0.02; % Time vector (20 ms for visualization)
f = 1000; % Frequency in Hz for sine wave input
sine_wave = sin(2 * pi * f * t);

% Schmitt Trigger parameters
V_high = 0.5; % Upper threshold
V_low = -0.5; % Lower threshold
square_wave = zeros(size(sine_wave));
state = 1;

% Generate Square Wave from Sine Wave using Schmitt Trigger
for i = 1:length(sine_wave)
    if sine_wave(i) > V_high
        state = 1;
    elseif sine_wave(i) < V_low
        state = -1;
    end
    square_wave(i) = state;
end

% Define component values for Integrator
R_int = 10e3;  % 10 kOhms
C_int = 0.1e-6; % 0.1 uF
num_int = 1;
den_int = [R_int * C_int, 0];
sys_int = tf(num_int, den_int);

% Generate Triangular Wave by integrating the Square Wave
triangular_wave = lsim(sys_int, square_wave, t);

% Define component values for Inverting Amplifier
R_in = 10e3;  % 10 kOhms
R_f = 100e3; % 100 kOhms
gain = -R_f / R_in;
sys_inverting_amp = tf(gain, 1);

% Combine the waves and apply amplitude modulation
combined_wave = sine_wave + square_wave + triangular_wave;
amplitude_modulated_wave = lsim(sys_inverting_amp, reshape(combined_wave, [], 1), t);

% Plot the time-domain waveforms
figure;
subplot(4, 1, 1);
plot(t, sine_wave);
title('Sine Wave (Wien Bridge Oscillator)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4, 1, 2);
plot(t, square_wave);
title('Square Wave (Schmitt Trigger)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4, 1, 3);
plot(t, triangular_wave);
title('Triangular Wave (Integrator)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4, 1, 4);
plot(t, amplitude_modulated_wave);
title('Amplitude Modulated Output');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot Bode plots for each stage
figure;
subplot(3, 1, 1);
bode(sys_wien);
title('Bode Plot of Wien Bridge Oscillator');
grid on;

subplot(3, 1, 2);
bode(sys_int);
title('Bode Plot of Integrator');
grid on;

subplot(3, 1, 3);
bode(sys_inverting_amp);
title('Bode Plot of Inverting Amplifier');
grid on;

% Combine the transfer functions for overall system analysis
sys_combined = series(series(sys_wien, sys_int), sys_inverting_amp);

% Plot Bode plot for the overall system
figure;
bode(sys_combined);
title('Bode Plot of Overall System');
grid on;

% Check system stability
[GM, PM, wcg, wcp] = margin(sys_combined);

% Display the stability margins
fprintf('Gain Margin: %.2f dB\n', 20*log10(GM));
fprintf('Phase Margin: %.2f degrees\n', PM);
fprintf('Gain Crossover Frequency: %.2f rad/s\n', wcg);
fprintf('Phase Crossover Frequency: %.2f rad/s\n', wcp);

% Plot margins on the Bode plot
figure;
margin(sys_combined);
title('Stability Margins of Overall System');
grid on;
