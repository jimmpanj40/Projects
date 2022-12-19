function[DSP,nu]=estim_per(x,Nfft) %x est le signal 
    DSP=(abs(fft(x,Nfft)).^2);% Estimation par méthode du périodogramme
    nu=(0:Nfft-1)/(Nfft);
    DSP=DSP/length(DSP);
end