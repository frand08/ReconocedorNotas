function [efeefete,f] = plotFFT(signal,fs)
% Realiza la FFT y devuelve amplitud y frecuencia
% efeefete: Vector de amplitudes, f: vector de frecuencias
    L = length(signal);
    NFFT = 2^nextpow2(L);
    fft_s = fft(signal,NFFT)/L;
    f = fs/2*linspace(0,1,NFFT/2+1);
    % Plot single-sided amplitude spectrum.
    semilogx(f,2*abs(fft_s(1:NFFT/2+1))), axis tight,xlim([1 20000]),grid;
    efeefete= 2*abs(fft_s(1:NFFT/2+1));
    set(gca,'XTickLabel',{'1','10','100','1K','10K'});
    title('Single-Sided Amplitude Spectrum of s(t)');
    xlabel('Frequency (Hz)');
    ylabel('|S(f)|');
end
