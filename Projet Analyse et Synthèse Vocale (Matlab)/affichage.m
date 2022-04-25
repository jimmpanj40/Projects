%% SEANCE I
%% Estimateur autocorrélation biaisé: Bruit blanc
stem(gamma_b)
hold on
stem([sigma2 zeros(1,N-1)])
xlabel("Décalage p");
ylabel("Autocorrélation gamma_b(p)");
axis padded
hold off
title("Autocorrélation du bruit blanc gamma_b(p) en fonction du décalage p");
legend('Estimmateur autocorrelation','Autocorrelation théorique')

%% Estimateur autocorrélation biaisé: Sinus à phase aléatoire
abscisse=(1:N)/N % On adapte l'abscisse pour avoir un sinus plus lisse
stem(abscisse,gamma_s)
hold on
stem(abscisse,0.5*cos(2*pi*fe*abscisse))
hold off
xlabel("Décalage p");
ylabel("Autocorrélation gamma_s(p)");
axis padded
title("Autocorrélation du sinus à phase aléatoire gamma_s(p) en fonction du décalage p");
legend('Estimmateur autocorrelation','Autocorrelation théorique')



%% Estimateur autocorrélation biaisé: filtre AR
stem(gamma_ar)
hold on
stem(ar_th)
hold off
xlabel("Décalage p");
ylabel("Autocorrélation gamma_sar(p)");

title("Autocorrélation du signal s filtré gamma_sar(p) en fonction du décalage p");
legend('Estimmateur autocorrelation','Autocorrelation théorique')

%% Estimateur autocorrélation non biaisé: Bruit blanc
stem(gamma_b,'b')
hold on
stem(gamma_bnb,'r')
hold on
stem([sigma2 zeros(1,N-1)],'g')
xlabel("Décalage p");
ylabel("Autocorrélation ");
hold off
title("Autocorrélations du bruit blanc en fonction du décalage p");
legend('Estimmateur autocorrelation biaisée','Estimmateur autocorrelation non biaisée','Autocorrelation théorique')

%% Estimateur autocorrélation non biaisé: Sinus à phase aléatoire
abscisse=(1:N)/N
stem(abscisse,gamma_s,'b')
hold on
stem(abscisse,gamma_snb,'r')
hold on
stem(abscisse,0.5*cos(2*pi*fe*abscisse),'g')
hold off
xlabel("Décalage p");
ylabel("Autocorrélation");
axis padded
title("Autocorrélation du sinus à phase aléatoire en fonction du décalage p");
legend('Estimmateur autocorrelation biaisée','Estimmateur autocorrelation non biaisée','Autocorrelation théorique')

%% Estimateur autocorrélation non biaisé: filtre AR
stem(gamma_ar)
hold on
stem(gamma_arnb)
hold on
stem(ar_th)
hold off
xlabel("Décalage p");
ylabel("Autocorrélation");
title("Autocorrélation du bruit blanc filtré en fonction du décalage p");
legend('Estimmateur autocorrelation biaisée','Estimmateur autocorrelation non biaisée','Autocorrelation théorique')
%% Signaux voisé et non voisé
subplot(211)
plot(1000*(1:length(voise))/fe2,voise); %% Abscisse temporelle
axis([0 40 -1 1])
xlabel("Temps en ms");
ylabel("Son voisé 'O' ");
title("Représentation du son voisé 'o' en fonction du temps ");

subplot(212)
plot(1000*(1:length(nonvoise))/fe3,nonvoise); %% Abscisse temporelle
axis([0 40 -1 1])
xlabel("Temps en ms");
ylabel("Son non voisé 'ch' ");
title("Représentation du son non voisé 'ch' en fonction du temps ");

%% Estimateur autocorrélation non biaisé: signaux voisé et non voisé
subplot(411)
stem(gamma_voise_b); %Autocorrélation biaisé
xlabel("Décalage p");
ylabel("Autocorrélation");
title("Autocorrélation biaisée du son voisé 'o' en fonction du décalage p");

subplot(412)
stem(gamma_voise_nb); %Autocorrélation non biaisé
xlabel("Décalage p");
ylabel("Autocorrélation");
title("Autocorrélation non biaisée du son voisé 'o' en fonction du décalage p");

subplot(413)
stem(gamma_nonvoise_b);%Autocorrélation biaisé
xlabel("Décalage p");
ylabel("Autocorrélation");
title("Autocorrélatio biaisée du son non voisé 'ch' en fonction du décalage p");

subplot(414)
stem(gamma_nonvoise_nb); %Autocorrélation non biaisé
xlabel("Décalage p");
ylabel("Autocorrélation");
title("Autocorrélation non biaisée du son non voisé 'ch' en fonction du décalage p");


