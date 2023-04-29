clear;
close all;
 
% Set the serial port and baud rate
portName = 'COM4'; % Replace with your serial port name
baudRate = 9600; % Set the baud rate according to your FPGA
 
% Create the serial port object
serialObj = serialport(portName, baudRate);
 
% Specify the number of LEDs to light up (between 1 and 8)
numLEDs = 4; % Replace 2 with the desired number of LEDs to light up
 
% Generate a binary representation to light up the desired number of LEDs
binValue = [ones(1, numLEDs), zeros(1, 8 - numLEDs)];
 
% Convert the binary representation to an uint8 value
ledValue = uint8(bin2dec(sprintf('%d', binValue)));
 
% Send the LED value to the FPGA
write(serialObj, ledValue, 'uint8');
 
% Close and delete the serial port object
delete(serialObj);
clear serialObj;
