function [gamma] = estim_auto(an) %%biaisé
    N=length(an); 
    gamma=zeros(1,N); % Initialisation pour éviter des problèmes d'allocations de mémoire
    for i=1:N
        gamma(i)=sum(an(i:N)*an(1:N-i+1)')/N; %Moyenne empirique
    end
end