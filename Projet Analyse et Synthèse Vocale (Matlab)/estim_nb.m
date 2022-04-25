function[gamma_nb]=estim_nb(signal)
    gamma=estim_auto(signal);
    N=length(signal);
    gamma_nb=gamma.*(N./(N-(0:(N-1)))); %pris en compte du biais
end
