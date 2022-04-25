%% SÉANCE I

%% 1. Données sur lesquelles travailler
fe=10.1;
N=256;
sigma2=0.5;

%% 2. Estimateur biaisé d'autocorrélation

% Bruit blanc
b=blanc(N,sigma2); %b suit une loi normale centrée en 0
m_b=estim_moy(b); %estimateur de la moyenne
gamma_b=estim_auto(b);%estimateur de l'autocorrélation

% Sinus à phase aléatoire
s=sinus_rd(N,fe);
m_s=estim_moy(s);
gamma_s=estim_auto(s);

% Filtre AR(1)
a=0.8;
ar_th=[]; %Théorique
for p=1:N
    ar_th=[ar_th sigma2*a^(p-1)/(1-a^2)];
end

ar=AR1(a,b); %%Filtre AR : 1/(1-0.8z-1)=z/(z-0.8)
m_ar=estim_moy(ar);
gamma_ar=estim_auto(ar);



%% 3. Estimateur non biaisé d'autocorrélation

% Bruit blanc
gamma_bnb=estim_nb(b);
% sinus à phase aléatoire
gamma_snb=estim_nb(s);
% filtre AR
gamma_arnb=estim_nb(ar);

%% 4. Etablissement d'un critère pour le caractère voisé

%Génération des signaux voisé et non voisé
[voise,fe2]=audioread("voise_ooo.flac");
[nonvoise,fe3]=audioread("nonvoise_ch.flac");

%Autocorrélation
% On effectue les DSP biaisée et non biaisée pour vérifier nos hypothèses

