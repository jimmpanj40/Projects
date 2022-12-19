function[zig]= InverseRunLength(Vrlc,n,m)
    i=1; % Parcourt Vrlc
    j=1; %Parcourt zig
    zig=zeros(1,n*m); %On initialise la sortie
    while j<length(zig)
        if Vrlc(i)==257 %Lorsque l'on rencontre le symbole 257
            j=j+Vrlc(i+1); %En incrémentant j de cette manière, on laisse des 0 correspondants à la valeur suivant 257
            i=i+2; % On saute l'élément suivant 257
             % On laisse un nombre de 0 correspondant à la valeur suivant 257
        else
            zig(j)=Vrlc(i); %On recopie si on n'identifie pas 257
            j=j+1;
            i=i+1;
        end
    end   
end
