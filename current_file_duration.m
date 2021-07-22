function [ duration ] = current_file_duration( base_path, FsR, width )
%CURRENT_FILE_LENGTH Summary of this function goes here
%   Detailed explanation goes here
path = latest_dat( base_path );
m = memmapfile(path, 'format', 'int16' );                     % opening dat file in matlab
duration = length(m.Data)/width/FsR;
end

