intan_fs = 20E3;
dat_base = 'E:\Recordings\m87C';
dat_width = 11;
spectrogram_time_step = 0.3 * intan_fs;
frequencies = linspace(0,100,100);
f = figure(999);
start_time = tic;
while 1 || toc(start_time) < 60
    if ~ishandle(f)
        break
    end
    time2 = current_file_duration( dat_base, intan_fs, dat_width);
    time1 = time2 - 10;
    mat = get_dat_channels( latest_dat(dat_base), dat_width, intan_fs, time1, time2, [1,2,3,4,7] )  ;
    for i = 1:4
    subplot(5,1,i)
    spectrogram(mat(:,i),spectrogram_time_step,spectrogram_time_step/2,frequencies,20e3,'power','yaxis');
    caxis([0,50])
    end
    subplot(5,1,5)
    t = (0:(size(mat,1)-1))/intan_fs;
    plot(t,mat(:,5))
    ylim([0,2^14])
    colorbar
    pause(0.3)
end