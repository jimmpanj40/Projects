function[pitch, sigma2, Aopt]=BlockAnalysis(X,M,Fe)
    if(~exist("Fe","var"))
        Fe=10000;
    end
    
    if(~exist("M","var"))% Si on n'entre pas M, on l'initialise à 2
        M=2; 
    end
    Cx=estim_auto(X); % Estimateur de l'autocorrélation
    pitch=PitchDetector(Cx,Fe,100,400); %inférieur à 1 ou égal -1
    M=max(1,M+floor(pitch)); % Si on ne déclare pas M, M=2 si le son est voisén sinon, M=2-1=1
    %Si on déclare M, on introduit un max, si le son est voisé, on entre 2 et M=M-2
    %Si on déclare M et que le son est non voisé, on entre 1 et M=1-1 mais le max corrige ce problème et on a M=1
   
        
    [Aopt,sigma2]=YuleWalkerSolver(Cx,M); 
end 