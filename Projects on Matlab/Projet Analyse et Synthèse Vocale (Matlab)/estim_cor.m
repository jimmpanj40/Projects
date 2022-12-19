function[DSP,nu]=estim_dsp(gamma,Nfft) %X doit être l'autocorrélation estimée
    DSP=fft(gamma,Nfft); % la DSP est la TFTD de l'autocorrelation
    nu=(0:Nfft-1)/(Nfft);
end
