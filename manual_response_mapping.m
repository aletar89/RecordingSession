function [  ] = manual_response_mapping( mao, channel, amplitude )
%MANUAL_RESPONSE_MAPPING Summary of this function goes here
%   Detailed explanation goes here
select = channel;
spk_thr = amplitude;
modes           = 'simultaneous';  % can be 'simultaneous', 'pairs', ...
train_dur       = 5; % [s]
train_freq      = 5; % [Hz]
pulse_dur       = 0.05; % [s]
sig_type        = 'psine'; % can be 'pulse', 'sine', 'psine', ...
graphics        = 1;
lag             = 0;
disp(['Start train for channel ' num2str(select) ' at ' num2str(spk_thr) ' V'])
tic
mao_trains( mao, modes, train_dur, train_freq, spk_thr, pulse_dur, lag, sig_type, select, 1, graphics);
toc
end