%% SEANCE II
%% Corrélogramme : bruit blanc
plot(nu1,abs(correlo_b)) % %Autocorrélation biaisé
hold on
plot(nu1,abs(correlo_bnb)) %%Autocorrélation non biaisé
axis ([0 0.5 0 inf]) % Adaptation de la fenêtre d'observation
hold off
xlabel("Fréquence normalisée");
ylabel("Corrélogramme");
title("Corrélogramme du bruit blanc en fonction de la fréquence normalisée");
legend('Biaisé', 'Non biaisé')
%% Corrélogramme : Sinus à phase aléatoire
plot(nu2,abs(correlo_s)) %Autocorrélation biaisé
hold on 
plot(nu3,abs(correlo_snb)) %Autocorrélation non biaisé
axis ([0 0.5 0 inf])
hold off
xlabel("Fréquence normalisée");
ylabel("Corrélogramme");
title("Corrélogramme du sinus à phase aléatoire en fonction de la fréquence normalisée");
legend('Biaisé', 'Non biaisé')
%% Corrélogramme : filtre AR
plot(nu4,abs(correlo_ar)) %Autocorrélation biaisé
hold on 
plot(nu4,abs(correlo_arnb)) %Autocorrélation non biaisé
axis ([0 0.5 0 inf])
hold off
xlabel("Fréquence normalisée");
ylabel("Corrélogramme");
title("Corrélogramme du filtre AR en fonction de la fréquence normalisée");
legend('Biaisé', 'Non biaisé')
%% Périodogramme : bruit blanc
plot(nu1,abs(correlo_b)) %Autocorrélation biaisé, pas non biaisé on travaille sur le signal réél
axis ([0 0.5 0 inf])
xlabel("Fréquence normalisée");
ylabel("Périodogramme");
title("Périodogramme du bruit blanc en fonction de la fréquence normalisée");
%% Périodogramme : Sinus à phase aléatoire
plot(nu2,abs(perio_s)) %Autocorrélation biaisé
axis ([0 0.5 0 inf])
xlabel("Fréquence normalisée");
ylabel("Périodogramme");
title("Périodogramme du sinus à phase aléatoire en fonction de la fréquence normalisée");

%% Périodogramme : filtre AR
plot(nu4,abs(perio_ar)) %Autocorrélation biaisé
axis ([0 0.5 0 inf])
xlabel("Fréquence normalisée");
ylabel("Périodogramme");
title("Périodogramme du filtre AR en fonction de la fréquence normalisée");

%% SEANCE III

%% Reconstitution 
%% AR(1)
subplot(311) %AR(1)
Nr=length(b2) % longeur des signaux 
plot((1:Nr)/nu,b2_reconstitue) %Signal reconstitué avec abscisse temporelle
hold on
plot((1:Nr)/nu,b2) %Signal réel avec abscisse temporelle
hold off
legend("Bruit reconstitué","Bruit théorique")
axis ([0 0.01 -inf inf])
xlabel("Temps en s")
ylabel("Bruit");
title("Représentation du signal reconstitué par un AR(1)")

subplot(312)
plot((1:Nr)/nu,s2_reconstitue) %Sinusoïde à phase aléatoire ordre 2 reconstitué
hold on
plot((1:Nr)/nu,s2) %Sinusoïde à phase aléatoire ordre 2 réel
hold off
legend("Sinus reconstitué","Sinus théorique")
axis ([0 0.01 -0.8 0.8])
xlabel("Temps en s")
ylabel("Sinus");
title("Représentation du signal reconstitué par un ordre 2")

subplot(313)
plot((1:Nr)/nu,s2_reconstitue2) %Sinusoïde à phase aléatoire ordre 10 
hold on
plot((1:Nr)/nu,s2) 
hold off
legend("Sinus reconstitué","Sinus théorique")
axis ([0 0.01 -0.8 0.8])
xlabel("Temps en s")
ylabel("Sinus");
title("Représentation du signal reconstitué par un ordre 10")

%% Sons voisés et non voisés

%% Son voisé "nng"
N2=length(voise2)

plot((1:N2)/fe6,voise2,"r")  % son voisé "nng" réel
hold on
plot((1:N2)/fe6,nng_reconstitue,"g") %son voisé "nng" reconstitué

hold off
legend("Son 'nng' théorique","Son 'nng' reconstitué par un filtre d'ordre 2")
axis ([0 0.02 -inf inf])
xlabel("Temps en s")
ylabel("Son 'nng'");
title("Représentation du son voisé 'nng' reconstitué par un filtre d'ordre 2 ")

%% Son non voisé "hw"
N1=length(nonvoise1)
plot((1:N1)/fe6,nonvoise1,"r")  %son voisé "nng" réel
hold on
plot((1:N1)/fe6,hw_reconstitue,"b") %son voisé "nng" reconstitué

hold off
legend("Son 'hw' théorique","Son 'hw' reconstitué par un filtre d'ordre 1")
axis ([0 0.02 -inf inf])
xlabel("Temps en s")
ylabel("Son 'hw'");
title("Représentation du son 'hw' reconstitué par un filtre ordre 1")

%% SEANCE IV





