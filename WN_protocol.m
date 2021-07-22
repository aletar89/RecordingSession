function [ ] = WN_protocol( mao, repetitions,  channels, spiking_thresholds, total_num_channels, max_output)

spiking_thresholds_multipliers = [0.5, 1, 2];
cycle_dur     = 4;       % [s]
number_of_stimulations = length(channels) * length(spiking_thresholds_multipliers) * repetitions;
stimulations(1:number_of_stimulations) = struct('select_channels',[],'amplitudes',[]);
i = 1;
for select_channel=channels
    for spiking_multiplier = spiking_thresholds_multipliers
        for r = 1:repetitions
            stimulations(i).select_channels = select_channel;
            stimulations(i).amplitudes = spiking_thresholds(select_channel) * spiking_multiplier;
            i = i + 1;
        end
    end
end
stimulations = stimulations(randperm(number_of_stimulations));
Lab_standard_WN             = load( 'WN10k.mat' );  
white_noise_base            = resampleSig( Lab_standard_WN.WN, Lab_standard_WN.Fs, round( mao.Fs ) );        % resample to the DSP rate

for i=1:length(stimulations)
    stimulation = stimulations(i);
    all_channel_output = zeros(length(white_noise_base),total_num_channels);
    for c = 1:length(stimulation.select_channels)
        channel = stimulation.select_channels(c);
        amplitude = min(stimulation.amplitudes(c), max_output);
        channel_output = translateSig( white_noise_base, amplitude, 0, 1 );
        all_channel_output(:,channel) = channel_output;
    end
    all_channel_output_zero_ending = [all_channel_output;zeros(total_num_channels,1)];
    disp(['stimulation ' num2str(i) '/' num2str(number_of_stimulations) ', channels: ['...
        num2str(stimulation.select_channels) '], amplitudes: [' num2str(stimulation.amplitudes) ']'])
    mao_load( mao, all_channel_output_zero_ending );
    mao_trigger( mao );
    pause( cycle_dur )      
end
disp('Finished WN mapping')

end

