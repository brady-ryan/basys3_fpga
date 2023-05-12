An elementary waveform generator implemented using 3 different Look-Up Tables (LUTs). I believe that the default frequency for this code is around 100 Hz. This can easily be changed by modifying the DIVISOR variable in clk_divider.v.

The left-most 3 switches correspond to 3 different waveforms:

1) Maximum Amplitude Sine Wave
2) Half Max. Amplitude Sine Wave
3) Max Amplitude Triangle Wave

The data can be transmitted using the right-most switch and integrated with the MATLAB plotting code to visualize the generated digital waves.

Additionally, one can also connect the outputs to a Digital-Analog Converter for visualization on an oscilloscope.