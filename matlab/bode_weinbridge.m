% Define component values
R = 10e3;  % 10 kOhms
C = 0.01e-6; % 0.01 uF

% Define the transfer function numerator and denominator coefficients
numerator = 1;
denominator = [R^2*C^2, 3*R*C, 1];

% Create the transfer function
sys = tf(numerator, denominator);

% Generate the Bode plot and calculate the margins
[mag, phase, w] = bode(sys);
mag = squeeze(mag);
phase = squeeze(phase);

% Convert magnitude to dB
mag_db = 20 * log10(mag);

% Find Gain Crossover Frequency (GC)
gc_idx = find(mag_db <= 0, 1); % Find first instance where magnitude is 0 dB
GC = w(gc_idx);

% Find Phase Crossover Frequency (PCF)
pcf_idx = find(phase <= -180, 1); % Find first instance where phase is -180 degrees
PCF = w(pcf_idx);

% Calculate Gain Margin (GM)
GM = 1 / mag(pcf_idx);
GM_db = 20 * log10(GM);

% Calculate Phase Margin (PM)
PM = 180 + phase(gc_idx);

% Display the results
fprintf('Gain Crossover Frequency (GC): %.2f rad/s\n', GC);
fprintf('Phase Crossover Frequency (PCF): %.2f rad/s\n', PCF);
fprintf('Gain Margin (GM): %.2f (%.2f dB)\n', GM, GM_db);
fprintf('Phase Margin (PM): %.2f degrees\n', PM);

% Plot Bode plot with annotations
figure;
bode(sys);
grid on;

% Add titles and labels
title('Bode Plot of Wien Bridge Oscillator');
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB) / Phase (degrees)');

% Highlight Gain Crossover Frequency (GC)
hold on;
if ~isempty(gc_idx)
    plot(GC, 0, 'ro', 'MarkerFaceColor', 'r');
    text(GC, 0, sprintf('  GC = %.2f rad/s', GC), 'VerticalAlignment', 'bottom');
end

% Highlight Phase Crossover Frequency (PCF)
if ~isempty(pcf_idx)
    plot(PCF, -180, 'bo', 'MarkerFaceColor', 'b');
    text(PCF, -180, sprintf('  PCF = %.2f rad/s', PCF), 'VerticalAlignment', 'top');
end

hold off;
