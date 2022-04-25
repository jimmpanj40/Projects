function pitch=PitchDetector(Cx,Fe,Fmin,Fmax)
    N=length(Cx);
    crit=sum(round(abs(Cx/max(Cx)))); %compte le nombre valeur de DSP supérieur à 50% du max
    
    if(~exist("Fe","var"))
        Fe=10000;
    end 
    if(~exist("Fmin","var"))
        Fmin=100;
    end 
    if(~exist("Fmax","var"))
        Fmax=400;
    end 
    if(crit<N/100)
        pitch=-1;
    else 
        Fft=abs(fft(Cx)); % On part part la TFD pour trouver le fondamental de l'autocorrélation
        [value,pitch]=max(Fft); %On passe en fréquence réduite, pitch représente le rang du fondamentale
        pitch=pitch*Fe/N; %on convertit pitch en fréquence en Hz 
        if pitch<Fmin
            pitch=Fmin/Fe; %si pitch est plus petit que Fmin, pitch prend la valeur Fmin. On convertit en fréquence réduite
        else %pareil si pitch est plus quand que Fmax,
            pitch=min(pitch,Fmax)/Fe; % Fréquence réduite comprise entre Fmin et Fmax
        end  
    end    
end 