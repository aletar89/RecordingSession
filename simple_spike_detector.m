function [ spikes ] = simple_spike_detector( recording, threshold )
%SIMPLE_SPIKE_DETECTOR Summary of this function goes here
%   Detailed explanation goes here
F_low = 250;
F_high = 6E3;
F_sampling = 20E3;
bandpassed_recording = bandpass(single(recording'), [F_low, F_high], F_sampling)';
std_window = 0.1 * F_sampling;
dynamic_threshold = threshold * movstd(bandpassed_recording, std_window);
candidates = find(abs(bandpassed_recording) > dynamic_threshold);
spikes = candidates;
for i = 2:length(candidates)
    if candidates(i)-candidates(i-1)<8
        if abs(bandpassed_recording(candidates(i)))>=abs(bandpassed_recording(candidates(i-1)))
            spikes(i-1) = 0;
        else
            spikes(i) = 0;
        end
    end
end
spikes(spikes == 0) = [];
end

