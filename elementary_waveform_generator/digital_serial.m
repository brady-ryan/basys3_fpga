clear;
close all;
 
s = serialport("COM4", 3686400, "Timeout", 5);
 
num_samples = 15000; % Increase the number of samples
data_type = "uint8"; 
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
 
average_time = sum(time_stamps)/num_samples;
 
% Plot filtered data against time
plot(time*average_time, data/256); 
hold on;
%plot(time/*average_time, filtered_data/256); 
%plot(data/256);
 
xlabel('Time');
ylabel('Data');
title('');
