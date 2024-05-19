# Function Generator Circuit

## Overview

This function generator circuit is designed to produce sine, square, and triangular waveforms over a frequency range of 200 Hz to 2 kHz. The circuit integrates a Wien bridge oscillator, a Schmitt trigger-based square wave generator, and an integrator for generating triangular waves. These waveforms are then combined using an inverting summing amplifier, followed by a 2nd-order band-pass filter to ensure frequency stability and precision.

## Circuit Components and Design

### 1. Wien Bridge Oscillator

The Wien bridge oscillator is used to generate a stable sine wave. It consists of a bridge network with resistors and capacitors providing positive feedback and an operational amplifier (op-amp) to amplify the signal. The frequency of oscillation is determined by the values of the resistors and capacitors in the bridge network. The output sine wave is known for its low distortion and stability.

### 2. Schmitt Trigger-Based Square Wave Generator

The square wave is generated using a Schmitt trigger configuration. This circuit includes an op-amp with positive feedback, ensuring a rapid transition between high and low output states, thus generating a square waveform. A capacitor is connected to the inverting terminal of the op-amp to determine the frequency of oscillation.

### 3. Integrator for Triangular Wave

The square wave output from the Schmitt trigger is fed into an integrator circuit, which consists of an op-amp with a capacitor in the feedback loop. The integrator converts the square wave into a triangular wave, as the integration of a constant (square wave) results in a ramp (triangular wave).

### 4. Inverting Summing Amplifier

The sine, square, and triangular wave outputs are combined using an inverting summing amplifier. This circuit uses an op-amp with multiple input resistors, each connected to the individual waveform outputs. The summing amplifier outputs a weighted sum of the input signals, providing a single composite waveform.

### 5. 2nd-Order Band-Pass Filter

To ensure that only the desired frequency range (200 Hz to 2 kHz) passes through, a 2nd-order band-pass filter is used. This filter is designed using a combination of high-pass and low-pass RC filters. The high-pass filter attenuates frequencies below 200 Hz, while the low-pass filter attenuates frequencies above 2 kHz. This ensures a clean and stable output within the specified frequency range.

## Frequency Calculation and Component Selection

### High-Pass Filter
- Cutoff frequency (f_c1): 200 Hz
- Resistor (R1): 8 kΩ
- Capacitor (C1): 0.1 μF

### Low-Pass Filter
- Cutoff frequency (f_c2): 2000 Hz
- Resistor (R2): 8 kΩ
- Capacitor (C2): 0.01 μF

### Stability and Performance

The 2nd-order band-pass filter ensures that the output signal is within the desired frequency range, enhancing the performance of the function generator. The passive RC network design guarantees inherent stability, making the system robust and reliable for various applications.

## Conclusion

This function generator circuit effectively combines multiple waveform generation techniques to produce sine, square, and triangular waves. The use of an inverting summing amplifier and a 2nd-order band-pass filter ensures a precise and stable output, making it suitable for a wide range of electronic applications.