gamma_voise_nb=estim_nb(voise.');
gamma_voise_b=estim_auto(voise.');

gamma_nonvoise_b=estim_auto(nonvoise.'); %C'est la DSP qui nous permettra de mettre en place le critère de distinction
gamma_nonvoise_nb=estim_nb(nonvoise.'); 

%% Critère "voisé" ou "non voisé"


crit_nonvoise=sum( round(abs(gamma_nonvoise_b/max(gamma_nonvoise_b)))); %Nombre d'échantillon de l'autocorrélation biaisé non du son voisé au dessus de 50% du max
crit_voise= sum( round(abs(gamma_voise_b/max(gamma_voise_b)))); %%Nombre d'échantillon de l'autocorrélation biaisé du son voisé au dessus de 50% du max

%% Test de isVoiced pour plusieurs sons voisés et non voisés
[voise1,fe4]=audioread("voise_oo.flac");
[nonvoise1,fe5]=audioread("nonvoise_hw.flac");
[voise2,fe6]=audioread("voise_nng.flac");
[nonvoise2,fe7]=audioread("nonvoise_th.flac");
a=isVoiced(voise1.');
b=isVoiced(nonvoise1.');
c=isVoiced(voise2.');
d=isVoiced(nonvoise2.');
%% SÉANCE II

%% 1. Données sur lesquelles travailler
Nfft=2*N-1;

%% CORRELOGRAMME

%Bruit blanc
[correlo_b,nu1]=estim_cor(gamma_b,Nfft);
[correlo_bnb,nu1]=estim_cor(gamma_bnb,Nfft);

% sinus à phase aléatoire
s2=sinus_rd(N,N*sqrt(2)/8);

gamma_s2=estim_auto(s2);
gamma_snb2=estim_nb(s2);

[correlo_s,nu2]=estim_cor(gamma_s2,Nfft);
[correlo_snb,nu3]=estim_cor(gamma_snb2/2,Nfft);
% filtre AR1
[correlo_ar,nu4]=estim_cor(gamma_ar,Nfft);
[correlo_arnb,nu4]=estim_cor(gamma_arnb,Nfft);


%% Périodogramme

%Bruit blanc
[perio_b,nu1]=estim_per(b,Nfft);

% sinus à phase aléatoire
s2=sinus_rd(N,N*sqrt(2)/8);

[perio_s,nu2]=estim_per(s2,Nfft);
% filtre AR1
[perio_ar,nu4]=estim_per(ar,Nfft);


%% SÉANCE III

%Résolution des équation de YW
N=256;
nu=10000.1;
sigma22=0.1; %Sigma2 pour cette partie
a=0.8;
%% AR(1)
M=1;
gamma_ar1_th=sigma22*a.^(0:N)/(1-(abs(a))^2);
[ak1,e1]=YuleWalkerSolver(gamma_ar1_th,M);

%% Sinusoïde à phase aléatoire ordre 2
M=2;
gamma_sin=abs(a)^2*cos(2*pi*nu.*[0:N])/2;
[ak2,e2]=YuleWalkerSolver(gamma_sin,M);
%% Sinusoïde à phase aléatoire ordre 3
M=3;
gamma_sin=abs(a)^2*cos(2*pi*nu.*[0:N])/2;
[ak3,e3]=YuleWalkerSolver(gamma_sin,M);


%%
% Réalisation de processus connus

b2=blanc(N,sigma22);
ar2=AR1(a,b2);
gamma_ar2=estim_auto(ar2);

s2=a*sinus_rd(N,nu);
gamma_s2=estim_auto(s2);
%% AR(1)
M=1;
[ak1_exp,e]=YuleWalkerSolver(gamma_ar2,M)

%% Sinusoïde à phase aléatoire ordre 2
M=2;
[ak2_exp,e]=YuleWalkerSolver(gamma_s2,M)

%% Sinusoïde à phase aléatoire ordre 10
M=3;
[ak10_exp,e]=YuleWalkerSolver(gamma_s2,M)

%% Reconstitution 
b2_reconstitue=filter(ak1_exp,1,b2); % AR(1)
s2_reconstitue=filter(ak2_exp,1,s2);  %Sinus à phase aléatoire ordre 2
s2_reconstitue2=filter(ak10_exp,1,s2);  %Sinus à phase aléatoire ordre 10




%% Sons voisés et non voisés

%% Son voisé "nng" 
gamma_nng=estim_auto(voise2.');
[ak_nng,e]=YuleWalkerSolver(gamma_nng,2)
nng_reconstitue=filter(ak_nng,1,voise2); 

%% Son non voisé "hw"
gamma_hw=estim_auto(nonvoise1.');
[ak_hw,e]=YuleWalkerSolver(gamma_hw,1)
hw_reconstitue=filter(ak_hw,1,nonvoise1); 


%% SEANCE IV

N=256;

%% Test de PitchDetector
p=PitchDetector(gamma_voise_b); %Fréquence réduite du son "ooo"

%% Test de BlockAnalysis

% "ooo"
[pitch1,sigma2_1,Aopt1]=BlockAnalysis(voise.');
%"nng"
[pitch2,sigma2_2 ,Aopt2]=BlockAnalysis(voise2.');
%"ch
[pitch3,sigma2_3,Aopt3]=BlockAnalysis(nonvoise.');
%"hw
[pitch4,sigma2_4,Aopt4]=BlockAnalysis(nonvoise1.');

% Test de BlockSynthesis

Y=BlockSynthesis(pitch3,sigma2_3,Aopt3,1024)
%sound(Y2);
%sound(nonvoise)

%% Traitement d'un signal et effets
[fable,fe_fable]=audioread("La_cigale_et_la_fourmi.flac");
fable=fable.';
N_fable=length(fable);
M=256
N_paquet=1024 % Taille des paquets de l'audio à diviser
s_reconstitue=[];
for i=1:(N_fable/1024) %On coupe l'audio en paquet de N_paquet échantillons
    s_fable=fable(i:i+N_paquet);
    [pitch, sigma2, Aopt]=BlockAnalysis(s_fable,M,fe_fable);
    s_reconstitue=[s_reconstitue BlockSynthesis(pitch, sigma2, Aopt,M)];
end

%%