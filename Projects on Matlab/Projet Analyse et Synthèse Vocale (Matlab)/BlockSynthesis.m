function[Y]=BlockSynthesis(pitch,sigma2,Aopt,N)
    if pitch==-1
        sig=blanc(N,sigma2); %pitch=-1 => signal non voisé => bruit
    else
        sig=sinus_rd(N,pitch);%pitch>0 => signal voisé => sinus
    end
    Y=filter(Aopt,1,sig); %Signal reconstitué
        
        
end 