function [ y ] = bandpass(signal, band, fs  )
N  = length(signal);
dF = fs/N;
f  = (-fs/2:dF:fs/2-dF);
f = f(:);
%% Band-Pass Filter:
BPF = ((band(1) < abs(f)) & (abs(f) < band(2)));
signal 	 = signal-mean(signal);
signal = signal(:);
spektrum = fftshift(fft(signal))/N;

spektrum = BPF.*spektrum;

%% The band-pass filtered time series
y = ifft(ifftshift(spektrum)); %inverse ifft
y = real(y)*N;
end
