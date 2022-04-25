function[Vrlc]= RunLength(zig)
    s=0; %s représente le nombre de 0 supprimé
    i=1;
    Vrlc=zig; %Vrlc est égale à la matrice zig à laquelle on a retiré les 0 et remplacé par 257 j avec j le nombre de 0 supprimé
    while i<=length(Vrlc) %On parcourt toute la liste. On utilise un while plutôt qu'un for car la taille de la matrice diminue suivant la suppression des 0
        if Vrlc(i)==0 %Si on a un 0
            if s==0 %si on n'a pas supprimé de 0 précédemment, on ajoute 257 à la liste et on ajoute 1 au compteur s
                Vrlc(i)=257;
                i=i+1; %On avance d'un rang 
            else %si on a s différent de 0, c'est qu'on a déjà supprimé un 0 et que 257 a déjà été introduit dans la liste. Il suffit d'incrémenter le compteur s et de 1 et de supprimé le 0 en question
                Vrlc(i)=[]; %on n'a pas besoin d'avance dans la liste car la suppression du 0 avance la partie de liste de droite vers la gauche d'un rang
            end
            s=s+1; %Dans tous les cas, puisqu'on a eu un 0, on incrémente le compteur s de 1
        else %Si on a pas de 0
            if s==0 %Si s est nul, c'est que la terme d'avant était non nul. Donc on ne change rien à la liste et on avance
                i=i+1;
            else %Si s est non nul, c'est qu'il y avait 1 ou plusieurs 0 précedemment et que la suite de 0 s'est terminé. 
                Vrlc=[Vrlc(1:i-1),s,Vrlc(i:end)]; %On ajoute juste après 257 s qui correspond au compteur de 0 et on réinitialise s
                s=0;
            end
        end 
    end
    %Si zig se termine par 1 ou plusieurs 0, il faut ajouter s à Vlrc car
    %on est en dehors de zig
    if s>0
        Vrlc=[Vrlc,s];
    end
end
