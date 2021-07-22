function [  ] = optic_response_test( stimulation, recording, threshold, intan_Fs )
%OPTIC_RESPONSE_TEST Summary of this function goes here
%   Detailed explanation goes here
n_recording_channels = size(recording,2);
spikes(1:n_recording_channels) = struct('indexes',[],'rate_on',0,'rate_off',0);
is_stim_on =stimulation > (max(stimulation)/2);
stim_on_duration = sum(is_stim_on)/intan_Fs;
stim_off_duration = sum(~is_stim_on)/intan_Fs;

figure(50345)
clf
time = (1:length(stimulation))/intan_Fs;
top_height = std(recording(:,1)) * 2 * n_recording_channels;
area_stairs(time, double(is_stim_on')*top_height)
hold on
offset = 0;
title_string = "Rate on/off:";
for i = 1:n_recording_channels
    spikes(i).indexes = simple_spike_detector( recording(:,i), threshold );    
    spikes(i).rate_on = sum(is_stim_on(spikes(i).indexes)) / stim_on_duration;
    spikes(i).rate_off = sum(~is_stim_on(spikes(i).indexes)) / stim_off_duration;
    title_string = title_string + sprintf(" %.1f/%.1f ",spikes(i).rate_on, spikes(i).rate_off);
    offset = offset + std(recording(:,i));
    plot(time, recording(:,i) + offset,'r')
    plot(time(spikes(i).indexes), recording(spikes(i).indexes,i) + offset, 'ok')
    offset = offset + std(recording(:,i));
end
title(title_string)
xlim([0,time(end)])
end

function [] = area_stairs (x,y)
x = x(:);
y = y(:);
x = [x;x];
y = [y;y];
area(x([2:end end]),y(1:end),'facecolor','y')
end