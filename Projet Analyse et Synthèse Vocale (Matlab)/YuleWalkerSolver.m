function [a,e] = YuleWalkerSolver(auto,M) %auto: autocorrélation, M: ordre du filtre, a: coefficient du filtre, v: estimation de l'erreur sur la variance
    
    R=toeplitz(auto(1:M)); %matrice symétrique car gamma(p)=conj(gamma(-p)) et coefficient réel
    p=conj(auto(2:M+1)');
    a=R\p; % cofficient de la matrice Aopt
    e=auto(1)-p.'*a; % Variance
end
