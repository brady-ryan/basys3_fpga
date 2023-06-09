An elementary waveform generator implemented using 3 different Look-Up Tables (LUTs).

I believe that the default frequency for this code is around 100 Hz. This can easily be changed by modifying the DIVISOR variable in clk_divider.v. By default here it is set to divide the Basys3 clock to 100kHz.

Furthermore, the frequency is also determined by the number of data points in a memory file. For example, currently there are 1024 data points, so the maximum frequency one can achieve with the Basys3 100 MHz clock is around 100kHz (100MHz/1000).

To experiment with Nyquist, one can Google "sine wave LUT generator" and set the number of data points to 2. Ergo, 50MHz is the maximum frequency (unless one uses a PLL or the like to increase the Basys3 Frequency). I have not tested this, although I imagine it probably does not look very good!

The left-most 3 switches correspond to 3 different waveforms:

1) Maximum Amplitude Sine Wave
2) Half Max. Amplitude Sine Wave
3) Max Amplitude Triangle Wave

The data can be transmitted using the right-most switch and integrated with the MATLAB plotting code to visualize the generated digital waves.

Additionally, one can also connect the outputs to a Digital-Analog Converter for visualization on an oscilloscope.

![Fail](https://github.com/brady-ryan/basys3_fpga/blob/main/images/digital_sine.jpg)
Max Amplitude Sine Wave

![Fail](https://github.com/brady-ryan/basys3_fpga/blob/main/images/half_sine.png)
Half Max Amplitude Sine Wave

![Fail](https://github.com/brady-ryan/basys3_fpga/blob/main/images/digital_triangle.png)
Max Amplitude Triangle Wave


