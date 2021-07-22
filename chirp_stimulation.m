function [ ] = chirp_stimulation( mao, channels, amplitude, f_start, f_end, total_num_channels, max_output)
%CHIRP_PROTOCOL Summary of this function goes here
%   Detailed explanation goes here
T       = 20; %[s]
dt      = 1/mao.Fs;
t       = ( dt : dt : T )';
x0      = cos( pi + 2 * pi * f_start * t + pi * ( f_end - f_start ) * t.^2 / T );
x0      = ( x0 + 1 ) / 2;
x       = x0;
nstim = length(x);
min_v               = 0;
cycle_dur    = 60;      % [s]

chirp_stim                 = zeros (nstim+1, total_num_channels);
for i = 1:length(channels)
    ch = channels(i);
    v_wanted                   = amplitude(i);
    v_wanted(v_wanted>max_output) = max_output;
    v_sig                      = translateSig( x, v_wanted, min_v, 1 );
    chirp_stim(1:nstim,ch)     = v_sig;
end
[ x1, ~ ]                 = mao_load( mao, chirp_stim );
sig_plot( x1 );
mao_trigger( mao);
pause( cycle_dur ) %-%
end