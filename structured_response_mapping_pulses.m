function [  ] = structured_response_mapping_pulses( mao, channels, spiking_thresholds, population_thresholds )
%MANUAL_RESPONSE_MAPPING Summary of this function goes here
%   Detailed explanation goes here
spiking_thresholds_multipliers = [0.5, 1, 2];
population_thresholds_multipliers = [1, 2];
number_of_stimulations = length(channels) * (length(spiking_thresholds_multipliers) + length(population_thresholds_multipliers));
stimulations(1:number_of_stimulations) = struct('select_channels',[],'amplitudes',[]);
i = 1;
for select_channel=channels
    for spiking_multiplier = spiking_thresholds_multipliers
        stimulations(i).select_channels = select_channel;
        stimulations(i).amplitudes = spiking_thresholds(select_channel) * spiking_multiplier;
        i = i + 1;
    end
    for population_multiplier = population_thresholds_multipliers
        stimulations(i).select_channels = select_channel;
        stimulations(i).amplitudes = population_thresholds(select_channel) * population_multiplier;
        i = i + 1;
    end
end
stimulations = stimulations(randperm(number_of_stimulations));
for stimulation = stimulations
    select = stimulation.select_channels;
    spk_thr = stimulation.amplitudes;
    modes           = 'simultaneous';  % can be 'simultaneous', 'pairs', ...
    train_dur       = 10; % [s]
    train_freq      = 5; % [Hz]
    pulse_dur       = 0.05; % [s]
    sig_type        = 'pulse'; % can be 'pulse', 'sine', 'psine', ...
    graphics        = 1;
    lag             = 0;
    disp(['Start train for channel ' num2str(select) ' at ' num2str(spk_thr) ' V'])
    mao_trains( mao, modes, train_dur, train_freq, spk_thr, pulse_dur, lag, sig_type, select, 1, graphics);
    pause(3)
end
disp('Finished structured mapping pulses')
end

