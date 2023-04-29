clear;
close all;
 
s = serialport("COM4", 3686400, "Timeout", 5);
 
num_samples = 7000; 
data_type = "int8"; 
data = zeros(1, num_samples);
time_stamps = zeros(1, num_samples);
 
for i = 1:num_samples
    start_time = tic;
    data(i) = read(s, 1, data_type);
    time_stamps(i) = toc(start_time);
end
 
% Calculate cumulative time
time = cumsum(time_stamps);
 
% Apply a Butterworth low-pass filter
Fs = 1 / mean(time_stamps);
cutoff_freq = 0.1 * Fs;
order = 5;
[b, a] = butter(order, cutoff_freq / (Fs / 2), 'low');
filtered_data = filtfilt(b, a, data);


% Plot filtered data against time
plot(time/75, data/125); 
hold on;
plot(time/75, filtered_data/125); 
%plot(data/125);
 
xlabel('Time');
ylabel('Data (V)');
title('');

