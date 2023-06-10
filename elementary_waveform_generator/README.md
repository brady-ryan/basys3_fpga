An elementary waveform generator implemented using different Look-Up Tables (LUTs). The left and right buttons are configured to vary the frequency from as low as 1Hz to as high as 1MHz, depending on which LUT one uses.

Furthermore, the frequency is also determined by the number of data points in a memory file. For example, currently there are 1000 data points in “sine5.mem”, so the maximum frequency one can achieve with the Basys3 100 MHz system clock is 100kHz (100MHz/1000).  For “mhz2.mem” there are only 10 data points, thus leading to a sine wave of maximum output frequency of 1MHz (100MHz/10).

The leftmost 6 switches correspond to different waveforms being generated. Moreover, switch[5] allows one to alternate between all waveforms at a rate of 1Hz.

The data can be transmitted using the right-most switch and integrated with the MATLAB plotting code to visualize the generated digital waves without the need of a Digital-to-Analog Converter (DAC).

Additionally, one can also connect the outputs to a DAC for visualization on an oscilloscope. This code is configured for the Digilent PMod R2R, with 8-bits being output at the JC PMod. Below are some images taken on an oscilloscope of the analog waveforms being produced:

![Fail](https://github.com/brady-ryan/basys3_fpga/blob/main/images/digital_sine.jpg)
10kHz Sine Wave w/ 3.3V Amplitude.

![Fail](https://github.com/brady-ryan/basys3_fpga/blob/main/images/digital_chirp.jpg)
Chirp wave starting at 10kHz and rising to 500kHz.

![Fail](https://github.com/brady-ryan/basys3_fpga/blob/main/images/digital_triangle.jpg)
1Hz Triangle Wave w/ 3.3V Amplitude


