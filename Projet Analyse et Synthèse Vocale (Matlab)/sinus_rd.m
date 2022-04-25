function[s]=sinus_rd(N,fe)
    abscisse=(1:N)/N;
    s=sin(2*pi*fe*abscisse+rand()*2*pi); %sinus à phase aléatoire
end 