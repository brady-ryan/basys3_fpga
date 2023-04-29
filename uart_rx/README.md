Inverse of the uart_tx directory codes.

When using a serial terminal, such as TeraTerm, the binary representation of the input into the serial terminal will be displayed on the Basys3 LEDs.

For example: The letter "a" corresponds to 01100001, meaning 3 LEDs will light up corresponding to 01100001.

RxD.m is a simple MATLAB code interface where the user can specify the number of LEDs they want turned on, and transmit that binary representation to be interpereted by the digital logic in real time.