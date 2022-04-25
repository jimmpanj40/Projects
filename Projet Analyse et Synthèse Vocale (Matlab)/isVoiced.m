function [bool]= isVoiced(signal)
    N=length(signal);
    gamma_s_b=estim_auto(signal); %estimateur de l'autocorrélation
    crit=sum(round(abs(gamma_s_b/max(gamma_s_b)))); %compte le nombre valeur de DSP supérieur à 50% du max
    bool=(crit>N/100); %bool=true si le son est voisé et false si le son est non voisé
end 