function [ mat ] = get_dat_channels( path, width, Fs, start_time, end_time, channels )
%GET_DAT_CHANNELS Summary of this function goes here
%   Detailed explanation goes here
m = memmapfile(path, 'format', 'int16' );                     % opening dat file in matlab
start_sample = round(start_time*Fs);
end_sample = round(end_time*Fs);
mat = zeros(end_sample-start_sample,length(channels));
start_ind = start_sample*width+1;
end_ind = end_sample*width;
for c = 1:length(channels)
    mat(:,c) = downsample(m.Data(start_ind:end_ind),width,channels(c)-1);
end
end