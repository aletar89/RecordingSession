function [ dat_path ] = latest_dat( base_path )
%LATEST_DAT Summary of this function goes here
%   Detailed explanation goes here
l = dir(base_path);
dat_path = '';
latest_datenum = 0;
for i = 1:length(l)
    file = l(i);
    if length(file.name)<3 || ~file.isdir
        continue
    end
    if file.datenum > latest_datenum
        dat_path = [base_path '\' file.name '\all_in_one.dat'];
        latest_datenum = file.datenum;
    end
end

