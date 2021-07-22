clear variables
close all
clc
path(path, 'alex_codes')

FsR = 25000; % [Hz] requested sampling rate of DSP
total_num_channels =1; % number of stimulation channels
mao = mao_initiate( total_num_channels, FsR, 30 * FsR );
max_val = 5;
%% Manual response mapping
channel = 1;
amplitude = 3;
manual_response_mapping( mao, channel, amplitude )
%% Interactive mapping [WIP]
dat_base = 'E:\Recordings\m87C';
intan_Fs = 20E3;
dat_width = 11;
time_before_stim = current_file_duration( dat_base, intan_Fs, dat_width );
channel = 1;
amplitude = 5;
manual_response_mapping( mao, channel, amplitude )
time_after_stim = current_file_duration( dat_base, intan_Fs, dat_width );
[ mat ] = get_dat_channels( latest_dat( dat_base ), dat_width, intan_Fs, time_before_stim, time_after_stim, [1,2,3,4,7] );
optic_response_test( mat(:,5), mat(:,1:4), 4, intan_Fs )
%% Structred response mapping pulses
tic
spiking_thresholds = [0.2]; % Same length as number of channels
population_thresholds = [1]; % Same length as number of channels
channels = [1];
mao = mao_initiate( total_num_channels, FsR, 30 * FsR );
structured_response_mapping_pulses( mao, channels, spiking_thresholds, population_thresholds )
toc
%% Structred response mapping WN
tic
repetitions = 10;
total_num_channels = 1;
max_output = 5;
WN_protocol( mao, repetitions,  channels, spiking_thresholds, total_num_channels, max_output)

toc
%% Manual Chirp stimulation
channels = 1;
amplitude = 2;
total_num_channels = 1;
max_output = 5;
f_start = 0;
f_end = 200;
chirp_stimulation( mao, channels, amplitude, f_start, f_end, total_num_channels, max_output)